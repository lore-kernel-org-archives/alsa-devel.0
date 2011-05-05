From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 6/6] ASoC: OMAP: Update Makefile and Kconfig
	for HDMI audio
Date: Thu,  5 May 2011 02:21:53 -0500
Message-ID: <1304580113-24819-7-git-send-email-ricardo.neri@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EA01D10394A
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

Update Makefile and Kconfig to build HDMI audio support for
OMAP4 SDP and Panda boards.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/Kconfig  |   11 +++++++++++
 sound/soc/omap/Makefile |    4 ++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index b592298..e8ca5be 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -9,6 +9,9 @@ config SND_OMAP_SOC_MCBSP
 config SND_OMAP_SOC_MCPDM
 	tristate
 
+config SND_OMAP_SOC_HDMI
+	tristate
+
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
@@ -108,6 +111,14 @@ config SND_OMAP_SOC_SDP4430
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP4430.
 
+config SND_OMAP_SOC_OMAP4_HDMI
+	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
+	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
+	select SND_OMAP_SOC_HDMI
+	help
+	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
+	  OMAP4 chips
+
 config SND_OMAP_SOC_OMAP3_PANDORA
 	tristate "SoC Audio support for OMAP3 Pandora"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_PANDORA
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index ba9fc65..8016642 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -2,10 +2,12 @@
 snd-soc-omap-objs := omap-pcm.o
 snd-soc-omap-mcbsp-objs := omap-mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o mcpdm.o
+snd-soc-omap-hdmi-objs := omap-hdmi.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
+obj-$(CONFIG_SND_OMAP_SOC_HDMI) += snd-soc-omap-hdmi.o
 
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
@@ -22,6 +24,7 @@ snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
 snd-soc-igep0020-objs := igep0020.o
+snd-soc-omap4-hdmi-objs := omap4-hdmi-card.o
 
 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_RX51) += snd-soc-rx51.o
@@ -37,3 +40,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) += snd-soc-omap4-hdmi.o
-- 
1.7.1
