From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Clean up AC'97 glue driver
Date: Thu, 23 Sep 2010 19:44:07 +0100
Message-ID: <1285267447-23046-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B98C9244D9
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 20:44:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Remove version number and clean up some indentation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 12c87d3..2c824a5 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -22,8 +22,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#define AC97_VERSION "0.6"
-
 static int ac97_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -81,11 +79,9 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	struct snd_ac97_template ac97_template;
 	int ret;
 
-	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
-
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "ASoC: failed to init gen ac97 glue\n");
+		printk(KERN_ERR "ASoC: failed to init generic ac97 glue\n");
 		return ret;
 	}
 
@@ -127,8 +123,8 @@ static int ac97_soc_resume(struct snd_soc_codec *codec)
 #endif
 
 static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
-	.write = ac97_write,
-	.read = ac97_read,
+	.write =	ac97_write,
+	.read =		ac97_read,
 	.probe = 	ac97_soc_probe,
 	.remove = 	ac97_soc_remove,
 	.suspend =	ac97_soc_suspend,
@@ -149,8 +145,8 @@ static int __devexit ac97_remove(struct platform_device *pdev)
 
 static struct platform_driver ac97_codec_driver = {
 	.driver = {
-			.name = "ac97-codec",
-			.owner = THIS_MODULE,
+		.name = "ac97-codec",
+		.owner = THIS_MODULE,
 	},
 
 	.probe = ac97_probe,
-- 
1.7.1
