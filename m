From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/14] ASoC: ad1980: Cleanup printk usage
Date: Thu, 30 Oct 2014 21:00:59 +0100
Message-ID: <1414699271-22797-3-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 87EE8260708
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:16 +0100 (CET)
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

Use dev_err()/dev_warn() instead of printk(KERN_ERR/KERN_WARNING. This is
common practice and makes it easy to find out which device generated the
message. While we are at it also align the error messages with the other
AC'97 drivers.

Also remove the info message that is printed when the driver is probed, this
is just noise in bootlog.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1980.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index cc28dba..5f076c2 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -209,7 +209,8 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 			return 0;
 	} while (retry_cnt++ < 10);
 
-	printk(KERN_ERR "AD1980 AC97 reset failed\n");
+	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
+
 	return -EIO;
 }
 
@@ -219,19 +220,15 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	u16 vendor_id2;
 	u16 ext_status;
 
-	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
-
 	ret = snd_soc_new_ac97_codec(codec, soc_ac97_ops, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "ad1980: failed to register AC97 codec\n");
+		dev_err(codec->dev, "Failed to register AC97 codec\n");
 		return ret;
 	}
 
 	ret = ad1980_reset(codec, 0);
-	if (ret < 0) {
-		printk(KERN_ERR "Failed to reset AD1980: AC97 link error\n");
+	if (ret < 0)
 		goto reset_err;
-	}
 
 	/* Read out vendor ID to make sure it is ad1980 */
 	if (ac97_read(codec, AC97_VENDOR_ID1) != 0x4144) {
@@ -246,9 +243,8 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 			ret = -ENODEV;
 			goto reset_err;
 		} else {
-			printk(KERN_WARNING "ad1980: "
-				"Found AD1981 - only 2/2 IN/OUT Channels "
-				"supported\n");
+			dev_warn(codec->dev,
+				"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
 		}
 	}
 
-- 
1.8.0
