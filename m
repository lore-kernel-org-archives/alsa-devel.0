From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/2] ASoC: fsl: move machine drivers to
	late_initcall()
Date: Tue, 11 Sep 2012 11:23:27 -0500
Message-ID: <1347380607-1564-2-git-send-email-timur@freescale.com>
References: <1347380607-1564-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 1719D260319
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 18:23:44 +0200 (CEST)
In-Reply-To: <1347380607-1564-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Transition the module initialization to late_initcall(), so that
the machine driver loads last.  Although this is technically not
necessary, it does avoid this error message at boot time:

	ALSA device list:
	  No soundcards found.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 5479882..65347de 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -430,7 +430,7 @@ static void __exit mpc8610_hpcd_exit(void)
 	platform_driver_unregister(&mpc8610_hpcd_driver);
 }
 
-module_init(mpc8610_hpcd_init);
+late_initcall(mpc8610_hpcd_init);
 module_exit(mpc8610_hpcd_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index a44a8c3..13110c4 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -439,7 +439,7 @@ static void __exit p1022_ds_exit(void)
 	platform_driver_unregister(&p1022_ds_driver);
 }
 
-module_init(p1022_ds_init);
+late_initcall(p1022_ds_init);
 module_exit(p1022_ds_exit);
 
 MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
-- 
1.7.3.4
