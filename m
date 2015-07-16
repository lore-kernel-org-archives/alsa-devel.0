From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Simplify
	rt5645_enable_push_button_irq" to the asoc tree
Date: Thu, 16 Jul 2015 13:12:29 +0100
Message-ID: <E1ZFi1d-0001kl-Ew@finisterre>
References: <1437025354-22678-2-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 428FD260569
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 14:12:41 +0200 (CEST)
In-Reply-To: <1437025354-22678-2-git-send-email-drinkcat@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Simplify rt5645_enable_push_button_irq

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

>From a4e3c5fa955ce0934774f3f3684377dbf2c20eca Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 16 Jul 2015 13:42:34 +0800
Subject: [PATCH] ASoC: rt5645: Simplify rt5645_enable_push_button_irq

LDO2/Mic Det Power pins are already enabled/disabled in rt5645_jack_detect
(the jack out code path previously did not disable those if button function
is enabled: modify it to make it so).

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 33d1aff..11a2bfc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2766,13 +2766,9 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	if (enable) {
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC L power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "ADC R power");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO2");
-		snd_soc_dapm_force_enable_pin_unlocked(dapm, "Mic Det Power");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
+		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
+		snd_soc_dapm_sync(dapm);
 
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
@@ -2785,14 +2781,9 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
 		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
 
-		snd_soc_dapm_mutex_lock(dapm);
-		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC L power");
-		snd_soc_dapm_disable_pin_unlocked(dapm, "ADC R power");
-		if (rt5645->pdata.jd_mode == 0)
-			snd_soc_dapm_disable_pin_unlocked(dapm, "LDO2");
-		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Det Power");
-		snd_soc_dapm_sync_unlocked(dapm);
-		snd_soc_dapm_mutex_unlock(dapm);
+		snd_soc_dapm_disable_pin(dapm, "ADC L power");
+		snd_soc_dapm_disable_pin(dapm, "ADC R power");
+		snd_soc_dapm_sync(dapm);
 	}
 }
 
@@ -2847,14 +2838,14 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 
 	} else { /* jack out */
 		rt5645->jack_type = 0;
+
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
-		else {
-			if (rt5645->pdata.jd_mode == 0)
-				snd_soc_dapm_disable_pin(dapm, "LDO2");
-			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-			snd_soc_dapm_sync(dapm);
-		}
+
+		if (rt5645->pdata.jd_mode == 0)
+			snd_soc_dapm_disable_pin(dapm, "LDO2");
+		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return rt5645->jack_type;
-- 
2.1.4
