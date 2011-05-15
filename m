From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 2/5] OMAP4: Add device for HDMI OMAP4 audio
	for ASoC machine driver
Date: Sun, 15 May 2011 04:36:32 -0500
Message-ID: <1305452195-19177-3-git-send-email-ricardo.neri@ti.com>
References: <1305452195-19177-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FFBA1037EA
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

This device is used by the OMAP4 HDMI audio machine driver to register the
HDMI sound card.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 56e2e98..6add0d2 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -300,6 +300,14 @@ static struct platform_device omap_pcm = {
 };
 
 /*
+ * Device for the ASoC OMAP4 HDMI machine driver
+ */
+static struct platform_device omap4_hdmi_audio = {
+	.name	= "omap4-hdmi-audio",
+	.id	= -1,
+};
+
+/*
  * OMAP2420 has 2 McBSP ports
  * OMAP2430 has 5 McBSP ports
  * OMAP3 has 5 McBSP ports
@@ -327,6 +335,8 @@ static void omap_init_audio(void)
 			NULL, 0, false);
 		WARN(IS_ERR(od_hdmi), "%s: could not build omap_device for %s\n",
 			__func__, dev_hdmi_name);
+
+		platform_device_register(&omap4_hdmi_audio);
 	}
 
 	platform_device_register(&omap_mcbsp1);
-- 
1.7.0.4
