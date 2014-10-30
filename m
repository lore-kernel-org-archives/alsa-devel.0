From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/14] ASoC: stac9766: Cleanup printk usage
Date: Thu, 30 Oct 2014 21:01:01 +0100
Message-ID: <1414699271-22797-5-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CDF260715
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:17 +0100 (CET)
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
 sound/soc/codecs/stac9766.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 9878534..e88d9ac 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -262,7 +262,7 @@ static int stac9766_codec_resume(struct snd_soc_codec *codec)
 	/* give the codec an AC97 warm reset to start the link */
 reset:
 	if (reset > 5) {
-		printk(KERN_ERR "stac9766 failed to resume");
+		dev_err(codec->dev, "Failed to resume\n");
 		return -EIO;
 	}
 	codec->ac97->bus->ops->warm_reset(codec->ac97);
@@ -338,7 +338,7 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 	stac9766_reset(codec, 0);
 	ret = stac9766_reset(codec, 1);
 	if (ret < 0) {
-		printk(KERN_ERR "Failed to reset STAC9766: AC97 link error\n");
+		dev_err(codec->dev, "Failed to reset: AC97 link error\n");
 		goto codec_err;
 	}
 
-- 
1.8.0
