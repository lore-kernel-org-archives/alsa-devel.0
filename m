From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Add missing MODULE_ALIAS
Date: Fri,  6 Jul 2012 12:19:10 +0200
Message-ID: <1341569950-15074-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AA16103E5D
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 12:19:04 +0200 (CEST)
Received: by obbwc20 with SMTP id wc20so19970485obb.17
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 03:19:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The MODULE_ALIAS() was missing from the driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b5e23af..f7babb3 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -501,6 +501,7 @@ static struct platform_driver asoc_mcpdm_driver = {
 
 module_platform_driver(asoc_mcpdm_driver);
 
+MODULE_ALIAS("platform:omap-mcpdm");
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("OMAP PDM SoC Interface");
 MODULE_LICENSE("GPL");
-- 
1.7.8.6
