From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun8i-codec-analog: split out mbias" to
	the asoc tree
Date: Wed, 24 May 2017 18:02:59 +0100
Message-ID: <E1dDZgZ-0008S2-DO@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9152A26680F
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:03:10 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun8i-codec-analog: split out mbias

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

>From b08a20f58d2efcd88bf5276e34cd4020028accb7 Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <icenowy@aosc.xyz>
Date: Wed, 24 May 2017 18:05:59 +0800
Subject: [PATCH] ASoC: sun8i-codec-analog: split out mbias

Allwinner V3s features an analog codec without MBIAS pin.

Split out this part, in order to prepare for the V3s analog codec.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 6c17c99c2c8d..edcc3eb7cd9a 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -289,11 +289,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	/* Microphone input */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
-	/* Microphone Bias */
-	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
-			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
-			    0, NULL, 0),
-
 	/* Mic input path */
 	SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
 			 SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
@@ -453,6 +448,27 @@ static int sun8i_codec_add_headphone(struct snd_soc_component *cmpnt)
 	return 0;
 }
 
+/* mbias specific widget */
+static const struct snd_soc_dapm_widget sun8i_codec_mbias_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
+			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
+			    0, NULL, 0),
+};
+
+static int sun8i_codec_add_mbias(struct snd_soc_component *cmpnt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
+	struct device *dev = cmpnt->dev;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_mbias_widgets,
+					ARRAY_SIZE(sun8i_codec_mbias_widgets));
+	if (ret)
+		dev_err(dev, "Failed to add MBIAS DAPM widgets: %d\n", ret);
+
+	return ret;
+}
+
 /* hmic specific widget */
 static const struct snd_soc_dapm_widget sun8i_codec_hmic_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("HBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
@@ -679,6 +695,7 @@ struct sun8i_codec_analog_quirks {
 	bool has_hmic;
 	bool has_linein;
 	bool has_lineout;
+	bool has_mbias;
 	bool has_mic2;
 };
 
@@ -686,12 +703,14 @@ static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
 	.has_headphone	= true,
 	.has_hmic	= true,
 	.has_linein	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
 	.has_linein	= true,
 	.has_lineout	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
@@ -734,6 +753,12 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 			return ret;
 	}
 
+	if (quirks->has_mbias) {
+		ret = sun8i_codec_add_mbias(cmpnt);
+		if (ret)
+			return ret;
+	}
+
 	if (quirks->has_mic2) {
 		ret = sun8i_codec_add_mic2(cmpnt);
 		if (ret)
-- 
2.11.0
