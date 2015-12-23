From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Provide basic hookup for voice
	control" to the asoc tree
Date: Wed, 23 Dec 2015 00:23:23 +0000
Message-ID: <E1aBXD9-0000YM-MZ@debutante>
References: <1450115609-14094-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06C9A2660EE
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:30 +0100 (CET)
In-Reply-To: <1450115609-14094-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5110: Provide basic hookup for voice control

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

>From 1d981e0a5af78339d55085041c6eb3b9a8626920 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 15 Dec 2015 11:29:42 +0000
Subject: [PATCH] ASoC: wm5110: Provide basic hookup for voice control

Register a platform driver for the CODEC and add DAIs that will be used
to connect a compressed record path for the voice control functionality.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig   |  1 +
 sound/soc/codecs/arizona.h |  2 +-
 sound/soc/codecs/wm5110.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 55e14a3ed5e1..4f482f7b63fc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -214,6 +214,7 @@ config SND_SOC_WM_HUBS
 
 config SND_SOC_WM_ADSP
 	tristate
+	select SND_SOC_COMPRESS
 	default y if SND_SOC_CS47L24=y
 	default y if SND_SOC_WM5102=y
 	default y if SND_SOC_WM5110=y
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index b4f1867ae9d6..8b6adb5419bb 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -57,7 +57,7 @@
 #define ARIZONA_CLK_98MHZ  5
 #define ARIZONA_CLK_147MHZ 6
 
-#define ARIZONA_MAX_DAI  6
+#define ARIZONA_MAX_DAI  8
 #define ARIZONA_MAX_ADSP 4
 
 #define ARIZONA_DVFS_SR1_RQ	0x001
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e93e5420943e..67d56511699a 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1810,6 +1810,9 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "Slim2 Capture", NULL, "SYSCLK" },
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
+	{ "Voice Control DSP", NULL, "DSP3" },
+	{ "Voice Control DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -2132,6 +2135,27 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		 },
 		.ops = &arizona_simple_dai_ops,
 	},
+	{
+		.name = "wm5110-cpu-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control CPU",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "wm5110-dsp-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control DSP",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+	},
 };
 
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
@@ -2224,6 +2248,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.num_dapm_routes = ARRAY_SIZE(wm5110_dapm_routes),
 };
 
+static struct snd_compr_ops wm5110_compr_ops = {
+};
+
+static struct snd_soc_platform_driver wm5110_compr_platform = {
+	.compr_ops = &wm5110_compr_ops,
+};
+
 static int wm5110_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -2284,8 +2315,21 @@ static int wm5110_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
+	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
+		goto error;
+	}
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
 				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		snd_soc_unregister_platform(&pdev->dev);
+	}
+
+error:
+	return ret;
 }
 
 static int wm5110_remove(struct platform_device *pdev)
-- 
2.6.2
