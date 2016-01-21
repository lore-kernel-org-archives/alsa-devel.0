From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt286: fix capture doesn't work at some
	cases" to the asoc tree
Date: Thu, 21 Jan 2016 16:56:07 +0000
Message-ID: <E1aMIWl-0008Fw-MJ@debutante>
References: <1453356648-27625-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F050E26062B
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:56:14 +0100 (CET)
In-Reply-To: <1453356648-27625-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt286: fix capture doesn't work at some cases

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

>From 6d514c720219a4c0e1c2612c1d830592bfaf5a03 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 21 Jan 2016 14:10:48 +0800
Subject: [PATCH] ASoC: rt286: fix capture doesn't work at some cases

RT286_CBJ_CTRL1(0x4f) bit 10 is needed for headset capture. It
will be turned off when "VREF" widget is on and be turned on when
bias level is ON. It is odd. And if "VREF" is turned on in bias
level is ON, RT286_CBJ_CTRL1(0x4f) bit 10 will be turned off.
This patch move the bit control from rt286_set_bias_level and
rt298_vref_event to rt286_jack_detect. So it will be turned on
once a jack is plugged in.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index af2ed774b552..af30b062f57a 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -266,6 +266,8 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		} else {
 			*mic = false;
 			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x20);
+			regmap_update_bits(rt286->regmap,
+				RT286_CBJ_CTRL1, 0x0400, 0x0000);
 		}
 	} else {
 		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
@@ -470,24 +472,6 @@ static int rt286_set_dmic1_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int rt286_vref_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0000);
-		mdelay(50);
-		break;
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static int rt286_ldo2_event(struct snd_soc_dapm_widget *w,
 			     struct snd_kcontrol *kcontrol, int event)
 {
@@ -536,7 +520,7 @@ static const struct snd_soc_dapm_widget rt286_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY_S("HV", 1, RT286_POWER_CTRL1,
 		12, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("VREF", RT286_POWER_CTRL1,
-		0, 1, rt286_vref_event, SND_SOC_DAPM_PRE_PMU),
+		0, 1, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO1", 1, RT286_POWER_CTRL2,
 		2, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("LDO2", 2, RT286_POWER_CTRL1,
@@ -911,8 +895,6 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_ON:
 		mdelay(10);
 		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0400);
-		snd_soc_update_bits(codec,
 			RT286_DC_GAIN, 0x200, 0x0);
 
 		break;
@@ -920,8 +902,6 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		snd_soc_write(codec,
 			RT286_SET_AUDIO_POWER, AC_PWRST_D3);
-		snd_soc_update_bits(codec,
-			RT286_CBJ_CTRL1, 0x0400, 0x0000);
 		break;
 
 	default:
-- 
2.7.0.rc3
