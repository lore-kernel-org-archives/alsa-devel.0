From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: wm0010: Remove .bus field setting from
 wm0010_spi_driver
Date: Thu, 02 Jul 2015 12:02:58 +0800
Message-ID: <1435809778.4609.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 1187B2615F7
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2015 06:03:13 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so33412160pab.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2015 21:03:11 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The .bus field will be set by spi_register_driver() so we don't need to
set it in wm0010_spi_driver.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm0010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 6560a66..e1da49f 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -1003,7 +1003,6 @@ static int wm0010_spi_remove(struct spi_device *spi)
 static struct spi_driver wm0010_spi_driver = {
 	.driver = {
 		.name	= "wm0010",
-		.bus 	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm0010_spi_probe,
-- 
2.1.0
