From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/14] ASoC: wm9712: Cleanup printk usage
Date: Thu, 30 Oct 2014 21:01:05 +0100
Message-ID: <1414699271-22797-9-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id C2199265336
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:19 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use dev_err() instead of printk(KERN_ERR. This is common practice and makes
it easy to find out which device generated the message. While we are at it
also align the error messages with the other AC'97 drivers.

Also avoid printing two error messages when the reset fails.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index c5eb746..c389e56 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -595,7 +595,7 @@ static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
 	return 0;
 
 err:
-	printk(KERN_ERR "WM9712 AC97 reset failed\n");
+	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
 	return -EIO;
 }
 
@@ -611,10 +611,8 @@ static int wm9712_soc_resume(struct snd_soc_codec *codec)
 	u16 *cache = codec->reg_cache;
 
 	ret = wm9712_reset(codec, 1);
-	if (ret < 0) {
-		printk(KERN_ERR "could not reset AC97 codec\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -637,15 +635,13 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 
 	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
+		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
 	}
 
 	ret = wm9712_reset(codec, 0);
-	if (ret < 0) {
-		printk(KERN_ERR "Failed to reset WM9712: AC97 link error\n");
+	if (ret < 0)
 		goto reset_err;
-	}
 
 	/* set alc mux to none */
 	ac97_write(codec, AC97_VIDEO, ac97_read(codec, AC97_VIDEO) | 0x3000);
-- 
1.8.0
