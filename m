From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stac9766: Use core reset helper" to the
	asoc tree
Date: Thu, 23 Jul 2015 17:34:08 +0100
Message-ID: <E1ZIJRg-0001Ps-MK@debutante>
References: <1437508386-13828-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E5A9261A8C
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:16 +0200 (CEST)
In-Reply-To: <1437508386-13828-5-git-send-email-lars@metafoo.de>
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

   ASoC: stac9766: Use core reset helper

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

>From 017e800af9f91861dcd6e4fd8a29418de86fd884 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:03 +0200
Subject: [PATCH] ASoC: stac9766: Use core reset helper

Use the new snd_ac97_reset() helper and the reset functionality provided by
snd_soc_new_ac97_codec() to perform the device reset rather than
open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/stac9766.c | 57 ++++++---------------------------------------
 1 file changed, 7 insertions(+), 50 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index c6028300c0ac..0945c51df003 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -28,6 +28,9 @@
 
 #include "stac9766.h"
 
+#define STAC9766_VENDOR_ID 0x83847666
+#define STAC9766_VENDOR_ID_MASK 0xffffffff
+
 /*
  * STAC9766 register cache
  */
@@ -239,45 +242,12 @@ static int stac9766_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
-{
-	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-
-	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(ac97);
-		if (stac9766_ac97_read(codec, 0) == stac9766_reg[0])
-			return 1;
-	}
-
-	soc_ac97_ops->reset(ac97);
-	if (soc_ac97_ops->warm_reset)
-		soc_ac97_ops->warm_reset(ac97);
-	if (stac9766_ac97_read(codec, 0) != stac9766_reg[0])
-		return -EIO;
-	return 0;
-}
-
 static int stac9766_codec_resume(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
-	u16 id, reset;
 
-	reset = 0;
-	/* give the codec an AC97 warm reset to start the link */
-reset:
-	if (reset > 5) {
-		dev_err(codec->dev, "Failed to resume\n");
-		return -EIO;
-	}
-	ac97->bus->ops->warm_reset(ac97);
-	id = soc_ac97_ops->read(ac97, AC97_VENDOR_ID2);
-	if (id != 0x4c13) {
-		stac9766_reset(codec, 0);
-		reset++;
-		goto reset;
-	}
-
-	return 0;
+	return snd_ac97_reset(ac97, true, STAC9766_VENDOR_ID,
+		STAC9766_VENDOR_ID_MASK);
 }
 
 static const struct snd_soc_dai_ops stac9766_dai_ops_analog = {
@@ -330,28 +300,15 @@ static struct snd_soc_dai_driver stac9766_dai[] = {
 static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_ac97 *ac97;
-	int ret = 0;
 
-	ac97 = snd_soc_new_ac97_codec(codec, 0, 0);
+	ac97 = snd_soc_new_ac97_codec(codec, STAC9766_VENDOR_ID,
+			STAC9766_VENDOR_ID_MASK);
 	if (IS_ERR(ac97))
 		return PTR_ERR(ac97);
 
 	snd_soc_codec_set_drvdata(codec, ac97);
 
-	/* do a cold reset for the controller and then try
-	 * a warm reset followed by an optional cold reset for codec */
-	stac9766_reset(codec, 0);
-	ret = stac9766_reset(codec, 1);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to reset: AC97 link error\n");
-		goto codec_err;
-	}
-
 	return 0;
-
-codec_err:
-	snd_soc_free_ac97_codec(ac97);
-	return ret;
 }
 
 static int stac9766_codec_remove(struct snd_soc_codec *codec)
-- 
2.1.4
