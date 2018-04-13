From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Handling of DSP_RUN register
	during fw setup" to the asoc tree
Date: Fri, 13 Apr 2018 12:24:21 +0100
Message-ID: <E1f6woX-0000I7-PH@debutante>
References: <20180409131336.21990-1-robert.rosengren@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D85002675FC
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:24:25 +0200 (CEST)
In-Reply-To: <20180409131336.21990-1-robert.rosengren@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Smith <dannys@axis.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Robert Rosengren <robert.rosengren@axis.com>, Robert Rosengren <robertr@axis.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau17x1: Handling of DSP_RUN register during fw setup

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

>From d0f8b9c5a350ca6fa842b52bfb88b77b34ee485b Mon Sep 17 00:00:00 2001
From: Danny Smith <dannys@axis.com>
Date: Mon, 9 Apr 2018 15:13:35 +0200
Subject: [PATCH] ASoC: adau17x1: Handling of DSP_RUN register during fw setup

DSP_RUN needs to be disabled during firmware write otherwise
we can end up with undefined behavior if writing to a dsp which
is already running firmware.

Signed-off-by: Danny Smith <dannys@axis.com>
Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 26 ++++++++++++++++++++------
 sound/soc/codecs/adau17x1.h |  3 ++-
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 80c2a06285bb..12bf24c26818 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -502,7 +502,7 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (adau->sigmadsp) {
-		ret = adau17x1_setup_firmware(adau, params_rate(params));
+		ret = adau17x1_setup_firmware(component, params_rate(params));
 		if (ret < 0)
 			return ret;
 	}
@@ -835,26 +835,40 @@ bool adau17x1_volatile_register(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
 
-int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
+int adau17x1_setup_firmware(struct snd_soc_component *component,
+	unsigned int rate)
 {
 	int ret;
-	int dspsr;
+	int dspsr, dsp_run;
+	struct adau *adau = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
 	if (ret)
-		return ret;
+		goto err;
+
+	ret = regmap_read(adau->regmap, ADAU17X1_DSP_RUN, &dsp_run);
+	if (ret)
+		goto err;
 
 	regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 1);
 	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, 0xf);
+	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
 
 	ret = sigmadsp_setup(adau->sigmadsp, rate);
 	if (ret) {
 		regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 0);
-		return ret;
+		goto err;
 	}
 	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, dspsr);
+	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, dsp_run);
 
-	return 0;
+err:
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
 
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index a7b1cb770814..e6fe87beec07 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -68,7 +68,8 @@ int adau17x1_resume(struct snd_soc_component *component);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
 
-int adau17x1_setup_firmware(struct adau *adau, unsigned int rate);
+int adau17x1_setup_firmware(struct snd_soc_component *component,
+	unsigned int rate);
 bool adau17x1_has_dsp(struct adau *adau);
 
 #define ADAU17X1_CLOCK_CONTROL			0x4000
-- 
2.17.0
