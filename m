From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/14] ASoC: wm9705: Cleanup printk usage
Date: Thu, 30 Oct 2014 21:01:03 +0100
Message-ID: <1414699271-22797-7-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 98BA5261481
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:18 +0100 (CET)
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

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9705.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index c0b7f45..355b28d 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -300,6 +300,8 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 			return 0; /* Success */
 	}
 
+	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
+
 	return -EIO;
 }
 
@@ -317,10 +319,8 @@ static int wm9705_soc_resume(struct snd_soc_codec *codec)
 	u16 *cache = codec->reg_cache;
 
 	ret = wm9705_reset(codec);
-	if (ret < 0) {
-		printk(KERN_ERR "could not reset AC97 codec\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
 		soc_ac97_ops->write(codec->ac97, i, cache[i>>1]);
@@ -339,7 +339,7 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 
 	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
+		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
 	}
 
-- 
1.8.0
