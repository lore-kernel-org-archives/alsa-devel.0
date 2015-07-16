From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Update dapm pins when the card
	is not instantiated yet" to the asoc tree
Date: Thu, 16 Jul 2015 13:12:31 +0100
Message-ID: <E1ZFi1f-0001lE-AM@finisterre>
References: <1437025354-22678-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B3B32661CF
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 14:12:43 +0200 (CEST)
In-Reply-To: <1437025354-22678-1-git-send-email-drinkcat@chromium.org>
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

   ASoC: rt5645: Update dapm pins when the card is not instantiated yet

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

>From b14c917409f47dbfdff93e69effd6740f6a809f7 Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 16 Jul 2015 13:42:33 +0800
Subject: [PATCH] ASoC: rt5645: Update dapm pins when the card is not
 instantiated yet

This makes sure the dapm state is consistent when the card is
instantiated.

However, if the card is not instantiated yet, we still update the
registers manually in the "jack in" case, so that we can immediately
report if a mic is present or not.

Disabling "Mic Det Power" after detection, and on jack out, can
wait until the card gets instantiated.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8693a25..33d1aff 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2805,12 +2805,11 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	if (jack_insert) {
 		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
 
-		if (codec->component.card->instantiated) {
-			/* for jack type detect */
-			snd_soc_dapm_force_enable_pin(dapm, "LDO2");
-			snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
-			snd_soc_dapm_sync(dapm);
-		} else {
+		/* for jack type detect */
+		snd_soc_dapm_force_enable_pin(dapm, "LDO2");
+		snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
+		snd_soc_dapm_sync(dapm);
+		if (!dapm->card->instantiated) {
 			/* Power up necessary bits for JD if dapm is
 			   not ready yet */
 			regmap_update_bits(rt5645->regmap, RT5645_PWR_ANLG1,
@@ -2841,12 +2840,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 				rt5645_enable_push_button_irq(codec, true);
 			}
 		} else {
-			if (codec->component.card->instantiated) {
-				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-				snd_soc_dapm_sync(dapm);
-			} else
-				regmap_update_bits(rt5645->regmap,
-					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
 
@@ -2855,19 +2850,10 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
 		else {
-			if (codec->component.card->instantiated) {
-				if (rt5645->pdata.jd_mode == 0)
-					snd_soc_dapm_disable_pin(dapm, "LDO2");
-				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
-				snd_soc_dapm_sync(dapm);
-			} else {
-				if (rt5645->pdata.jd_mode == 0)
-					regmap_update_bits(rt5645->regmap,
-						RT5645_PWR_MIXER,
-						RT5645_PWR_LDO2, 0);
-				regmap_update_bits(rt5645->regmap,
-					RT5645_PWR_VOL, RT5645_PWR_MIC_DET, 0);
-			}
+			if (rt5645->pdata.jd_mode == 0)
+				snd_soc_dapm_disable_pin(dapm, "LDO2");
+			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
+			snd_soc_dapm_sync(dapm);
 		}
 	}
 
-- 
2.1.4
