From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 1/5] OMAP4: HDMI: Add OMAP device for HDMI
	audio CPU DAI
Date: Sun, 15 May 2011 04:36:31 -0500
Message-ID: <1305452195-19177-2-git-send-email-ricardo.neri@ti.com>
References: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 63CE610380A
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 11:38:11 +0200 (CEST)
In-Reply-To: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com, tomi.valkeinen@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

Add device for HDMI audio. This device uses hwmod data from
dss_hdmi. This device is to be used by the ASoC HDMI CPU DAI to
obtain base memory address and DMA request number.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 7b85585..56e2e98 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -313,6 +313,22 @@ OMAP_MCBSP_PLATFORM_DEVICE(5);
 
 static void omap_init_audio(void)
 {
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
+
 	platform_device_register(&omap_mcbsp1);
 	platform_device_register(&omap_mcbsp2);
 	if (cpu_is_omap243x() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-- 
1.7.0.4
