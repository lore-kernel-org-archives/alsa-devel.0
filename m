From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/8] ASoC: AD1836: drop unnecessary spi
	register check
Date: Tue, 14 Jun 2011 17:34:21 -0400
Message-ID: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 44EA8243EC
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The only thing the init func does is register a spi driver, so if that
fails, we return the value back up to the caller who will display an
error message for us.  So drop the redundant checking/message.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 754c496..d368539 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -315,15 +315,7 @@ static struct spi_driver ad1836_spi_driver = {
 
 static int __init ad1836_init(void)
 {
-	int ret;
-
-	ret = spi_register_driver(&ad1836_spi_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register ad1836 SPI driver: %d\n",
-				ret);
-	}
-
-	return ret;
+	return spi_register_driver(&ad1836_spi_driver);
 }
 module_init(ad1836_init);
 
-- 
1.7.5.3
