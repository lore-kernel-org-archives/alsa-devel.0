From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3] ASoC: multi-comp: OMAP McBSP: Enable audio
	on OMAP1 platform
Date: Fri,  6 Aug 2010 10:39:14 +0300
Message-ID: <1281080355-22589-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id F37DF103966
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

OMAP1 class has 3 McBSP ports, if I'm not mistaken.
Enable the audio with multi-comp on OMAP1 class.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap1/devices.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 379100c..523bbc4 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -267,6 +267,29 @@ static inline void omap_init_sti(void)
 static inline void omap_init_sti(void) {}
 #endif
 
+#if defined(CONFIG_SND_SOC) || defined(CONFIG_SND_SOC_MODULE)
+
+static struct platform_device omap_pcm = {
+	.name	= "omap-pcm-audio",
+	.id	= -1,
+};
+
+OMAP_MCBSP_PLATFORM_DEVICE(1);
+OMAP_MCBSP_PLATFORM_DEVICE(2);
+OMAP_MCBSP_PLATFORM_DEVICE(3);
+
+static void omap_init_audio(void)
+{
+	platform_device_register(&omap_mcbsp1);
+	platform_device_register(&omap_mcbsp2);
+	platform_device_register(&omap_mcbsp3);
+	platform_device_register(&omap_pcm);
+}
+
+#else
+static inline void omap_init_audio(void) {}
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -299,6 +322,7 @@ static int __init omap1_init_devices(void)
 	omap_init_rtc();
 	omap_init_spi100k();
 	omap_init_sti();
+	omap_init_audio();
 
 	return 0;
 }
-- 
1.7.2
