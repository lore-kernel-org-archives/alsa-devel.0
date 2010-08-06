From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 3/3] ASoC: multi-comp: OMAP2, 3,
	4 McBSP: register correct number of ports
Date: Fri,  6 Aug 2010 14:10:38 +0300
Message-ID: <1281093038-24247-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1281093038-24247-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A5B851039A1
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 13:10:50 +0200 (CEST)
In-Reply-To: <1281093038-24247-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: jkrzyszt@tis.icnet.pl, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Different OMAPs has different number of McBSP ports...
OMAP2420 has 2 McBSP ports
OMAP2430 has 5 McBSP ports
OMAP3 has 5 McBSP ports
OMAP4 has 4 McBSP ports

Since I don't have access to OMAP4 TRM, the number of ports on OMAP4
is guessed based on the original OMAP4 related McBSP code...

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/devices.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 758d39b..f9a5961 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -297,6 +297,12 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
+/*
+ * OMAP2420 has 2 McBSP ports
+ * OMAP2430 has 5 McBSP ports
+ * OMAP3 has 5 McBSP ports
+ * OMAP4 has 4 McBSP ports
+ */
 OMAP_MCBSP_PLATFORM_DEVICE(1);
 OMAP_MCBSP_PLATFORM_DEVICE(2);
 OMAP_MCBSP_PLATFORM_DEVICE(3);
@@ -307,9 +313,13 @@ static void omap_init_audio(void)
 {
 	platform_device_register(&omap_mcbsp1);
 	platform_device_register(&omap_mcbsp2);
-	platform_device_register(&omap_mcbsp3);
-	platform_device_register(&omap_mcbsp4);
-	platform_device_register(&omap_mcbsp5);
+	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		platform_device_register(&omap_mcbsp3);
+		platform_device_register(&omap_mcbsp4);
+	}
+	if (cpu_is_omap243x() || cpu_is_omap34xx())
+		platform_device_register(&omap_mcbsp5);
+
 	platform_device_register(&omap_pcm);
 }
 
@@ -317,7 +327,6 @@ static void omap_init_audio(void)
 static inline void omap_init_audio(void) {}
 #endif
 
-
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <plat/mcspi.h>
-- 
1.7.2
