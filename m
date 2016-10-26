From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti-sas: clean legacy in sti-sas" to
	the asoc tree
Date: Wed, 26 Oct 2016 11:46:00 +0100
Message-ID: <E1bzLia-0005Le-D9@debutante>
References: <1477320177-30130-6-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E921266875
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:07 +0200 (CEST)
In-Reply-To: <1477320177-30130-6-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti-sas: clean legacy in sti-sas

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

>From 165a57a3df0206b5609502d37e907944d8eb06ee Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:55 +0200
Subject: [PATCH] ASoC: sti-sas: clean legacy in sti-sas

stih416 is no more supported, clean associated code.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sti-sas.c | 169 ++++-----------------------------------------
 1 file changed, 15 insertions(+), 154 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 7b31ee9b82bc..1488f4fb1c5e 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -14,28 +14,8 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-/* chipID supported */
-#define CHIPID_STIH416 0
-#define CHIPID_STIH407 1
-
 /* DAC definitions */
 
-/* stih416 DAC registers */
-/* sysconf 2517: Audio-DAC-Control */
-#define STIH416_AUDIO_DAC_CTRL 0x00000814
-/* sysconf 2519: Audio-Gue-Control */
-#define STIH416_AUDIO_GLUE_CTRL 0x0000081C
-
-#define STIH416_DAC_NOT_STANDBY	0x3
-#define STIH416_DAC_SOFTMUTE	0x4
-#define STIH416_DAC_ANA_NOT_PWR	0x5
-#define STIH416_DAC_NOT_PNDBG	0x6
-
-#define STIH416_DAC_NOT_STANDBY_MASK	BIT(STIH416_DAC_NOT_STANDBY)
-#define STIH416_DAC_SOFTMUTE_MASK	BIT(STIH416_DAC_SOFTMUTE)
-#define STIH416_DAC_ANA_NOT_PWR_MASK	BIT(STIH416_DAC_ANA_NOT_PWR)
-#define STIH416_DAC_NOT_PNDBG_MASK	BIT(STIH416_DAC_NOT_PNDBG)
-
 /* stih407 DAC registers */
 /* sysconf 5041: Audio-Gue-Control */
 #define STIH407_AUDIO_GLUE_CTRL 0x000000A4
@@ -63,14 +43,9 @@ enum {
 	STI_SAS_DAI_ANALOG_OUT,
 };
 
-static const struct reg_default stih416_sas_reg_defaults[] = {
-	{ STIH407_AUDIO_GLUE_CTRL, 0x00000040 },
-	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
-};
-
 static const struct reg_default stih407_sas_reg_defaults[] = {
-	{ STIH416_AUDIO_DAC_CTRL, 0x000000000 },
-	{ STIH416_AUDIO_GLUE_CTRL, 0x00000040 },
+	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
+	{ STIH407_AUDIO_GLUE_CTRL, 0x00000040 },
 };
 
 struct sti_dac_audio {
@@ -89,7 +64,6 @@ struct sti_spdif_audio {
 
 /* device data structure */
 struct sti_sas_dev_data {
-	const int chipid; /* IC version */
 	const struct regmap_config *regmap;
 	const struct snd_soc_dai_ops *dac_ops;  /* DAC function callbacks */
 	const struct snd_soc_dapm_widget *dapm_widgets; /* dapms declaration */
@@ -155,43 +129,19 @@ static int  sti_sas_init_sas_registers(struct snd_soc_codec *codec,
 	}
 
 	/* Init DAC configuration */
-	switch (data->dev_data->chipid) {
-	case CHIPID_STIH407:
-		/* init configuration */
-		ret =  snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
-					   STIH407_DAC_STANDBY_MASK,
-					   STIH407_DAC_STANDBY_MASK);
-
-		if (!ret)
-			ret = snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
-						  STIH407_DAC_STANDBY_ANA_MASK,
-						  STIH407_DAC_STANDBY_ANA_MASK);
-		if (!ret)
-			ret = snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
-						  STIH407_DAC_SOFTMUTE_MASK,
-						  STIH407_DAC_SOFTMUTE_MASK);
-		break;
-	case CHIPID_STIH416:
-		ret =  snd_soc_update_bits(codec, STIH416_AUDIO_DAC_CTRL,
-					   STIH416_DAC_NOT_STANDBY_MASK, 0);
-		if (!ret)
-			ret =  snd_soc_update_bits(codec,
-						   STIH416_AUDIO_DAC_CTRL,
-						   STIH416_DAC_ANA_NOT_PWR, 0);
-		if (!ret)
-			ret =  snd_soc_update_bits(codec,
-						   STIH416_AUDIO_DAC_CTRL,
-						   STIH416_DAC_NOT_PNDBG_MASK,
-						   0);
-		if (!ret)
-			ret =  snd_soc_update_bits(codec,
-						   STIH416_AUDIO_DAC_CTRL,
-						   STIH416_DAC_SOFTMUTE_MASK,
-						   STIH416_DAC_SOFTMUTE_MASK);
-		break;
-	default:
-		return -EINVAL;
-	}
+	/* init configuration */
+	ret =  snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
+				   STIH407_DAC_STANDBY_MASK,
+				   STIH407_DAC_STANDBY_MASK);
+
+	if (!ret)
+		ret = snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
+					  STIH407_DAC_STANDBY_ANA_MASK,
+					  STIH407_DAC_STANDBY_ANA_MASK);
+	if (!ret)
+		ret = snd_soc_update_bits(codec, STIH407_AUDIO_DAC_CTRL,
+					  STIH407_DAC_SOFTMUTE_MASK,
+					  STIH407_DAC_SOFTMUTE_MASK);
 
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to update DAC registers");
@@ -217,37 +167,6 @@ static int sti_sas_dac_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static int stih416_dac_probe(struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct sti_sas_data *drvdata = dev_get_drvdata(codec->dev);
-	struct sti_dac_audio *dac = &drvdata->dac;
-
-	/* Get reset control */
-	dac->rst = devm_reset_control_get(codec->dev, "dac_rst");
-	if (IS_ERR(dac->rst)) {
-		dev_err(dai->codec->dev,
-			"%s: ERROR: DAC reset control not defined !\n",
-			__func__);
-		dac->rst = NULL;
-		return -EFAULT;
-	}
-	/* Put the DAC into reset */
-	reset_control_assert(dac->rst);
-
-	return 0;
-}
-
-static const struct snd_soc_dapm_widget stih416_sas_dapm_widgets[] = {
-	SND_SOC_DAPM_PGA("DAC bandgap", STIH416_AUDIO_DAC_CTRL,
-			 STIH416_DAC_NOT_PNDBG_MASK, 0, NULL, 0),
-	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH416_AUDIO_DAC_CTRL,
-			     STIH416_DAC_ANA_NOT_PWR, 0, NULL, 0),
-	SND_SOC_DAPM_DAC("DAC standby",  "dac_p", STIH416_AUDIO_DAC_CTRL,
-			 STIH416_DAC_NOT_STANDBY, 0),
-	SND_SOC_DAPM_OUTPUT("DAC Output"),
-};
-
 static const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUT_DRV("DAC standby ana", STIH407_AUDIO_DAC_CTRL,
 			     STIH407_DAC_STANDBY_ANA, 1, NULL, 0),
@@ -256,30 +175,11 @@ static const struct snd_soc_dapm_widget stih407_sas_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("DAC Output"),
 };
 
-static const struct snd_soc_dapm_route stih416_sas_route[] = {
-	{"DAC Output", NULL, "DAC bandgap"},
-	{"DAC Output", NULL, "DAC standby ana"},
-	{"DAC standby ana", NULL, "DAC standby"},
-};
-
 static const struct snd_soc_dapm_route stih407_sas_route[] = {
 	{"DAC Output", NULL, "DAC standby ana"},
 	{"DAC standby ana", NULL, "DAC standby"},
 };
 
-static int stih416_sas_dac_mute(struct snd_soc_dai *dai, int mute, int stream)
-{
-	struct snd_soc_codec *codec = dai->codec;
-
-	if (mute) {
-		return snd_soc_update_bits(codec, STIH416_AUDIO_DAC_CTRL,
-					    STIH416_DAC_SOFTMUTE_MASK,
-					    STIH416_DAC_SOFTMUTE_MASK);
-	} else {
-		return snd_soc_update_bits(codec, STIH416_AUDIO_DAC_CTRL,
-					    STIH416_DAC_SOFTMUTE_MASK, 0);
-	}
-}
 
 static int stih407_sas_dac_mute(struct snd_soc_dai *dai, int mute, int stream)
 {
@@ -407,13 +307,6 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_dai_ops stih416_dac_ops = {
-	.set_fmt = sti_sas_dac_set_fmt,
-	.mute_stream = stih416_sas_dac_mute,
-	.prepare = sti_sas_prepare,
-	.set_sysclk = sti_sas_set_sysclk,
-};
-
 static const struct snd_soc_dai_ops stih407_dac_ops = {
 	.set_fmt = sti_sas_dac_set_fmt,
 	.mute_stream = stih407_sas_dac_mute,
@@ -434,31 +327,7 @@ static const struct regmap_config stih407_sas_regmap = {
 	.reg_write = sti_sas_write_reg,
 };
 
-static const struct regmap_config stih416_sas_regmap = {
-	.reg_bits = 32,
-	.val_bits = 32,
-
-	.max_register = STIH416_AUDIO_DAC_CTRL,
-	.reg_defaults = stih416_sas_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(stih416_sas_reg_defaults),
-	.volatile_reg = sti_sas_volatile_register,
-	.cache_type = REGCACHE_RBTREE,
-	.reg_read = sti_sas_read_reg,
-	.reg_write = sti_sas_write_reg,
-};
-
-static const struct sti_sas_dev_data stih416_data = {
-	.chipid = CHIPID_STIH416,
-	.regmap = &stih416_sas_regmap,
-	.dac_ops = &stih416_dac_ops,
-	.dapm_widgets = stih416_sas_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(stih416_sas_dapm_widgets),
-	.dapm_routes =	stih416_sas_route,
-	.num_dapm_routes = ARRAY_SIZE(stih416_sas_route),
-};
-
 static const struct sti_sas_dev_data stih407_data = {
-	.chipid = CHIPID_STIH407,
 	.regmap = &stih407_sas_regmap,
 	.dac_ops = &stih407_dac_ops,
 	.dapm_widgets = stih407_sas_dapm_widgets,
@@ -533,10 +402,6 @@ static struct snd_soc_codec_driver sti_sas_driver = {
 
 static const struct of_device_id sti_sas_dev_match[] = {
 	{
-		.compatible = "st,stih416-sas-codec",
-		.data = &stih416_data,
-	},
-	{
 		.compatible = "st,stih407-sas-codec",
 		.data = &stih407_data,
 	},
@@ -584,10 +449,6 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 	}
 	drvdata->spdif.regmap = drvdata->dac.regmap;
 
-	/* Set DAC dai probe */
-	if (drvdata->dev_data->chipid == CHIPID_STIH416)
-		sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].probe = stih416_dac_probe;
-
 	sti_sas_dai[STI_SAS_DAI_ANALOG_OUT].ops = drvdata->dev_data->dac_ops;
 
 	/* Set dapms*/
-- 
2.8.1
