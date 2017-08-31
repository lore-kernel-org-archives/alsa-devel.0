From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Modified DAPM widget and map
	to enable/disable VI sense path" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:37 +0100
Message-ID: <E1dnO3R-0000iK-1o@debutante>
References: <1503708070-7906-8-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ECF42673A1
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 13:54:48 +0200 (CEST)
In-Reply-To: <1503708070-7906-8-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Modified DAPM widget and map to enable/disable VI sense path

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

>From 607f7777bf0c0224bfadd31a37acc8d1fd25324d Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:31:00 -0700
Subject: [PATCH] ASoC: max98927: Modified DAPM widget and map to
 enable/disable VI sense path

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index caf5340ca6bb..4bbf2098f255 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -418,11 +418,6 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN,
 			MAX98927_AMP_EN_MASK, 1);
-		/* enable VMON and IMON */
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN);
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R00FF_GLOBAL_SHDN,
 			MAX98927_GLOBAL_EN_MASK, 1);
@@ -434,10 +429,6 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN,
 			MAX98927_AMP_EN_MASK, 0);
-		/* disable VMON and IMON */
-		regmap_update_bits(max98927->regmap,
-			MAX98927_R003E_MEAS_EN,
-			MAX98927_MEAS_V_EN | MAX98927_MEAS_I_EN, 0);
 		break;
 	default:
 		return 0;
@@ -456,14 +447,24 @@ static const struct soc_enum dai_sel_enum =
 static const struct snd_kcontrol_new max98927_dai_controls =
 	SOC_DAPM_ENUM("DAI Sel", dai_sel_enum);
 
+static const struct snd_kcontrol_new max98927_vi_control =
+	SOC_DAPM_SINGLE("Switch", MAX98927_R003F_MEAS_DSP_CFG, 2, 1, 0);
+
 static const struct snd_soc_dapm_widget max98927_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("DAI_OUT", "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC_E("Amp Enable", "HiFi Playback", MAX98927_R003A_AMP_EN,
 		0, 0, max98927_dac_event,
 		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MUX("DAI Sel Mux", SND_SOC_NOPM, 0, 0,
 		&max98927_dai_controls),
 	SND_SOC_DAPM_OUTPUT("BE_OUT"),
+	SND_SOC_DAPM_AIF_OUT("Voltage Sense", "HiFi Capture",  0,
+		MAX98927_R003E_MEAS_EN, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("Current Sense", "HiFi Capture",  0,
+		MAX98927_R003E_MEAS_EN, 1, 0),
+	SND_SOC_DAPM_SWITCH("VI Sense", SND_SOC_NOPM, 0, 0,
+		&max98927_vi_control),
+	SND_SOC_DAPM_SIGGEN("VMON"),
+	SND_SOC_DAPM_SIGGEN("IMON"),
 };
 
 static DECLARE_TLV_DB_SCALE(max98927_spk_tlv, 300, 300, 0);
@@ -550,11 +551,16 @@ static const struct snd_kcontrol_new max98927_snd_controls[] = {
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
-	{"Amp Enable", NULL, "DAI_OUT"},
+	/* Plabyack */
 	{"DAI Sel Mux", "Left", "Amp Enable"},
 	{"DAI Sel Mux", "Right", "Amp Enable"},
 	{"DAI Sel Mux", "LeftRight", "Amp Enable"},
 	{"BE_OUT", NULL, "DAI Sel Mux"},
+	/* Capture */
+	{ "VI Sense", "Switch", "VMON" },
+	{ "VI Sense", "Switch", "IMON" },
+	{ "Voltage Sense", NULL, "VI Sense" },
+	{ "Current Sense", NULL, "VI Sense" },
 };
 
 static struct snd_soc_dai_driver max98927_dai[] = {
-- 
2.14.1
