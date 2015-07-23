From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9712: Use core AC'97 reset helper" to
	the asoc tree
Date: Thu, 23 Jul 2015 17:34:06 +0100
Message-ID: <E1ZIJRe-0001Ov-N8@debutante>
References: <1437508386-13828-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7926B265798
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:16 +0200 (CEST)
In-Reply-To: <1437508386-13828-7-git-send-email-lars@metafoo.de>
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

   ASoC: wm9712: Use core AC'97 reset helper

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

>From a575be4cbb951244f93342487c2537f729f2239d Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:05 +0200
Subject: [PATCH] ASoC: wm9712: Use core AC'97 reset helper

Use the new snd_ac97_reset() helper and the reset functionality provided by
snd_soc_new_ac97_codec() to perform the device reset rather than
open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9712.c | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1fda104dfc45..488a92224249 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -23,6 +23,9 @@
 #include <sound/tlv.h>
 #include "wm9712.h"
 
+#define WM9712_VENDOR_ID 0x574d4c12
+#define WM9712_VENDOR_ID_MASK 0xffffffff
+
 struct wm9712_priv {
 	struct snd_ac97 *ac97;
 	unsigned int hp_mixer[2];
@@ -613,35 +616,14 @@ static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
-{
-	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
-
-	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(wm9712->ac97);
-		if (ac97_read(codec, 0) == wm9712_reg[0])
-			return 1;
-	}
-
-	soc_ac97_ops->reset(wm9712->ac97);
-	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(wm9712->ac97);
-	if (ac97_read(codec, 0) != wm9712_reg[0])
-		goto err;
-	return 0;
-
-err:
-	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
-	return -EIO;
-}
-
 static int wm9712_soc_resume(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
-	ret = wm9712_reset(codec, 1);
+	ret = snd_ac97_reset(wm9712->ac97, true, WM9712_VENDOR_ID,
+		WM9712_VENDOR_ID_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -663,31 +645,20 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9712_priv *wm9712 = snd_soc_codec_get_drvdata(codec);
-	int ret = 0;
+	int ret;
 
-	wm9712->ac97 = snd_soc_alloc_ac97_codec(codec);
+	wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
+		WM9712_VENDOR_ID_MASK);
 	if (IS_ERR(wm9712->ac97)) {
 		ret = PTR_ERR(wm9712->ac97);
 		dev_err(codec->dev, "Failed to register AC97 codec: %d\n", ret);
 		return ret;
 	}
 
-	ret = wm9712_reset(codec, 0);
-	if (ret < 0)
-		goto err_put_device;
-
-	ret = device_add(&wm9712->ac97->dev);
-	if (ret)
-		goto err_put_device;
-
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
 
 	return 0;
-
-err_put_device:
-	put_device(&wm9712->ac97->dev);
-	return ret;
 }
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
-- 
2.1.4
