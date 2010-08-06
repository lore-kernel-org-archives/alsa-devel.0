From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/3] ASoC: multi-comp: OMAP McBSP: use macro
	for platform_device
Date: Fri,  6 Aug 2010 10:39:13 +0300
Message-ID: <1281080355-22589-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A8F69103951
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 09:39:24 +0200 (CEST)
In-Reply-To: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: jkrzyszt@tis.icnet.pl, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Use macro (and define it in the plat/mcbsp.h) to create
the omap-mcbsp-dai devices.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/devices.c           |   29 +++++------------------------
 arch/arm/plat-omap/include/plat/mcbsp.h |    7 +++++++
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 088b050..758d39b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -297,30 +297,11 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
-static struct platform_device omap_mcbsp1 = {
-	.name	= "omap-mcbsp-dai",
-	.id	= OMAP_MCBSP1,
-};
-
-static struct platform_device omap_mcbsp2 = {
-	.name	= "omap-mcbsp-dai",
-	.id	= OMAP_MCBSP2,
-};
-
-static struct platform_device omap_mcbsp3 = {
-	.name	= "omap-mcbsp-dai",
-	.id	= OMAP_MCBSP3,
-};
-
-static struct platform_device omap_mcbsp4 = {
-	.name	= "omap-mcbsp-dai",
-	.id	= OMAP_MCBSP4,
-};
-
-static struct platform_device omap_mcbsp5 = {
-	.name	= "omap-mcbsp-dai",
-	.id	= OMAP_MCBSP5,
-};
+OMAP_MCBSP_PLATFORM_DEVICE(1);
+OMAP_MCBSP_PLATFORM_DEVICE(2);
+OMAP_MCBSP_PLATFORM_DEVICE(3);
+OMAP_MCBSP_PLATFORM_DEVICE(4);
+OMAP_MCBSP_PLATFORM_DEVICE(5);
 
 static void omap_init_audio(void)
 {
diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index b4ff6a1..5b20103 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -30,6 +30,13 @@
 #include <mach/hardware.h>
 #include <plat/clock.h>
 
+/* macro for building platform_device for McBSP ports */
+#define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
+static struct platform_device omap_mcbsp##port_nr = {	\
+	.name	= "omap-mcbsp-dai",			\
+	.id	= OMAP_MCBSP##port_nr,			\
+}
+
 #define OMAP7XX_MCBSP1_BASE	0xfffb1000
 #define OMAP7XX_MCBSP2_BASE	0xfffb1800
 
-- 
1.7.2
