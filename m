From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/6] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Thu,  5 May 2011 02:21:48 -0500
Message-ID: <1304580113-24819-2-git-send-email-ricardo.neri@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EBE1A103955
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

Add device for HDMI audio. This device uses hwmod data from
dss_hdmi. This device is to be used by the ASoC HDMI CPU DAI to
obtain base memory address and DMA request number.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b85585..a62f691 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -313,6 +313,25 @@ OMAP_MCBSP_PLATFORM_DEVICE(5);
 
 static void omap_init_audio(void)
 {
+#if defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) || \
+	defined(CONFIG_SND_OMAP_SOC_OMAP4_HDMI_MODULE)
+	struct omap_hwmod *oh_hdmi;
+	struct omap_device *od_hdmi;
+	char *oh_hdmi_name = "dss_hdmi";
+	char *dev_hdmi_name = "hdmi-audio-dai";
+
+	if (cpu_is_omap44xx()) {
+		oh_hdmi = omap_hwmod_lookup(oh_hdmi_name);
+		WARN(!oh_hdmi, "%s: could not find omap_hwmod for %s\n",
+			__func__, oh_hdmi_name);
+
+		od_hdmi = omap_device_build(dev_hdmi_name, -1, oh_hdmi, NULL, 0,
+			NULL, 0, false);
+		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
+			__func__, dev_hdmi_name);
+	}
+#endif
+
 	platform_device_register(&omap_mcbsp1);
 	platform_device_register(&omap_mcbsp2);
 	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-- 
1.7.1
