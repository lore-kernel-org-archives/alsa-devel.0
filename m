From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: wm9713: Use core AC'97 reset helper
Date: Tue, 21 Jul 2015 21:53:06 +0200
Message-ID: <1437508386-13828-8-git-send-email-lars@metafoo.de>
References: <1437508386-13828-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 52E3926510F
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 21:53:29 +0200 (CEST)
In-Reply-To: <1437508386-13828-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use the new snd_ac97_reset() helper and the reset functionality provided by
snd_soc_new_ac97_codec() to perform the device reset rather than
open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.c | 48 ++++++++---------------------------------------
 sound/soc/codecs/wm9713.h |  2 --
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 89cd2d6..955e651 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -29,6 +29,9 @@
 
 #include "wm9713.h"
 
+#define WM9713_VENDOR_ID 0x574d4c13
+#define WM9713_VENDOR_ID_MASK 0xffffffff
+
 struct wm9713_priv {
 	struct snd_ac97 *ac97;
 	u32 pll_in; /* PLL input frequency */
@@ -1123,28 +1126,6 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 	},
 };
 
-int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
-{
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-
-	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(wm9713->ac97);
-		if (ac97_read(codec, 0) == wm9713_reg[0])
-			return 1;
-	}
-
-	soc_ac97_ops->reset(wm9713->ac97);
-	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(wm9713->ac97);
-	if (ac97_read(codec, 0) != wm9713_reg[0]) {
-		dev_err(codec->dev, "Failed to reset: AC97 link error\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(wm9713_reset);
-
 static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -1196,7 +1177,8 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
-	ret = wm9713_reset(codec, 1);
+	ret = snd_ac97_reset(wm9713->ac97, true, WM9713_VENDOR_ID,
+		WM9713_VENDOR_ID_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -1222,32 +1204,18 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0, reg;
+	int reg;
 
-	wm9713->ac97 = snd_soc_alloc_ac97_codec(codec);
+	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
+		WM9713_VENDOR_ID_MASK);
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
-	/* do a cold reset for the controller and then try
-	 * a warm reset followed by an optional cold reset for codec */
-	wm9713_reset(codec, 0);
-	ret = wm9713_reset(codec, 1);
-	if (ret < 0)
-		goto err_put_device;
-
-	ret = device_add(&wm9713->ac97->dev);
-	if (ret)
-		goto err_put_device;
-
 	/* unmute the adc - move to kcontrol */
 	reg = ac97_read(codec, AC97_CD) & 0x7fff;
 	ac97_write(codec, AC97_CD, reg);
 
 	return 0;
-
-err_put_device:
-	put_device(&wm9713->ac97->dev);
-	return ret;
 }
 
 static int wm9713_soc_remove(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index 793da86..53df11b 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -45,6 +45,4 @@
 #define WM9713_DAI_AC97_AUX		1
 #define WM9713_DAI_PCM_VOICE	2
 
-int wm9713_reset(struct snd_soc_codec *codec,  int try_warm);
-
 #endif
-- 
2.1.4
