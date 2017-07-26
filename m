From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: merge ADC L/R Mux" to the asoc
	tree
Date: Wed, 26 Jul 2017 15:16:33 +0100
Message-ID: <E1daN73-0003Nj-5u@debutante>
References: <1501070420-17773-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C192B26742B
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 16:16:47 +0200 (CEST)
In-Reply-To: <1501070420-17773-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: merge ADC L/R Mux

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

>From ea746a296df3670359ae7d43baa968b0a1a54a01 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 26 Jul 2017 20:00:19 +0800
Subject: [PATCH] ASoC: rt5670: merge ADC L/R Mux

Some ADC L/R Muxes share the some control bit. So, merge them.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 174141fefc79..0f4e5bc4476f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1151,20 +1151,15 @@ static const char * const rt5670_stereo_adc1_src[] = {
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc1_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
-static const struct snd_kcontrol_new rt5670_sto_adc_l1_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC L1 source", rt5670_stereo1_adc1_enum);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_r1_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC R1 source", rt5670_stereo1_adc1_enum);
+static const struct snd_kcontrol_new rt5670_sto_adc_1_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC 1 Mux", rt5670_stereo1_adc1_enum);
 
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc1_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_1_SRC_SFT, rt5670_stereo_adc1_src);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_l1_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC L1 source", rt5670_stereo2_adc1_enum);
+static const struct snd_kcontrol_new rt5670_sto2_adc_1_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC 1 Mux", rt5670_stereo2_adc1_enum);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_r1_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC R1 source", rt5670_stereo2_adc1_enum);
 
 /* MX-27 MX-26 [11] */
 static const char * const rt5670_stereo_adc2_src[] = {
@@ -1174,20 +1169,15 @@ static const char * const rt5670_stereo_adc2_src[] = {
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo1_adc2_enum, RT5670_STO1_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
-static const struct snd_kcontrol_new rt5670_sto_adc_l2_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC L2 source", rt5670_stereo1_adc2_enum);
-
-static const struct snd_kcontrol_new rt5670_sto_adc_r2_mux =
-	SOC_DAPM_ENUM("Stereo1 ADC R2 source", rt5670_stereo1_adc2_enum);
+static const struct snd_kcontrol_new rt5670_sto_adc_2_mux =
+	SOC_DAPM_ENUM("Stereo1 ADC 2 Mux", rt5670_stereo1_adc2_enum);
 
 static SOC_ENUM_SINGLE_DECL(rt5670_stereo2_adc2_enum, RT5670_STO2_ADC_MIXER,
 	RT5670_ADC_2_SRC_SFT, rt5670_stereo_adc2_src);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_l2_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC L2 source", rt5670_stereo2_adc2_enum);
+static const struct snd_kcontrol_new rt5670_sto2_adc_2_mux =
+	SOC_DAPM_ENUM("Stereo2 ADC 2 Mux", rt5670_stereo2_adc2_enum);
 
-static const struct snd_kcontrol_new rt5670_sto2_adc_r2_mux =
-	SOC_DAPM_ENUM("Stereo2 ADC R2 source", rt5670_stereo2_adc2_enum);
 
 /* MX-27 MX26 [10] */
 static const char * const rt5670_stereo_adc_src[] = {
@@ -1642,23 +1632,23 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Stereo1 DMIC Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto1_dmic_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_l2_mux),
+			 &rt5670_sto_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_r2_mux),
+			 &rt5670_sto_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_l1_mux),
+			 &rt5670_sto_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo1 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto_adc_r1_mux),
+			 &rt5670_sto_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 DMIC Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto2_dmic_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC L2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_l2_mux),
+			 &rt5670_sto2_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC R2 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_r2_mux),
+			 &rt5670_sto2_adc_2_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC L1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_l1_mux),
+			 &rt5670_sto2_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC R1 Mux", SND_SOC_NOPM, 0, 0,
-			 &rt5670_sto2_adc_r1_mux),
+			 &rt5670_sto2_adc_1_mux),
 	SND_SOC_DAPM_MUX("Stereo2 ADC LR Mux", SND_SOC_NOPM, 0, 0,
 			 &rt5670_sto2_adc_lr_mux),
 	SND_SOC_DAPM_MUX("Mono DMIC L Mux", SND_SOC_NOPM, 0, 0,
-- 
2.13.2
