From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] ALSA: ASoC: au1x: fix ac97c module build
Date: Mon, 15 Jul 2013 14:18:22 +0200
Message-ID: <1373890702-1353-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f43.google.com (mail-ee0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 876662608D4
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 14:18:27 +0200 (CEST)
Received: by mail-ee0-f43.google.com with SMTP id l10so7474948eei.16
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 05:18:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

The recent conversion to module_platform_driver left a stray
ampersand in there preventing a build.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Against 3.11-rc1

 sound/soc/au1x/ac97c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index d6f7694..c8a2de1 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -341,7 +341,7 @@ static struct platform_driver au1xac97c_driver = {
 	.remove		= au1xac97c_drvremove,
 };
 
-module_platform_driver(&au1xac97c_driver);
+module_platform_driver(au1xac97c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1000/1500/1100 AC97C ASoC driver");
-- 
1.8.3.2
