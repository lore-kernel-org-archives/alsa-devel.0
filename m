From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Modify the power sequence for
	reducing the pop sound" to the asoc tree
Date: Fri, 07 Jul 2017 13:52:15 +0100
Message-ID: <E1dTSk3-0002pI-4N@finisterre>
References: <1499417939-319-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 267AD266BA4
 for <alsa-devel@alsa-project.org>; Fri,  7 Jul 2017 14:52:25 +0200 (CEST)
In-Reply-To: <1499417939-319-3-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Modify the power sequence for reducing the pop sound

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

>From 32a0319002c55f69c678d39e67c9df2056f5c4f7 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Fri, 7 Jul 2017 16:58:59 +0800
Subject: [PATCH] ASoC: rt5663: Modify the power sequence for reducing the pop
 sound

The patch modifies the power sequence for reducing the pop sound.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ebd9ae00e04d..82edbcf39caa 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2029,10 +2029,6 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 				RT5663_HP_SIG_SRC1_SILENCE);
 		} else {
 			snd_soc_write(codec, RT5663_DEPOP_2, 0x3003);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x000b,
-				0x000b);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030,
-				0x0030);
 			snd_soc_update_bits(codec, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_DIS);
 			snd_soc_write(codec, RT5663_HP_CHARGE_PUMP_2, 0x1371);
@@ -2055,9 +2051,6 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x3000, 0x0);
 			snd_soc_update_bits(codec, RT5663_HP_CHARGE_PUMP_1,
 				RT5663_OVCD_HP_MASK, RT5663_OVCD_HP_EN);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x0030, 0x0);
-			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x000b,
-				0x000b);
 		}
 		break;
 
@@ -2068,6 +2061,31 @@ static int rt5663_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5663_charge_pump_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct rt5663_priv *rt5663 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (rt5663->codec_ver == CODEC_VER_0)
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b,
+				0x003b);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		if (rt5663->codec_ver == CODEC_VER_0)
+			snd_soc_update_bits(codec, RT5663_DEPOP_1, 0x003b, 0);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static int rt5663_bst2_power(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -2187,6 +2205,9 @@ static const struct snd_soc_dapm_widget rt5663_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DAC R", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* Headphone*/
+	SND_SOC_DAPM_SUPPLY("HP Charge Pump", SND_SOC_NOPM, 0, 0,
+		rt5663_charge_pump_event, SND_SOC_DAPM_PRE_PMU |
+		SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5663_hp_event,
 		SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 
@@ -2343,6 +2364,7 @@ static const struct snd_soc_dapm_route rt5663_dapm_routes[] = {
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC R Power" },
 	{ "STO1 DAC MIXR", NULL, "STO1 DAC Filter" },
 
+	{ "HP Amp", NULL, "HP Charge Pump" },
 	{ "HP Amp", NULL, "DAC L" },
 	{ "HP Amp", NULL, "DAC R" },
 };
-- 
2.13.2
