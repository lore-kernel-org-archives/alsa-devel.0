From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ALSA: Convert at73c213 to module_spi_driver
Date: Fri, 27 Jan 2012 15:29:13 +0800
Message-ID: <1327649353.3758.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8BE2E24528
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 08:29:19 +0100 (CET)
Received: by yhoo47 with SMTP id o47so694026yho.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 23:29:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Jaroslav@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch converts at73c213 to use the module_spi_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/spi/at73c213.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 4dd051b..c6500d0 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -1112,17 +1112,7 @@ static struct spi_driver at73c213_driver = {
 	.remove		= __devexit_p(snd_at73c213_remove),
 };
 
-static int __init at73c213_init(void)
-{
-	return spi_register_driver(&at73c213_driver);
-}
-module_init(at73c213_init);
-
-static void __exit at73c213_exit(void)
-{
-	spi_unregister_driver(&at73c213_driver);
-}
-module_exit(at73c213_exit);
+module_spi_driver(at73c213_driver);
 
 MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("Sound driver for AT73C213 with Atmel SSC");
-- 
1.7.5.4
