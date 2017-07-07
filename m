From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: ELD control corresponds to the PCM stream" to the asoc tree
Date: Fri, 07 Jul 2017 13:52:48 +0100
Message-ID: <E1dTSka-0002sq-DN@finisterre>
References: <87bmoyjteh.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87bmoyjteh.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>Takashi Iwai <tiwai@suse.de>Mark Brown <broonie@kernel.org>Arnaud Pouliquen <arnaud.pouliquen@st.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon <horms@verge.net.au>, PhilippZabel <p.zabel@pengutronix.de>, Colin Ian King <colin.king@canonical.com>, Vincent ABRIOU <vincent.abriou@st.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: ELD control corresponds to the PCM stream

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

>From 1bf985f64465e8d9c752dfaa77044d34c539e419 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jul 2017 00:39:29 +0000
Subject: [PATCH] ASoC: hdmi-codec: ELD control corresponds to the PCM stream

Current hdmi-codec driver is using hdmi_controls for "ELD" control.
But, hdmi-codec driver might be used from many HDMIs. Thus, we need
to correspond device number, otherwise we will receive below error.

        xxx: control x:x:x:ELD:x is already present

This patch registers ELD control in .pcm_new by using
.device = rtd->pcm->device to corresponding to PCM stream.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[Takashi: use snd_ctl_new1()/snd_ctl_add()]
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 22ed0dc88f0a..7686a80861f1 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -399,18 +399,6 @@ static int hdmi_codec_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-
-static const struct snd_kcontrol_new hdmi_controls[] = {
-	{
-		.access = SNDRV_CTL_ELEM_ACCESS_READ |
-			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
-		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = "ELD",
-		.info = hdmi_eld_ctl_info,
-		.get = hdmi_eld_ctl_get,
-	},
-};
-
 static int hdmi_codec_new_stream(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
@@ -668,6 +656,16 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_soc_dai_driver *drv = dai->driver;
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
+	struct snd_kcontrol *kctl;
+	struct snd_kcontrol_new hdmi_eld_ctl = {
+		.access	= SNDRV_CTL_ELEM_ACCESS_READ |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.iface	= SNDRV_CTL_ELEM_IFACE_PCM,
+		.name	= "ELD",
+		.info	= hdmi_eld_ctl_info,
+		.get	= hdmi_eld_ctl_get,
+		.device	= rtd->pcm->device,
+	};
 	int ret;
 
 	dev_dbg(dai->dev, "%s()\n", __func__);
@@ -686,7 +684,12 @@ static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
 	hcp->chmap_info->chmap = hdmi_codec_stereo_chmaps;
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 
-	return 0;
+	/* add ELD ctl with the device number corresponding to the PCM stream */
+	kctl = snd_ctl_new1(&hdmi_eld_ctl, dai->component);
+	if (!kctl)
+		return -ENOMEM;
+
+	return snd_ctl_add(rtd->card->snd_card, kctl);
 }
 
 static struct snd_soc_dai_driver hdmi_i2s_dai = {
@@ -732,8 +735,6 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 
 static struct snd_soc_codec_driver hdmi_codec = {
 	.component_driver = {
-		.controls		= hdmi_controls,
-		.num_controls		= ARRAY_SIZE(hdmi_controls),
 		.dapm_widgets		= hdmi_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
 		.dapm_routes		= hdmi_routes,
-- 
2.13.2
