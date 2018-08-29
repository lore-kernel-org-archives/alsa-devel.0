From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Unused exported functions
	changed to internal" to the asoc tree
Date: Wed, 29 Aug 2018 12:39:37 +0100 (BST)
Message-ID: <20180829113937.91D7C1124859@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5EB26766C
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 13:39:38 +0200 (CEST)
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
To: Robert Rosengren <robert.rosengren@axis.com>
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Robert Rosengren <robertr@axis.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: adau17x1: Unused exported functions changed to internal

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

>From dba508b5ab1d138bd7543a3f503492f1a173aa32 Mon Sep 17 00:00:00 2001
From: Robert Rosengren <robert.rosengren@axis.com>
Date: Mon, 13 Aug 2018 09:33:58 +0200
Subject: [PATCH] ASoC: adau17x1: Unused exported functions changed to internal

adau17x1_setup_firmware and adau17x1_has_dsp is only used internally, so
making them static instead of exported.

Signed-off-by: Robert Rosengren <robertr@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 9 +++++----
 sound/soc/codecs/adau17x1.h | 4 ----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index c0bc429249fa..3959e6ad113d 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -67,6 +67,9 @@ static const struct snd_kcontrol_new adau17x1_controls[] = {
 	SOC_ENUM("Mic Bias Mode", adau17x1_mic_bias_mode_enum),
 };
 
+static int adau17x1_setup_firmware(struct snd_soc_component *component,
+	unsigned int rate);
+
 static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -320,7 +323,7 @@ static const struct snd_soc_dapm_route adau17x1_no_dsp_dapm_routes[] = {
 	{ "Capture", NULL, "Right Decimator" },
 };
 
-bool adau17x1_has_dsp(struct adau *adau)
+static bool adau17x1_has_dsp(struct adau *adau)
 {
 	switch (adau->type) {
 	case ADAU1761:
@@ -331,7 +334,6 @@ bool adau17x1_has_dsp(struct adau *adau)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(adau17x1_has_dsp);
 
 static bool adau17x1_has_safeload(struct adau *adau)
 {
@@ -854,7 +856,7 @@ bool adau17x1_volatile_register(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
 
-int adau17x1_setup_firmware(struct snd_soc_component *component,
+static int adau17x1_setup_firmware(struct snd_soc_component *component,
 	unsigned int rate)
 {
 	int ret;
@@ -898,7 +900,6 @@ int adau17x1_setup_firmware(struct snd_soc_component *component,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
 
 int adau17x1_add_widgets(struct snd_soc_component *component)
 {
diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
index e6fe87beec07..98a3b6f5bc96 100644
--- a/sound/soc/codecs/adau17x1.h
+++ b/sound/soc/codecs/adau17x1.h
@@ -68,10 +68,6 @@ int adau17x1_resume(struct snd_soc_component *component);
 
 extern const struct snd_soc_dai_ops adau17x1_dai_ops;
 
-int adau17x1_setup_firmware(struct snd_soc_component *component,
-	unsigned int rate);
-bool adau17x1_has_dsp(struct adau *adau);
-
 #define ADAU17X1_CLOCK_CONTROL			0x4000
 #define ADAU17X1_PLL_CONTROL			0x4002
 #define ADAU17X1_REC_POWER_MGMT			0x4009
-- 
2.18.0
