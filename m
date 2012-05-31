From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: ac97: Remove empty remove() function
Date: Thu, 31 May 2012 14:21:29 +0100
Message-ID: <1338470489-5522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3CD62442F
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 15:21:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ac97.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 2023c74..ea06b83 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -91,11 +91,6 @@ static int ac97_soc_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int ac97_soc_remove(struct snd_soc_codec *codec)
-{
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static int ac97_soc_suspend(struct snd_soc_codec *codec)
 {
@@ -119,7 +114,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
 	.write =	ac97_write,
 	.read =		ac97_read,
 	.probe = 	ac97_soc_probe,
-	.remove = 	ac97_soc_remove,
 	.suspend =	ac97_soc_suspend,
 	.resume =	ac97_soc_resume,
 };
-- 
1.7.10
