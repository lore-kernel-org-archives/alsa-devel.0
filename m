From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: Remove IS_ENABLED for INPUT in CS42L52
	and WM8962
Date: Fri, 2 May 2014 09:30:41 -0500
Message-ID: <1399041041-32261-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0068.outbound.protection.outlook.com [157.56.110.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 25D2226168C
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 16:29:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Now that INPUT is required for the CS42L52 and WM8962 we can remove the IS_ENABLED(INPUT) check in the drivers.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c |   12 ------------
 sound/soc/codecs/wm8962.c  |   12 ------------
 2 files changed, 24 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 8a7bde4..c0581c5 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -50,11 +50,9 @@ struct  cs42l52_private {
 	u8 mclksel;
 	u32 mclk;
 	u8 flags;
-#if IS_ENABLED(CONFIG_INPUT)
 	struct input_dev *beep;
 	struct work_struct beep_work;
 	int beep_rate;
-#endif
 };
 
 static const struct reg_default cs42l52_reg_defaults[] = {
@@ -962,7 +960,6 @@ static int cs42l52_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_INPUT)
 static int beep_rates[] = {
 	261, 522, 585, 667, 706, 774, 889, 1000,
 	1043, 1200, 1333, 1412, 1600, 1714, 2000, 2182
@@ -1096,15 +1093,6 @@ static void cs42l52_free_beep(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, CS42L52_BEEP_TONE_CTL,
 			    CS42L52_BEEP_EN_MASK, 0);
 }
-#else
-static void cs42l52_init_beep(struct snd_soc_codec *codec)
-{
-}
-
-static void cs42l52_free_beep(struct snd_soc_codec *codec)
-{
-}
-#endif
 
 static int cs42l52_probe(struct snd_soc_codec *codec)
 {
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 37986c8..b77e4c3 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -74,11 +74,9 @@ struct wm8962_priv {
 	struct regulator_bulk_data supplies[WM8962_NUM_SUPPLIES];
 	struct notifier_block disable_nb[WM8962_NUM_SUPPLIES];
 
-#if IS_ENABLED(CONFIG_INPUT)
 	struct input_dev *beep;
 	struct work_struct beep_work;
 	int beep_rate;
-#endif
 
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip gpio_chip;
@@ -3145,7 +3143,6 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 }
 EXPORT_SYMBOL_GPL(wm8962_mic_detect);
 
-#if IS_ENABLED(CONFIG_INPUT)
 static int beep_rates[] = {
 	500, 1000, 2000, 4000,
 };
@@ -3277,15 +3274,6 @@ static void wm8962_free_beep(struct snd_soc_codec *codec)
 
 	snd_soc_update_bits(codec, WM8962_BEEP_GENERATOR_1, WM8962_BEEP_ENA,0);
 }
-#else
-static void wm8962_init_beep(struct snd_soc_codec *codec)
-{
-}
-
-static void wm8962_free_beep(struct snd_soc_codec *codec)
-{
-}
-#endif
 
 static void wm8962_set_gpio_mode(struct wm8962_priv *wm8962, int gpio)
 {
-- 
1.7.9.5
