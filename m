From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdac_hdmi: Add hdac hdmi dai ops" to
	the asoc tree
Date: Sat, 21 Nov 2015 14:01:02 +0000
Message-ID: <E1a08is-0001AO-Nh@finisterre>
References: <1447161130-24889-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77B3E261740
 for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2015 15:01:26 +0100 (CET)
In-Reply-To: <1447161130-24889-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdac_hdmi: Add hdac hdmi dai ops

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b0362adbeb95b57d9739b0744772eaf9feaa6e5e Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Tue, 10 Nov 2015 18:42:08 +0530
Subject: [PATCH] ASoC: hdac_hdmi: Add hdac hdmi dai ops

The DAI ops are used for triggering HDMI streams and configuring
the parameters

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdac_hdmi.c | 162 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 45dfc4f..f96bd2f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -26,7 +26,10 @@
 #include <sound/hdaudio_ext.h>
 #include "../../hda/local.h"
 
+#define AMP_OUT_MUTE		0xb080
+#define AMP_OUT_UNMUTE		0xb000
 #define PIN_OUT			(AC_PINCTL_OUT_EN)
+
 #define HDA_MAX_CONNECTIONS     32
 
 struct hdac_hdmi_cvt_params {
@@ -67,6 +70,156 @@ static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
 	return container_of(hdac, struct hdac_ext_device, hdac);
 }
 
+static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
+				hda_nid_t cvt_nid, hda_nid_t pin_nid,
+				u32 stream_tag, int format)
+{
+	unsigned int val;
+
+	dev_dbg(&hdac->hdac.dev, "cvt nid %d pnid %d stream %d format 0x%x\n",
+			cvt_nid, pin_nid, stream_tag, format);
+
+	val = (stream_tag << 4);
+
+	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
+				AC_VERB_SET_CHANNEL_STREAMID, val);
+	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
+				AC_VERB_SET_STREAM_FORMAT, format);
+
+	return 0;
+}
+
+static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
+		struct hdac_hdmi_dai_pin_map *dai_map, unsigned int pwr_state)
+{
+	/* Power up pin widget */
+	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->pin.nid, pwr_state))
+		snd_hdac_codec_write(&edev->hdac, dai_map->pin.nid, 0,
+			AC_VERB_SET_POWER_STATE, pwr_state);
+
+	/* Power up converter */
+	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->cvt.nid, pwr_state))
+		snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+			AC_VERB_SET_POWER_STATE, pwr_state);
+}
+
+static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_ext_dma_params *dd;
+
+	if (dai->id > 0) {
+		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
+		return -ENODEV;
+	}
+
+	dai_map = &hdmi->dai_map[dai->id];
+
+	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
+	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
+			dd->stream_tag,	dd->format);
+
+	return hdac_hdmi_setup_stream(hdac, dai_map->cvt.nid, dai_map->pin.nid,
+					dd->stream_tag, dd->format);
+}
+
+static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_ext_dma_params *dd;
+
+	if (dai->id > 0) {
+		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
+		return -ENODEV;
+	}
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	dd->format = snd_hdac_calc_stream_format(params_rate(hparams),
+			params_channels(hparams), params_format(hparams),
+			24, 0);
+
+	snd_soc_dai_set_dma_data(dai, substream, (void *)dd);
+
+	return 0;
+}
+
+static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
+	struct hdac_ext_dma_params *dd;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map;
+
+	dai_map = &hdmi->dai_map[dai->id];
+
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+				AC_VERB_SET_CHANNEL_STREAMID, 0);
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+				AC_VERB_SET_STREAM_FORMAT, 0);
+
+	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+
+	kfree(dd);
+
+	return 0;
+}
+
+static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
+			struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map;
+	int val;
+
+	if (dai->id > 0) {
+		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
+		return -ENODEV;
+	}
+
+	dai_map = &hdmi->dai_map[dai->id];
+
+	val = snd_hdac_codec_read(&hdac->hdac, dai_map->pin.nid, 0,
+					AC_VERB_GET_PIN_SENSE, 0);
+	dev_info(&hdac->hdac.dev, "Val for AC_VERB_GET_PIN_SENSE: %x\n", val);
+
+	if ((!(val & AC_PINSENSE_PRESENCE)) || (!(val & AC_PINSENSE_ELDV))) {
+		dev_err(&hdac->hdac.dev, "Monitor presence invalid with val: %x\n", val);
+		return -ENODEV;
+	}
+
+	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
+
+	snd_hdac_codec_write(&hdac->hdac, dai_map->pin.nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
+	return 0;
+}
+
+static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
+	struct hdac_hdmi_priv *hdmi = hdac->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map;
+
+	dai_map = &hdmi->dai_map[dai->id];
+
+	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
+
+	snd_hdac_codec_write(&hdac->hdac, dai_map->pin.nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+}
+
 static int
 hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 {
@@ -282,6 +435,14 @@ static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.idle_bias_off	= true,
 };
 
+static struct snd_soc_dai_ops hdmi_dai_ops = {
+	.startup = hdac_hdmi_pcm_open,
+	.shutdown = hdac_hdmi_pcm_close,
+	.hw_params = hdac_hdmi_set_hw_params,
+	.prepare = hdac_hdmi_playback_prepare,
+	.hw_free = hdac_hdmi_playback_cleanup,
+};
+
 static struct snd_soc_dai_driver hdmi_dais[] = {
 	{	.name = "intel-hdmi-hif1",
 		.playback = {
@@ -298,6 +459,7 @@ static struct snd_soc_dai_driver hdmi_dais[] = {
 				SNDRV_PCM_FMTBIT_S32_LE,
 
 		},
+		.ops = &hdmi_dai_ops,
 	},
 };
 
-- 
2.6.1
