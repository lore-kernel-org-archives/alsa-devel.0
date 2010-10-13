From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Move soc-core module init next to
	functon definition
Date: Wed, 13 Oct 2010 10:57:33 +0100
Message-ID: <1286963853-10116-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 222ED24477
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:57:36 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f4286ab..4cbfe46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3311,6 +3311,7 @@ static int __init snd_soc_init(void)
 
 	return platform_driver_register(&soc_driver);
 }
+module_init(snd_soc_init);
 
 static void __exit snd_soc_exit(void)
 {
@@ -3319,8 +3320,6 @@ static void __exit snd_soc_exit(void)
 #endif
 	platform_driver_unregister(&soc_driver);
 }
-
-module_init(snd_soc_init);
 module_exit(snd_soc_exit);
 
 /* Module information */
-- 
1.7.1
