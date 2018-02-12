From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cq93vc: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:34:36 +0000
Message-ID: <E1elDJc-0003jB-KV@debutante>
References: <87fu6puvil.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC967267838
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:34:38 +0100 (CET)
In-Reply-To: <87fu6puvil.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cq93vc: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4f404f38c92b13815722dd6e808dde24cd65eed5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:42:49 +0000
Subject: [PATCH] ASoC: cq93vc: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cq93vc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 3bf93652bb31..3301861d3502 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -45,7 +45,7 @@ static const struct snd_kcontrol_new cq93vc_snd_controls[] = {
 
 static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u8 reg;
 
 	if (mute)
@@ -53,7 +53,7 @@ static int cq93vc_mute(struct snd_soc_dai *dai, int mute)
 	else
 		reg = 0;
 
-	snd_soc_update_bits(codec, DAVINCI_VC_REG09, DAVINCI_VC_REG09_MUTE,
+	snd_soc_component_update_bits(component, DAVINCI_VC_REG09, DAVINCI_VC_REG09_MUTE,
 			    reg);
 
 	return 0;
@@ -72,23 +72,23 @@ static int cq93vc_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return -EINVAL;
 }
 
-static int cq93vc_set_bias_level(struct snd_soc_codec *codec,
+static int cq93vc_set_bias_level(struct snd_soc_component *component,
 				enum snd_soc_bias_level level)
 {
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		snd_soc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_component_write(component, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_ON);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_component_write(component, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_OFF);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* force all power off */
-		snd_soc_write(codec, DAVINCI_VC_REG12,
+		snd_soc_component_write(component, DAVINCI_VC_REG12,
 			     DAVINCI_VC_REG12_POWER_ALL_OFF);
 		break;
 	}
@@ -130,24 +130,25 @@ static int cq93vc_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
-	.set_bias_level = cq93vc_set_bias_level,
-	.component_driver = {
-		.probe = cq93vc_probe,
-		.controls = cq93vc_snd_controls,
-		.num_controls = ARRAY_SIZE(cq93vc_snd_controls),
-	},
+static const struct snd_soc_component_driver soc_component_dev_cq93vc = {
+	.set_bias_level		= cq93vc_set_bias_level,
+	.probe			= cq93vc_probe,
+	.controls		= cq93vc_snd_controls,
+	.num_controls		= ARRAY_SIZE(cq93vc_snd_controls),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int cq93vc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_cq93vc, &cq93vc_dai, 1);
+	return devm_snd_soc_register_component(&pdev->dev,
+			&soc_component_dev_cq93vc, &cq93vc_dai, 1);
 }
 
 static int cq93vc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
-- 
2.16.1
