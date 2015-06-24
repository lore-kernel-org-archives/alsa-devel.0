From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: gtm601: Fix modalias
Date: Wed, 24 Jun 2015 10:55:24 +0800
Message-ID: <1435114524.2082.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B4A426579E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 04:55:31 +0200 (CEST)
Received: by pdjn11 with SMTP id n11so20135261pdj.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 19:55:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The MODULE_ALIAS needs to match the driver name to make module auto-loading
work. Also move MODULE_ALIAS close to other MODULE_* macro.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/gtm601.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 1b77ff2..a696e3e 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -70,8 +70,6 @@ static int gtm601_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_ALIAS("platform:gtm601_codec_audio");
-
 #if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
 	{ .compatible = "option,gtm601", },
@@ -96,3 +94,4 @@ module_platform_driver(gtm601_codec_driver);
 MODULE_DESCRIPTION("ASoC gtm601 driver");
 MODULE_AUTHOR("Marek Belisko <marek@goldelico.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gtm601");
-- 
2.1.0
