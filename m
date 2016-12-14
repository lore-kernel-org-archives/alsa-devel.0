From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v2 4/4] ASoC: hdmi-codec: add channel mapping
	control
Date: Wed, 14 Dec 2016 16:16:45 +0100
Message-ID: <1481728605-22781-5-git-send-email-arnaud.pouliquen@st.com>
References: <1481728605-22781-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 11EC326701E
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 16:17:22 +0100 (CET)
In-Reply-To: <1481728605-22781-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, Jyri Sarha <jsarha@ti.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, David Airlie <airlied@linux.ie>, broonie@kernel.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

Add user interface to provide channel mapping.
In a first step this control is read only.

As TLV type, the control provides all configuration available for
HDMI sink(ELD), and provides current channel mapping selected by codec
based on ELD and number of channels specified by user on open.
When control is called before the number of the channel is specified
(i.e. hw_params is set), it returns all channels set to UNKNOWN.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/hdmi-codec.c | 310 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 309 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f27d115..01c837c 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -18,12 +18,131 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/tlv.h>
 #include <sound/pcm_drm_eld.h>
 #include <sound/hdmi-codec.h>
 #include <sound/pcm_iec958.h>
 
 #include <drm/drm_crtc.h> /* This is only to get MAX_ELD_BYTES */
 
+#define HDMI_MAX_SPEAKERS  8
+
+struct hdmi_codec_channel_map_table {
+	unsigned char map;	/* ALSA API channel map position */
+	unsigned long spk_mask;		/* speaker position bit mask */
+};
+
+/*
+ * CEA speaker placement for HDMI 1.4:
+ *
+ *  FL  FLC   FC   FRC   FR   FRW
+ *
+ *                                  LFE
+ *
+ *  RL  RLC   RC   RRC   RR
+ *
+ *  Speaker placement has to be extended to support HDMI 2.0
+ */
+enum hdmi_codec_cea_spk_placement {
+	FL  = BIT(0),	/* Front Left           */
+	FC  = BIT(1),	/* Front Center         */
+	FR  = BIT(2),	/* Front Right          */
+	FLC = BIT(3),	/* Front Left Center    */
+	FRC = BIT(4),	/* Front Right Center   */
+	RL  = BIT(5),	/* Rear Left            */
+	RC  = BIT(6),	/* Rear Center          */
+	RR  = BIT(7),	/* Rear Right           */
+	RLC = BIT(8),	/* Rear Left Center     */
+	RRC = BIT(9),	/* Rear Right Center    */
+	LFE = BIT(10),	/* Low Frequency Effect */
+};
+
+static const struct hdmi_codec_channel_map_table hdmi_codec_map_table[] = {
+	{ SNDRV_CHMAP_FL,	FL },
+	{ SNDRV_CHMAP_FR,	FR },
+	{ SNDRV_CHMAP_RL,	RL },
+	{ SNDRV_CHMAP_RR,	RR },
+	{ SNDRV_CHMAP_LFE,	LFE },
+	{ SNDRV_CHMAP_FC,	FC },
+	{ SNDRV_CHMAP_RLC,	RLC },
+	{ SNDRV_CHMAP_RRC,	RRC },
+	{ SNDRV_CHMAP_RC,	RC },
+	{ SNDRV_CHMAP_FLC,	FLC },
+	{ SNDRV_CHMAP_FRC,	FRC },
+	{} /* terminator */
+};
+
+/*
+ * cea Speaker allocation structure
+ */
+struct hdmi_codec_cea_spk_alloc {
+	const int ca_id;
+	const unsigned long speakers[HDMI_MAX_SPEAKERS];
+
+	/* Derived values, computed during init */
+	unsigned int channels;
+	unsigned long spks_mask;
+	unsigned long spk_na_mask;
+};
+
+/* default HDMI channel maps is stereo */
+const struct snd_pcm_chmap_elem hdmi_codec_stereo_chmaps[] = {
+	{ .channels = 2,
+	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+	{ }
+};
+
+/*
+ * hdmi_codec_channel_alloc: speaker configuration available for CEA
+ *
+ * This is an ordered list!
+ * The preceding ones have better chances to be selected by
+ * hdmi_codec_get_ch_alloc_table_idx().
+ */
+static struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
+{ .ca_id = 0x00,  .speakers = {   0,    0,   0,   0,   0,    0,  FR,  FL } },
+/* 2.1 */
+{ .ca_id = 0x01,  .speakers = {   0,    0,   0,   0,   0,  LFE,  FR,  FL } },
+/* Dolby Surround */
+{ .ca_id = 0x02,  .speakers = {   0,    0,   0,   0,  FC,    0,  FR,  FL } },
+/* surround51 */
+{ .ca_id = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,  FL } },
+/* surround40 */
+{ .ca_id = 0x08,  .speakers = {   0,    0,  RR,  RL,   0,    0,  FR,  FL } },
+/* surround41 */
+{ .ca_id = 0x09,  .speakers = {   0,    0,  RR,  RL,   0,  LFE,  FR,  FL } },
+/* surround50 */
+{ .ca_id = 0x0a,  .speakers = {   0,    0,  RR,  RL,  FC,    0,  FR,  FL } },
+/* 6.1 */
+{ .ca_id = 0x0f,  .speakers = {   0,   RC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+/* surround71 */
+{ .ca_id = 0x13,  .speakers = { RRC,  RLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+
+{ .ca_id = 0x03,  .speakers = {   0,    0,   0,   0,  FC,  LFE,  FR,  FL } },
+{ .ca_id = 0x04,  .speakers = {   0,    0,   0,  RC,   0,    0,  FR,  FL } },
+{ .ca_id = 0x05,  .speakers = {   0,    0,   0,  RC,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x06,  .speakers = {   0,    0,   0,  RC,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x07,  .speakers = {   0,    0,   0,  RC,  FC,  LFE,  FR,  FL } },
+{ .ca_id = 0x0c,  .speakers = {   0,   RC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_id = 0x0d,  .speakers = {   0,   RC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x0e,  .speakers = {   0,   RC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x10,  .speakers = { RRC,  RLC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_id = 0x11,  .speakers = { RRC,  RLC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x12,  .speakers = { RRC,  RLC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x14,  .speakers = { FRC,  FLC,   0,   0,   0,    0,  FR,  FL } },
+{ .ca_id = 0x15,  .speakers = { FRC,  FLC,   0,   0,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x16,  .speakers = { FRC,  FLC,   0,   0,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x17,  .speakers = { FRC,  FLC,   0,   0,  FC,  LFE,  FR,  FL } },
+{ .ca_id = 0x18,  .speakers = { FRC,  FLC,   0,  RC,   0,    0,  FR,  FL } },
+{ .ca_id = 0x19,  .speakers = { FRC,  FLC,   0,  RC,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x1a,  .speakers = { FRC,  FLC,   0,  RC,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x1b,  .speakers = { FRC,  FLC,   0,  RC,  FC,  LFE,  FR,  FL } },
+{ .ca_id = 0x1c,  .speakers = { FRC,  FLC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_id = 0x1d,  .speakers = { FRC,  FLC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_id = 0x1e,  .speakers = { FRC,  FLC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_id = 0x1f,  .speakers = { FRC,  FLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+};
+
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
 	struct snd_soc_dai_driver *daidrv;
@@ -32,6 +151,8 @@ struct hdmi_codec_priv {
 	struct snd_pcm_substream *current_stream;
 	struct snd_pcm_hw_constraint_list ratec;
 	uint8_t eld[MAX_ELD_BYTES];
+	struct snd_pcm_chmap_elem *chmap_tlv;
+	struct snd_pcm_chmap *chmap_info;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -70,6 +191,145 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
+{
+	int i;
+	const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
+		[0] = FL | FR, [1] = LFE, [2] = FC, [3] = RL | RR,
+		[4] = RC, [5] = FLC | FRC, [6] = RLC | RRC,
+	};
+	unsigned long spk_mask;
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_eld_spk_alloc_bits); i++) {
+		if (spk_alloc & (1 << i))
+			spk_mask |= hdmi_codec_eld_spk_alloc_bits[i];
+	}
+
+	return spk_mask;
+}
+
+/* From speaker bit mask to ALSA API channel position */
+static int snd_hdac_spk_to_chmap(int spk)
+{
+	const struct hdmi_codec_channel_map_table *t = hdmi_codec_map_table;
+
+	for (; t->map; t++) {
+		if (t->spk_mask == spk)
+			return t->map;
+	}
+
+	return 0;
+}
+
+/**
+ * hdmi_codec_cea_init_channel_alloc:
+ * Compute derived values in hdmi_codec_channel_alloc[].
+ * spk_na_mask is used to store unused channels in mid of the channel
+ * allocations. These particular channels are then considered as active channels
+ * For instance:
+ *    CA_ID 0x02: CA =  (FL, FR, 0, FC) => spk_na_mask = 0x04, channels = 4
+ *    CA_ID 0x04: CA =  (FL, FR, 0, 0, RC) => spk_na_mask = 0x03C, channels = 5
+ */
+static void hdmi_codec_cea_init_channel_alloc(void)
+{
+	int i, j, k, last;
+	struct hdmi_codec_cea_spk_alloc *p;
+
+	/* Test if not already done by another instance */
+	if (hdmi_codec_channel_alloc[0].channels)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++) {
+		p = hdmi_codec_channel_alloc + i;
+		p->spks_mask = 0;
+		p->spk_na_mask = 0;
+		last = HDMI_MAX_SPEAKERS;
+		for (j = 0, k = 7; j < HDMI_MAX_SPEAKERS; j++, k--) {
+			if (p->speakers[j]) {
+				p->spks_mask |= p->speakers[j];
+				if (last == HDMI_MAX_SPEAKERS)
+					last = j;
+			} else if (last != HDMI_MAX_SPEAKERS) {
+				p->spk_na_mask |= 1 << k;
+			}
+		}
+		p->channels = 8 - last;
+	}
+}
+
+static int hdmi_codec_get_ch_alloc_table_idx(struct hdmi_codec_priv *hcp,
+					     unsigned char channels)
+{
+	int i;
+	u8 spk_alloc;
+	unsigned long spk_mask;
+	struct hdmi_codec_cea_spk_alloc *cap = hdmi_codec_channel_alloc;
+
+	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
+	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++, cap++) {
+		if (cap->channels != channels)
+			continue;
+		if (!(cap->spks_mask == (spk_mask & cap->spks_mask)))
+			continue;
+		return i;
+	}
+
+	return -EINVAL;
+}
+
+static void hdmi_cea_alloc_to_tlv_spks(struct hdmi_codec_cea_spk_alloc *cap,
+				       unsigned char *chmap)
+{
+	int count = 0;
+	int c, spk;
+
+	/* Detect unused channels in cea caps, tag them as N/A channel in TLV */
+	for (c = 0; c < HDMI_MAX_SPEAKERS; c++) {
+		spk = cap->speakers[7 - c];
+		if (cap->spk_na_mask & BIT(c))
+			chmap[count++] = SNDRV_CHMAP_NA;
+		else
+			chmap[count++] = snd_hdac_spk_to_chmap(spk);
+	}
+}
+
+static void hdmi_cea_alloc_to_tlv_chmap(struct hdmi_codec_priv *hcp,
+					struct hdmi_codec_cea_spk_alloc *cap)
+{
+	unsigned int chs, count = 0;
+	struct snd_pcm_chmap *info = hcp->chmap_info;
+	struct snd_pcm_chmap_elem *chmap = info->chmap;
+	unsigned long max_chs = info->max_channels;
+	int num_ca = ARRAY_SIZE(hdmi_codec_channel_alloc);
+	int spk_alloc, spk_mask;
+
+	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
+	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
+
+	for (chs = 2; chs <= max_chs; chs++) {
+		int i;
+		struct hdmi_codec_cea_spk_alloc *cap;
+
+		cap = hdmi_codec_channel_alloc;
+		for (i = 0; i < num_ca; i++, cap++) {
+			if (cap->channels != chs)
+				continue;
+
+			if (!(cap->spks_mask == (spk_mask & cap->spks_mask)))
+				continue;
+
+			chmap[count].channels = cap->channels;
+			hdmi_cea_alloc_to_tlv_spks(cap, chmap[count].map);
+			count++;
+		}
+	}
+
+	/* Force last one to 0 to indicate end of available allocations */
+	chmap[count].channels = 0;
+}
+
 static const struct snd_kcontrol_new hdmi_controls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ |
@@ -164,7 +424,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 			.dig_subframe = { 0 },
 		}
 	};
-	int ret;
+	int ret, idx;
 
 	dev_dbg(dai->dev, "%s() width %d rate %d channels %d\n", __func__,
 		params_width(params), params_rate(params),
@@ -191,6 +451,16 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 	hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
 	hp.cea.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
 
+	/* Select a channel allocation that matches with ELD and pcm channels */
+	idx = hdmi_codec_get_ch_alloc_table_idx(hcp, hp.cea.channels);
+	if (idx < 0) {
+		dev_err(dai->dev, "Not able to map channels to speakers (%d)\n",
+			idx);
+		return idx;
+	}
+	hp.cea.channel_allocation = hdmi_codec_channel_alloc[idx].ca_id;
+	hdmi_cea_alloc_to_tlv_chmap(hcp, &hdmi_codec_channel_alloc[idx]);
+
 	hp.sample_width = params_width(params);
 	hp.sample_rate = params_rate(params);
 	hp.channels = params_channels(params);
@@ -319,6 +589,36 @@ static const struct snd_soc_dai_ops hdmi_dai_ops = {
 			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE |\
 			 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE)
 
+static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			      struct snd_soc_dai *dai)
+{
+	struct snd_soc_dai_driver *drv = dai->driver;
+	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	dev_dbg(dai->dev, "%s()\n", __func__);
+
+	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				      NULL, drv->playback.channels_max, 0,
+				      &hcp->chmap_info);
+	if (ret < 0)
+		return ret;
+
+	hcp->chmap_tlv = devm_kcalloc(dai->dev,
+				      ARRAY_SIZE(hdmi_codec_channel_alloc),
+				      sizeof(*hcp->chmap_tlv), GFP_KERNEL);
+	if (!hcp->chmap_tlv)
+		return -ENOMEM;
+
+	/* Initialize mapping to stereo as default config supported */
+	memcpy(hcp->chmap_tlv, hdmi_codec_stereo_chmaps,
+	       ARRAY_SIZE(hdmi_codec_stereo_chmaps) * sizeof(*hcp->chmap_tlv));
+
+	hcp->chmap_info->chmap = hcp->chmap_tlv;
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver hdmi_i2s_dai = {
 	.name = "i2s-hifi",
 	.id = DAI_ID_I2S,
@@ -331,6 +631,7 @@ static struct snd_soc_dai_driver hdmi_i2s_dai = {
 		.sig_bits = 24,
 	},
 	.ops = &hdmi_dai_ops,
+	.pcm_new = hdmi_codec_pcm_new,
 };
 
 static const struct snd_soc_dai_driver hdmi_spdif_dai = {
@@ -344,6 +645,7 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 		.formats = SPDIF_FORMATS,
 	},
 	.ops = &hdmi_dai_ops,
+	.pcm_new = hdmi_codec_pcm_new,
 };
 
 static struct snd_soc_codec_driver hdmi_codec = {
@@ -399,6 +701,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
+	hdmi_codec_cea_init_channel_alloc();
+
 	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
 				     dai_count);
 	if (ret) {
@@ -413,6 +717,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
+	struct hdmi_codec_priv *hcp;
+
+	hcp = dev_get_drvdata(&pdev->dev);
+	kfree(hcp->chmap_info);
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
-- 
1.9.1
