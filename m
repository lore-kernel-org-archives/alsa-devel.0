From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: Staticise local symbols" to
	the asoc tree
Date: Mon, 13 Jul 2015 12:16:54 +0100
Message-ID: <E1ZEbjC-0006cW-TP@debutante>
References: <1436765205.21490.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B20B5261582
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 13:17:01 +0200 (CEST)
In-Reply-To: <1436765205.21490.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: Staticise local symbols

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

>From 589bef3296317b5507a9a6e2e14fb30dd40ee764 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 13 Jul 2015 13:26:45 +0800
Subject: [PATCH] ASoC: sti-sas: Staticise local symbols

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 4168b88ba3b1..6c0bbe8b495e 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -238,7 +238,7 @@ static int stih416_dac_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("DAC bandgap", STIH416_AUDIO_DAC_CTRL,
 			 STIH416_DAC_NOT_PNDBG_MASK, 0, NULL, 0),
 	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH416_AUDIO_DAC_CTRL,
@@ -248,7 +248,7 @@ const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 };
 
-const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH407_AUDIO_DAC_CTRL,
 			     STIH407_DAC_STANDBY_ANA, 1, NULL, 0),
 	SND_SOC_DAPM_DAC("DAC standby",  "dac_p", STIH407_AUDIO_DAC_CTRL,
@@ -256,13 +256,13 @@ const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 };
 
-const struct snd_soc_dapm_route stih416_sas_route[] = {
+static const struct snd_soc_dapm_route stih416_sas_route[] = {
 	{"DAC Output", NULL, "DAC bandgap"},
 	{"DAC Output", NULL, "DAC standby ana"},
 	{"DAC standby ana", NULL, "DAC standby"},
 };
 
-const struct snd_soc_dapm_route stih407_sas_route[] = {
+static const struct snd_soc_dapm_route stih407_sas_route[] = {
 	{"DAC Output", NULL, "DAC standby ana"},
 	{"DAC standby ana", NULL, "DAC standby"},
 };
@@ -407,21 +407,21 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-const struct snd_soc_dai_ops stih416_dac_ops = {
+static const struct snd_soc_dai_ops stih416_dac_ops = {
 	.set_fmt = sti_sas_dac_set_fmt,
 	.mute_stream = stih416_sas_dac_mute,
 	.prepare = sti_sas_prepare,
 	.set_sysclk = sti_sas_set_sysclk,
 };
 
-const struct snd_soc_dai_ops stih407_dac_ops = {
+static const struct snd_soc_dai_ops stih407_dac_ops = {
 	.set_fmt = sti_sas_dac_set_fmt,
 	.mute_stream = stih407_sas_dac_mute,
 	.prepare = sti_sas_prepare,
 	.set_sysclk = sti_sas_set_sysclk,
 };
 
-const struct regmap_config stih407_sas_regmap = {
+static const struct regmap_config stih407_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
 
@@ -434,7 +434,7 @@ const struct regmap_config stih407_sas_regmap = {
 	.reg_write = sti_sas_write_reg,
 };
 
-const struct regmap_config stih416_sas_regmap = {
+static const struct regmap_config stih416_sas_regmap = {
 	.reg_bits = 32,
 	.val_bits = 32,
 
@@ -447,7 +447,7 @@ const struct regmap_config stih416_sas_regmap = {
 	.reg_write = sti_sas_write_reg,
 };
 
-const struct sti_sas_dev_data stih416_data = {
+static const struct sti_sas_dev_data stih416_data = {
 	.chipid = CHIPID_STIH416,
 	.regmap = &stih416_sas_regmap,
 	.dac_ops = &stih416_dac_ops,
@@ -457,7 +457,7 @@ const struct sti_sas_dev_data stih416_data = {
 	.num_dapm_routes = ARRAY_SIZE(stih416_sas_route),
 };
 
-const struct sti_sas_dev_data stih407_data = {
+static const struct sti_sas_dev_data stih407_data = {
 	.chipid = CHIPID_STIH407,
 	.regmap = &stih407_sas_regmap,
 	.dac_ops = &stih407_dac_ops,
-- 
2.1.4
