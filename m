From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: psc-ac97: Convert to
	module_platform_driver()
Date: Wed, 26 Jun 2013 11:35:36 +0100
Message-ID: <1372242937-9278-2-git-send-email-broonie@kernel.org>
References: <1372242937-9278-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CCC265312
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 12:37:11 +0200 (CEST)
In-Reply-To: <1372242937-9278-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/au1x/psc-ac97.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index f5a3921..a97ba13 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -497,19 +497,7 @@ static struct platform_driver au1xpsc_ac97_driver = {
 	.remove		= au1xpsc_ac97_drvremove,
 };
 
-static int __init au1xpsc_ac97_load(void)
-{
-	au1xpsc_ac97_workdata = NULL;
-	return platform_driver_register(&au1xpsc_ac97_driver);
-}
-
-static void __exit au1xpsc_ac97_unload(void)
-{
-	platform_driver_unregister(&au1xpsc_ac97_driver);
-}
-
-module_init(au1xpsc_ac97_load);
-module_exit(au1xpsc_ac97_unload);
+module_platform_driver(au1xpsc_ac97_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC AC97 ALSA ASoC audio driver");
-- 
1.8.3.1
