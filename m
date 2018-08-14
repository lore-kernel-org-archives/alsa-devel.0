From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: adau17x1: Unused exported functions
	changed to internal" to the asoc tree
Date: Tue, 14 Aug 2018 16:23:24 +0100 (BST)
Message-ID: <20180814152324.E40351124449@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 79ACF2677A8
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 17:23:25 +0200 (CEST)
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

>From 164c0f6454186d1b0e22c27dfe3d3d59fc80f979 Mon Sep 17 00:00:00 2001
From: Robert Rosengren <robert.rosengren@axis.com>
Date: Mon, 13 Aug 2018 09:33:58 +0200
Subject: [PATCH] ASoC: adau17x1: Unused exported functions changed to internal

adau17x1_setup_firmware and adau17x1_has_dsp is only used internally, so
making them static instead of exported.

Change-Id: I4882513ab457966b0371ac2c1024550ca6edbe0c
Signed-off-by: Robert Rosengren <robertr@axis.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau17x1.c | 9 +++++----
 sound/soc/codecs/adau17x1.h | 4 ----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 57169b8ff14e..2f2afb4c0c88 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -60,6 +60,9 @@ static const struct snd_kcontrol_new adau17x1_controls[] = {
 	SOC_ENUM("Mic Bias Mode", adau17x1_mic_bias_mode_enum),
 };
 
+static int adau17x1_setup_firmware(struct snd_soc_component *component,
+	unsigned int rate);
+
 static int adau17x1_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -313,7 +316,7 @@ static const struct snd_soc_dapm_route adau17x1_no_dsp_dapm_routes[] = {
 	{ "Capture", NULL, "Right Decimator" },
 };
 
-bool adau17x1_has_dsp(struct adau *adau)
+static bool adau17x1_has_dsp(struct adau *adau)
 {
 	switch (adau->type) {
 	case ADAU1761:
@@ -324,7 +327,6 @@ bool adau17x1_has_dsp(struct adau *adau)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(adau17x1_has_dsp);
 
 static int adau17x1_set_dai_pll(struct snd_soc_dai *dai, int pll_id,
 	int source, unsigned int freq_in, unsigned int freq_out)
@@ -836,7 +838,7 @@ bool adau17x1_volatile_register(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
 
-int adau17x1_setup_firmware(struct snd_soc_component *component,
+static int adau17x1_setup_firmware(struct snd_soc_component *component,
 	unsigned int rate)
 {
 	int ret;
@@ -880,7 +882,6 @@ int adau17x1_setup_firmware(struct snd_soc_component *component,
 
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
