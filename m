From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ab8500: Remove explicit initialization
	of driver callbacks to NULL
Date: Tue, 22 Nov 2016 22:49:48 +0100
Message-ID: <1479851388-17593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C88682667B2
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 22:49:56 +0100 (CET)
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

Fields of structs with global storage are implicitly initialized to 0/NULL,
there is usually no need to do this explicitly.

Removing the initialization of the legacy suspend/resume callback fields
also gets the driver ready for the day when they are eventually removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ab8500-codec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 935ff7c..312b2a1 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2587,8 +2587,6 @@ static struct platform_driver ab8500_codec_platform_driver = {
 	},
 	.probe		= ab8500_codec_driver_probe,
 	.remove		= ab8500_codec_driver_remove,
-	.suspend	= NULL,
-	.resume		= NULL,
 };
 module_platform_driver(ab8500_codec_platform_driver);
 
-- 
2.1.4
