From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ad1980: Replace goto loop with do-while
	loop
Date: Tue, 20 May 2014 14:23:10 +0200
Message-ID: <1400588590-26820-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-133.synserver.de
 [212.40.185.133])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC8E261AE4
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 14:23:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Using a proper do-while loop here instead of a open-coded goto loop is both
cleaner and shorter.

Also fixes the following warnings from smatch:
	sound/soc/codecs/ad1980.c:213 ad1980_reset() info: loop could be replaced with if statement.
	sound/soc/codecs/ad1980.c:212 ad1980_reset() info: ignoring unreachable code.
	sound/soc/codecs/ad1980.c:215 ad1980_reset() info: ignoring unreachable code.

While we are at it also change retry_cnt to unsigned int, using u16 for a
on-stack loop counter doesn't make that much sense.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1980.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 34d965a..304d300 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -189,28 +189,27 @@ static struct snd_soc_dai_driver ad1980_dai = {
 
 static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 {
-	u16 retry_cnt = 0;
+	unsigned int retry_cnt = 0;
 
-retry:
-	if (try_warm && soc_ac97_ops->warm_reset) {
-		soc_ac97_ops->warm_reset(codec->ac97);
-		if (ac97_read(codec, AC97_RESET) == 0x0090)
-			return 1;
-	}
-
-	soc_ac97_ops->reset(codec->ac97);
-	/* Set bit 16slot in register 74h, then every slot will has only 16
-	 * bits. This command is sent out in 20bit mode, in which case the
-	 * first nibble of data is eaten by the addr. (Tag is always 16 bit)*/
-	ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
-
-	if (ac97_read(codec, AC97_RESET)  != 0x0090)
-		goto err;
-	return 0;
+	do {
+		if (try_warm && soc_ac97_ops->warm_reset) {
+			soc_ac97_ops->warm_reset(codec->ac97);
+			if (ac97_read(codec, AC97_RESET) == 0x0090)
+				return 1;
+		}
 
-err:
-	while (retry_cnt++ < 10)
-		goto retry;
+		soc_ac97_ops->reset(codec->ac97);
+		/*
+		 * Set bit 16slot in register 74h, then every slot will has only
+		 * 16 bits. This command is sent out in 20bit mode, in which
+		 * case the first nibble of data is eaten by the addr. (Tag is
+		 * always 16 bit)
+		 */
+		ac97_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
+
+		if (ac97_read(codec, AC97_RESET)  == 0x0090)
+			return 0;
+	} while (retry_cnt++ < 10);
 
 	printk(KERN_ERR "AD1980 AC97 reset failed\n");
 	return -EIO;
-- 
1.8.0
