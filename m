From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/6] OMAP4: Add device for HDMI OMAP4 audio for
	ASoC machine driver
Date: Thu,  5 May 2011 02:21:49 -0500
Message-ID: <1304580113-24819-3-git-send-email-ricardo.neri@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 174F5103985
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 09:21:48 +0200 (CEST)
In-Reply-To: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

This device is used by the OMAP4 HDMI audio machine driver to register the
HDMI sound card.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index a62f691..c407b9f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -299,6 +299,17 @@ static struct platform_device omap_pcm = {
 	.id	= -1,
 };
 
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+/*
+ * Device for the ASoC OMAP4 HDMI machine driver
+ */
+static struct platform_device omap4_hdmi_audio = {
+	.name	= "omap4-hdmi-audio",
+	.id	= -1,
+};
+#endif
+
 /*
  * OMAP2420 has 2 McBSP ports
  * OMAP2430 has 5 McBSP ports
@@ -329,6 +340,8 @@ static void omap_init_audio(void)
 			NULL, 0, false);
 		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
 			__func__, dev_hdmi_name);
+
+		platform_device_register(&omap4_hdmi_audio);
 	}
 #endif
 
-- 
1.7.1
