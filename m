From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 2/2] ASoC: hdmi-codec: add channel mapping
	control
Date: Thu, 8 Dec 2016 17:37:47 +0100
Message-ID: <1481215067-19362-3-git-send-email-arnaud.pouliquen@st.com>
References: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2FC2674F2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 17:37:55 +0100 (CET)
In-Reply-To: <1481215067-19362-1-git-send-email-arnaud.pouliquen@st.com>
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

As TLV type, the control provides all configurations available for
HDMI sink(ELD), and provides current channel mapping selected by codec
based on ELD and number of channels specified by user on open.
When control is called before the number of the channel is specified
(i.e. hw_params is set), it returns all channels set to UNKNOWN.

Notice that SNDRV_CTL_TLVT_CHMAP_FIXED is used for all mappings,
as no information is available from HDMI driver to allow channel swapping.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/hdmi-codec.c | 346 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 345 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f27d115..0cb83a3 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -18,12 +18,137 @@
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
+	FL  = (1 <<  0),	/* Front Left           */
+	FC  = (1 <<  1),	/* Front Center         */
+	FR  = (1 <<  2),	/* Front Right          */
+	FLC = (1 <<  3),	/* Front Left Center    */
+	FRC = (1 <<  4),	/* Front Right Center   */
+	RL  = (1 <<  5),	/* Rear Left            */
+	RC  = (1 <<  6),	/* Rear Center          */
+	RR  = (1 <<  7),	/* Rear Right           */
+	RLC = (1 <<  8),	/* Rear Left Center     */
+	RRC = (1 <<  9),	/* Rear Right Center    */
+	LFE = (1 << 10),	/* Low Frequency Effect */
+};
+
+/*
+ * ELD Speaker allocation bits in the CEA Speaker Allocation data block
+ */
+static int hdmi_codec_eld_spk_alloc_bits[] = {
+	[0] = FL | FR,
+	[1] = LFE,
+	[2] = FC,
+	[3] = RL | RR,
+	[4] = RC,
+	[5] = FLC | FRC,
+	[6] = RLC | RRC,
+};
+
+struct hdmi_codec_channel_map_table {
+	unsigned char map;	/* ALSA API channel map position */
+	int spk_mask;		/* speaker position bit mask */
+};
+
+static struct hdmi_codec_channel_map_table hdmi_codec_map_table[] = {
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
+	int ca_index;
+	int speakers[HDMI_MAX_SPEAKERS];
+
+	/* Derived values, computed during init */
+	int channels;
+	int spk_mask;
+	int spk_na_mask;
+};
+
+/*
+ * This is an ordered list!
+ *
+ * The preceding ones have better chances to be selected by
+ * hdmi_channel_allocation().
+ */
+static struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
+/*			  channel:   7     6    5    4    3     2    1    0  */
+{ .ca_index = 0x00,  .speakers = {   0,    0,   0,   0,   0,    0,  FR,  FL } },
+				 /* 2.1 */
+{ .ca_index = 0x01,  .speakers = {   0,    0,   0,   0,   0,  LFE,  FR,  FL } },
+				 /* Dolby Surround */
+{ .ca_index = 0x02,  .speakers = {   0,    0,   0,   0,  FC,    0,  FR,  FL } },
+				 /* surround51 */
+{ .ca_index = 0x0b,  .speakers = {   0,    0,  RR,  RL,  FC,  LFE,  FR,  FL } },
+				 /* surround40 */
+{ .ca_index = 0x08,  .speakers = {   0,    0,  RR,  RL,   0,    0,  FR,  FL } },
+				 /* surround41 */
+{ .ca_index = 0x09,  .speakers = {   0,    0,  RR,  RL,   0,  LFE,  FR,  FL } },
+				 /* surround50 */
+{ .ca_index = 0x0a,  .speakers = {   0,    0,  RR,  RL,  FC,    0,  FR,  FL } },
+				 /* 6.1 */
+{ .ca_index = 0x0f,  .speakers = {   0,   RC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+				 /* surround71 */
+{ .ca_index = 0x13,  .speakers = { RRC,  RLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+
+{ .ca_index = 0x03,  .speakers = {   0,    0,   0,   0,  FC,  LFE,  FR,  FL } },
+{ .ca_index = 0x04,  .speakers = {   0,    0,   0,  RC,   0,    0,  FR,  FL } },
+{ .ca_index = 0x05,  .speakers = {   0,    0,   0,  RC,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x06,  .speakers = {   0,    0,   0,  RC,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x07,  .speakers = {   0,    0,   0,  RC,  FC,  LFE,  FR,  FL } },
+{ .ca_index = 0x0c,  .speakers = {   0,   RC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_index = 0x0d,  .speakers = {   0,   RC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x0e,  .speakers = {   0,   RC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x10,  .speakers = { RRC,  RLC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_index = 0x11,  .speakers = { RRC,  RLC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x12,  .speakers = { RRC,  RLC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x14,  .speakers = { FRC,  FLC,   0,   0,   0,    0,  FR,  FL } },
+{ .ca_index = 0x15,  .speakers = { FRC,  FLC,   0,   0,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x16,  .speakers = { FRC,  FLC,   0,   0,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x17,  .speakers = { FRC,  FLC,   0,   0,  FC,  LFE,  FR,  FL } },
+{ .ca_index = 0x18,  .speakers = { FRC,  FLC,   0,  RC,   0,    0,  FR,  FL } },
+{ .ca_index = 0x19,  .speakers = { FRC,  FLC,   0,  RC,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x1a,  .speakers = { FRC,  FLC,   0,  RC,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x1b,  .speakers = { FRC,  FLC,   0,  RC,  FC,  LFE,  FR,  FL } },
+{ .ca_index = 0x1c,  .speakers = { FRC,  FLC,  RR,  RL,   0,    0,  FR,  FL } },
+{ .ca_index = 0x1d,  .speakers = { FRC,  FLC,  RR,  RL,   0,  LFE,  FR,  FL } },
+{ .ca_index = 0x1e,  .speakers = { FRC,  FLC,  RR,  RL,  FC,    0,  FR,  FL } },
+{ .ca_index = 0x1f,  .speakers = { FRC,  FLC,  RR,  RL,  FC,  LFE,  FR,  FL } },
+};
+
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
 	struct snd_soc_dai_driver *daidrv;
@@ -32,6 +157,7 @@ struct hdmi_codec_priv {
 	struct snd_pcm_substream *current_stream;
 	struct snd_pcm_hw_constraint_list ratec;
 	uint8_t eld[MAX_ELD_BYTES];
+	unsigned int chmap[HDMI_MAX_SPEAKERS];
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -70,6 +196,201 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hdmi_codec_chmap_ctl_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = HDMI_MAX_SPEAKERS;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SNDRV_CHMAP_LAST;
+
+	return 0;
+}
+
+static int hdmi_codec_spk_mask_from_alloc(int spk_alloc)
+{
+	int i;
+	int spk_mask = hdmi_codec_eld_spk_alloc_bits[0];
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_eld_spk_alloc_bits); i++) {
+		if (spk_alloc & (1 << i))
+			spk_mask |= hdmi_codec_eld_spk_alloc_bits[i];
+	}
+
+	return spk_mask;
+}
+
+static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int i;
+
+	memset(ucontrol->value.integer.value, 0,
+	       sizeof(ucontrol->value.integer.value));
+
+	mutex_lock(&hcp->current_stream_lock);
+	if (hcp->current_stream)
+		for (i = 0; i < HDMI_MAX_SPEAKERS; i++)
+			ucontrol->value.integer.value[i] = hcp->chmap[i];
+
+	mutex_unlock(&hcp->current_stream_lock);
+
+	return 0;
+}
+
+/* From speaker bit mask to ALSA API channel position */
+static int snd_hdac_spk_to_chmap(int spk)
+{
+	struct hdmi_codec_channel_map_table *t = hdmi_codec_map_table;
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
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++) {
+		p = hdmi_codec_channel_alloc + i;
+		p->spk_mask = 0;
+		p->spk_na_mask = 0;
+		last = HDMI_MAX_SPEAKERS;
+		for (j = 0, k = 7; j < HDMI_MAX_SPEAKERS; j++, k--) {
+			if (p->speakers[j]) {
+				p->spk_mask |= p->speakers[j];
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
+	int i, spk_alloc, spk_mask;
+	struct hdmi_codec_cea_spk_alloc *cap = hdmi_codec_channel_alloc;
+
+	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
+	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_codec_channel_alloc); i++, cap++) {
+		if (cap->channels != channels)
+			continue;
+		if (!(cap->spk_mask == (spk_mask & cap->spk_mask)))
+			continue;
+		return i;
+	}
+
+	return -EINVAL;
+}
+
+static void hdmi_cea_alloc_to_tlv_chmap(struct hdmi_codec_cea_spk_alloc *cap,
+					unsigned int *chmap)
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
+static int hdmi_codec_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+				    unsigned int size, unsigned int __user *tlv)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	unsigned int __user *dst;
+	int chs, count = 0;
+	int num_ca = ARRAY_SIZE(hdmi_codec_channel_alloc);
+	unsigned long max_chs;
+	int spk_alloc, spk_mask;
+
+	if (size < 8)
+		return -ENOMEM;
+
+	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
+		return -EFAULT;
+	size -= 8;
+	dst = tlv + 2;
+
+	spk_alloc = drm_eld_get_spk_alloc(hcp->eld);
+	spk_mask = hdmi_codec_spk_mask_from_alloc(spk_alloc);
+
+	max_chs = hweight_long(spk_mask);
+
+	for (chs = 2; chs <= max_chs; chs++) {
+		int i;
+		struct hdmi_codec_cea_spk_alloc *cap;
+
+		cap = hdmi_codec_channel_alloc;
+		for (i = 0; i < num_ca; i++, cap++) {
+			int chs_bytes = chs * 4;
+			unsigned int tlv_chmap[HDMI_MAX_SPEAKERS];
+
+			if (cap->channels != chs)
+				continue;
+
+			if (!(cap->spk_mask == (spk_mask & cap->spk_mask)))
+				continue;
+
+			/*
+			 * Channel mapping is fixed as hdmi codec capability
+			 * is not know.
+			 */
+			if (put_user(SNDRV_CTL_TLVT_CHMAP_FIXED, dst) ||
+			    put_user(chs_bytes, dst + 1))
+				return -EFAULT;
+
+			dst += 2;
+			size -= 8;
+			count += 8;
+
+			if (size < chs_bytes)
+				return -ENOMEM;
+
+			size -= chs_bytes;
+			count += chs_bytes;
+			hdmi_cea_alloc_to_tlv_chmap(cap, tlv_chmap);
+
+			if (copy_to_user(dst, tlv_chmap, chs_bytes))
+				return -EFAULT;
+			dst += chs;
+		}
+	}
+
+	if (put_user(count, tlv + 1))
+		return -EFAULT;
+
+	return 0;
+}
+
 static const struct snd_kcontrol_new hdmi_controls[] = {
 	{
 		.access = SNDRV_CTL_ELEM_ACCESS_READ |
@@ -79,6 +400,17 @@ static const struct snd_kcontrol_new hdmi_controls[] = {
 		.info = hdmi_eld_ctl_info,
 		.get = hdmi_eld_ctl_get,
 	},
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			  SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+			  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "Playback Channel Map",
+		.info = hdmi_codec_chmap_ctl_info,
+		.get = hdmi_codec_chmap_ctl_get,
+		.tlv.c = hdmi_codec_chmap_ctl_tlv,
+	},
 };
 
 static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
@@ -164,7 +496,7 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 			.dig_subframe = { 0 },
 		}
 	};
-	int ret;
+	int ret, idx;
 
 	dev_dbg(dai->dev, "%s() width %d rate %d channels %d\n", __func__,
 		params_width(params), params_rate(params),
@@ -191,6 +523,16 @@ static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
 	hp.cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
 	hp.cea.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
 
+	/* Select a channel allocation that matches with ELD and pcm channels */
+	idx = hdmi_codec_get_ch_alloc_table_idx(hcp, hp.cea.channels);
+	if (idx < 0) {
+		dev_err(dai->dev, "Not able to map channels to speakers (%d)\n",
+			ret);
+		return idx;
+	}
+	hp.cea.channel_allocation = hdmi_codec_channel_alloc[idx].ca_index;
+	hdmi_cea_alloc_to_tlv_chmap(&hdmi_codec_channel_alloc[idx], hcp->chmap);
+
 	hp.sample_width = params_width(params);
 	hp.sample_rate = params_rate(params);
 	hp.channels = params_channels(params);
@@ -407,6 +749,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	hdmi_codec_cea_init_channel_alloc();
+
 	dev_set_drvdata(dev, hcp);
 	return 0;
 }
-- 
1.9.1
