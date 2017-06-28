From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: remove unexisting Muxes" to the
	asoc tree
Date: Wed, 28 Jun 2017 20:23:29 +0100
Message-ID: <E1dQIYj-0004Gu-Qw@finisterre>
References: <1498530524-32616-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87427266DF0
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:23:53 +0200 (CEST)
In-Reply-To: <1498530524-32616-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: remove unexisting Muxes

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

>From 5800b6970c6408d77c0286cba715d506313a2043 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 27 Jun 2017 10:28:44 +0800
Subject: [PATCH] ASoC: rt5651: remove unexisting Muxes

These MUXes are unexisting. So, remove them.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f5d34153e21f..db05b60d5002 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -586,44 +586,6 @@ static const struct snd_kcontrol_new hpo_r_mute_control =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5651_HP_VOL,
 				    RT5651_R_MUTE_SFT, 1, 1);
 
-/* INL/R source */
-static const char * const rt5651_inl_src[] = {"IN2P", "HPOVOLLP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inl_enum, RT5651_INL1_INR1_VOL,
-	RT5651_INL_SEL_SFT, rt5651_inl_src);
-
-static const struct snd_kcontrol_new rt5651_inl1_mux =
-	SOC_DAPM_ENUM("INL1 source", rt5651_inl_enum);
-
-static const char * const rt5651_inr1_src[] = {"IN2N", "HPOVOLRP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inr1_enum, RT5651_INL1_INR1_VOL,
-	RT5651_INR_SEL_SFT, rt5651_inr1_src);
-
-static const struct snd_kcontrol_new rt5651_inr1_mux =
-	SOC_DAPM_ENUM("INR1 source", rt5651_inr1_enum);
-
-static const char * const rt5651_inl2_src[] = {"IN3P", "OUTVOLLP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inl2_enum, RT5651_INL2_INR2_VOL,
-	RT5651_INL_SEL_SFT, rt5651_inl2_src);
-
-static const struct snd_kcontrol_new rt5651_inl2_mux =
-	SOC_DAPM_ENUM("INL2 source", rt5651_inl2_enum);
-
-static const char * const rt5651_inr2_src[] = {"IN3N", "OUTVOLRP"};
-
-static SOC_ENUM_SINGLE_DECL(
-	rt5651_inr2_enum, RT5651_INL2_INR2_VOL,
-	RT5651_INR_SEL_SFT, rt5651_inr2_src);
-
-static const struct snd_kcontrol_new rt5651_inr2_mux =
-	SOC_DAPM_ENUM("INR2 source", rt5651_inr2_enum);
-
-
 /* Stereo ADC source */
 static const char * const rt5651_stereo1_adc1_src[] = {"DD MIX", "ADC"};
 
@@ -955,11 +917,7 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 			 RT5651_PWR_IN2_L_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("INR2 VOL", RT5651_PWR_VOL,
 			 RT5651_PWR_IN2_R_BIT, 0, NULL, 0),
-	/* IN Mux */
-	SND_SOC_DAPM_MUX("INL1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl1_mux),
-	SND_SOC_DAPM_MUX("INR1 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr1_mux),
-	SND_SOC_DAPM_MUX("INL2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inl2_mux),
-	SND_SOC_DAPM_MUX("INR2 Mux", SND_SOC_NOPM, 0, 0, &rt5651_inr2_mux),
+
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIXL", RT5651_PWR_MIXER, RT5651_PWR_RM_L_BIT, 0,
 			   rt5651_rec_l_mix, ARRAY_SIZE(rt5651_rec_l_mix)),
-- 
2.13.2
