From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ad1980: Use core AC'97 reset helper" to
	the asoc tree
Date: Thu, 23 Jul 2015 17:34:09 +0100
Message-ID: <E1ZIJRh-0001QL-M0@debutante>
References: <1437508386-13828-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4991E26128B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:16 +0200 (CEST)
In-Reply-To: <1437508386-13828-4-git-send-email-lars@metafoo.de>
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

   ASoC: ad1980: Use core AC'97 reset helper

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

>From 3ab3dbdfb91b70ef6bf4eb9b544bf54ff1dff51a Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:02 +0200
Subject: [PATCH] ASoC: ad1980: Use core AC'97 reset helper

Use the new snd_ac97_reset() helper function to perform the reset and
verify the device ID.

Unfortunately the reset can't be done in snd_soc_new_ac97_codec() due to
the special requirements in order to support the non-standard 16-bit slot
mode of the ad1980.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad1980.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index d9cb81dd64b5..9ef20dbccbe3 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -202,19 +202,21 @@ static struct snd_soc_dai_driver ad1980_dai = {
 		.formats = SND_SOC_STD_AC97_FMTS, },
 };
 
+#define AD1980_VENDOR_ID 0x41445300
+#define AD1980_VENDOR_MASK 0xffffff00
+
 static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	unsigned int retry_cnt = 0;
+	int ret;
 
 	do {
-		if (try_warm && soc_ac97_ops->warm_reset) {
-			soc_ac97_ops->warm_reset(ac97);
-			if (snd_soc_read(codec, AC97_RESET) == 0x0090)
-				return 1;
-		}
+		ret = snd_ac97_reset(ac97, true, AD1980_VENDOR_ID,
+			AD1980_VENDOR_MASK);
+		if (ret >= 0)
+			return 0;
 
-		soc_ac97_ops->reset(ac97);
 		/*
 		 * Set bit 16slot in register 74h, then every slot will has only
 		 * 16 bits. This command is sent out in 20bit mode, in which
@@ -223,8 +225,6 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 		 */
 		snd_soc_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
 
-		if (snd_soc_read(codec, AC97_RESET)  == 0x0090)
-			return 0;
 	} while (retry_cnt++ < 10);
 
 	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
@@ -260,22 +260,10 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		goto reset_err;
 
-	/* Read out vendor ID to make sure it is ad1980 */
-	if (snd_soc_read(codec, AC97_VENDOR_ID1) != 0x4144) {
-		ret = -ENODEV;
-		goto reset_err;
-	}
-
 	vendor_id2 = snd_soc_read(codec, AC97_VENDOR_ID2);
-
-	if (vendor_id2 != 0x5370) {
-		if (vendor_id2 != 0x5374) {
-			ret = -ENODEV;
-			goto reset_err;
-		} else {
-			dev_warn(codec->dev,
-				"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
-		}
+	if (vendor_id2 == 0x5374) {
+		dev_warn(codec->dev,
+			"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
 	}
 
 	/* unmute captures and playbacks volume */
-- 
2.1.4
