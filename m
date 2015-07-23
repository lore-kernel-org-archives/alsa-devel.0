From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9705: Use core AC'97 reset helper" to
	the asoc tree
Date: Thu, 23 Jul 2015 17:34:07 +0100
Message-ID: <E1ZIJRf-0001PO-ML@debutante>
References: <1437508386-13828-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C765261586
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:16 +0200 (CEST)
In-Reply-To: <1437508386-13828-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9705: Use core AC'97 reset helper

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

>From 6e0b73a0a172f4d881092e388b3a3ad57ca80107 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:04 +0200
Subject: [PATCH] ASoC: wm9705: Use core AC'97 reset helper

Use the new snd_ac97_reset() helper and the reset functionality provided by
snd_soc_new_ac97_codec() to perform the device reset rather than
open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9705.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 5cc457ef8894..744842c76a60 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -22,6 +22,9 @@
 
 #include "wm9705.h"
 
+#define WM9705_VENDOR_ID 0x574d4c05
+#define WM9705_VENDOR_ID_MASK 0xffffffff
+
 /*
  * WM9705 register cache
  */
@@ -293,21 +296,6 @@ static struct snd_soc_dai_driver wm9705_dai[] = {
 	}
 };
 
-static int wm9705_reset(struct snd_soc_codec *codec)
-{
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-
-	if (soc_ac97_ops->reset) {
-		soc_ac97_ops->reset(ac97);
-		if (ac97_read(codec, 0) == wm9705_reg[0])
-			return 0; /* Success */
-	}
-
-	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
-
-	return -EIO;
-}
-
 #ifdef CONFIG_PM
 static int wm9705_soc_suspend(struct snd_soc_codec *codec)
 {
@@ -324,7 +312,8 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
-	ret = wm9705_reset(codec);
+	ret = snd_ac97_reset(ac97, true, WM9705_VENDOR_ID,
+		WM9705_VENDOR_ID_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -342,30 +331,17 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97;
-	int ret = 0;
 
-	ac97 = snd_soc_alloc_ac97_codec(codec);
+	ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
+		WM9705_VENDOR_ID_MASK);
 	if (IS_ERR(ac97)) {
-		ret = PTR_ERR(ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec\n");
-		return ret;
+		return PTR_ERR(ac97);
 	}
 
-	ret = wm9705_reset(codec);
-	if (ret)
-		goto err_put_device;
-
-	ret = device_add(&ac97->dev);
-	if (ret)
-		goto err_put_device;
-
 	snd_soc_codec_set_drvdata(codec, ac97);
 
 	return 0;
-
-err_put_device:
-	put_device(&ac97->dev);
-	return ret;
 }
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
-- 
2.1.4
