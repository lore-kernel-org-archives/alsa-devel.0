From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Move the auto disable DSP
	function to set_bias_level()" to the asoc tree
Date: Mon, 10 Jul 2017 19:42:08 +0100
Message-ID: <E1dUddI-0000Cg-Ko@debutante>
References: <1499166534-16438-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D3AC266D49
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 20:42:17 +0200 (CEST)
In-Reply-To: <1499166534-16438-1-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5514: Move the auto disable DSP function to set_bias_level()

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

>From d2d44ddf79ac6af9e1359e215558c3a21b6881ee Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 10 Jul 2017 10:03:12 +0800
Subject: [PATCH] ASoC: rt5514: Move the auto disable DSP function to
 set_bias_level()

Move the auto disable DSP function from the widget event "DAPM Pre" to
the set_bias_level() function to avoid the unexpected behavior. While the
SPI was recording using the DAI "rt5514-dsp-cpu-dai", the event "DAPM Pre"
would be manipulated even the DAPM widgets were not connected, and it also
would power off the DSP that cause the DSP buffered data lost. So the auto
disable DSP function should move to the set_bias_level() function to make
sure that it is only manipulated by the DAPM widgets are connected.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 49 +++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 1b6796c4c471..a71e63097aaf 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -471,35 +471,6 @@ static int rt5514_is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 		return 0;
 }
 
-static int rt5514_pre_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		/**
-		 * If the DSP is enabled in start of recording, the DSP
-		 * should be disabled, and sync back to normal recording
-		 * settings to make sure recording properly.
-		*/
-		if (rt5514->dsp_enabled) {
-			rt5514->dsp_enabled = 0;
-			regmap_multi_reg_write(rt5514->i2c_regmap,
-				rt5514_i2c_patch, ARRAY_SIZE(rt5514_i2c_patch));
-			regcache_mark_dirty(rt5514->regmap);
-			regcache_sync(rt5514->regmap);
-		}
-		break;
-
-	default:
-		return 0;
-	}
-
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC1L"),
@@ -607,8 +578,6 @@ static const struct snd_soc_dapm_widget rt5514_dapm_widgets[] = {
 
 	/* Audio Interface */
 	SND_SOC_DAPM_AIF_OUT("AIF1TX", "AIF1 Capture", 0, SND_SOC_NOPM, 0, 0),
-
-	SND_SOC_DAPM_PRE("DAPM Pre", rt5514_pre_event),
 };
 
 static const struct snd_soc_dapm_route rt5514_dapm_routes[] = {
@@ -975,6 +944,24 @@ static int rt5514_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+			/*
+			 * If the DSP is enabled in start of recording, the DSP
+			 * should be disabled, and sync back to normal recording
+			 * settings to make sure recording properly.
+			 */
+			if (rt5514->dsp_enabled) {
+				rt5514->dsp_enabled = 0;
+				regmap_multi_reg_write(rt5514->i2c_regmap,
+					rt5514_i2c_patch,
+					ARRAY_SIZE(rt5514_i2c_patch));
+				regcache_mark_dirty(rt5514->regmap);
+				regcache_sync(rt5514->regmap);
+			}
+		}
+		break;
+
 	default:
 		break;
 	}
-- 
2.13.2
