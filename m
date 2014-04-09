From: Christoph Jaeger <christophjaeger@linux.com>
Subject: [PATCH] ALSA: au1x00: use module_platform_driver()
Date: Wed,  9 Apr 2014 09:42:32 +0200
Message-ID: <1397029352-30889-1-git-send-email-christophjaeger@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de
 [80.67.31.96]) by alsa0.perex.cz (Postfix) with ESMTP id 0A472260859
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 09:43:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de, mano@roarinelk.homelinux.net
Cc: alsa-devel@alsa-project.org, Christoph Jaeger <christophjaeger@linux.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Eliminate boilerplate code by using module_platform_driver().

Signed-off-by: Christoph Jaeger <christophjaeger@linux.com>
---
 sound/mips/au1x00.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index a7cc49e..d10ef76 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -725,15 +725,4 @@ struct platform_driver au1000_ac97c_driver = {
 	.remove		= au1000_ac97_remove,
 };
 
-static int __init au1000_ac97_load(void)
-{
-	return platform_driver_register(&au1000_ac97c_driver);
-}
-
-static void __exit au1000_ac97_unload(void)
-{
-	platform_driver_unregister(&au1000_ac97c_driver);
-}
-
-module_init(au1000_ac97_load);
-module_exit(au1000_ac97_unload);
+module_platform_driver(au1000_ac97c_driver);
-- 
1.9.0
