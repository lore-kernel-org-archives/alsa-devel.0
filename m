From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: multi-comp: OMAP2, 3,
	4 McBSP: register correct number of ports
Date: Fri,  6 Aug 2010 10:39:15 +0300
Message-ID: <1281080355-22589-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A1910395F
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 09:39:37 +0200 (CEST)
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

Different OMAPs has different number of McBSP ports...
OMAP2420 has 2 McBSP ports
OMAP2430 has 5 McBSP ports
OMAP3 has 5 McBSP ports
OMAP4 has 4 McBSP ports

Since I don't have access to OMAP4 TRM, the number of ports on OMAP4
is guessed based on the original OMAP4 related McBSP code...

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/devices.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 758d39b..d78cf6a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -297,19 +297,42 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
+/*
+ * OMAP2420 has 2 McBSP ports
+ * OMAP2430 has 5 McBSP ports
+ * OMAP3 has 5 McBSP ports
+ * OMAP4 has 4 McBSP ports
+ */
+#if defined(CONFIG_ARCH_OMAP4) ||		\
+    defined(CONFIG_ARCH_OMAP3) ||	\
+    defined(CONFIG_ARCH_OMAP2430)
+#define OMAP_HAS_4_MCBSP_PORTS
+#endif
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP2430)
+#define OMAP_HAS_5_MCBSP_PORTS
+#endif
+
 OMAP_MCBSP_PLATFORM_DEVICE(1);
 OMAP_MCBSP_PLATFORM_DEVICE(2);
+#ifdef OMAP_HAS_4_MCBSP_PORTS
 OMAP_MCBSP_PLATFORM_DEVICE(3);
 OMAP_MCBSP_PLATFORM_DEVICE(4);
+#endif
+#ifdef OMAP_HAS_5_MCBSP_PORTS
 OMAP_MCBSP_PLATFORM_DEVICE(5);
+#endif
 
 static void omap_init_audio(void)
 {
 	platform_device_register(&omap_mcbsp1);
 	platform_device_register(&omap_mcbsp2);
+#ifdef OMAP_HAS_4_MCBSP_PORTS
 	platform_device_register(&omap_mcbsp3);
 	platform_device_register(&omap_mcbsp4);
+#endif
+#ifdef OMAP_HAS_5_MCBSP_PORTS
 	platform_device_register(&omap_mcbsp5);
+#endif
 	platform_device_register(&omap_pcm);
 }
 
-- 
1.7.2
