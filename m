From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/3] ASoC: OMAP: Update Kconfig and Makefile
	files for HDMI audio codec
Date: Sat, 11 Feb 2012 18:23:17 -0600
Message-ID: <1329006197-28332-4-git-send-email-ricardo.neri@ti.com>
References: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 811311039F1
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 01:23:52 +0100 (CET)
In-Reply-To: <1329006197-28332-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, s-guiriec@ti.com
List-Id: alsa-devel@alsa-project.org

Update Makefile and Kconfig to select and build the HDMI audio codec.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/codecs/Kconfig  |    4 ++++
 sound/soc/codecs/Makefile |    5 +++++
 sound/soc/omap/Kconfig    |    1 +
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c205e7..dc6c792 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -41,6 +41,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98095 if I2C
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9877 if I2C
+	select SND_SOC_OMAP_HDMI_CODEC if OMAP4_DSS_HDMI
 	select SND_SOC_PCM3008
 	select SND_SOC_RT5631 if I2C
 	select SND_SOC_SGTL5000 if I2C
@@ -224,6 +225,9 @@ config SND_SOC_MAX98095
 config SND_SOC_MAX9850
 	tristate
 
+config SND_SOC_OMAP_HDMI_CODEC
+       tristate
+
 config SND_SOC_PCM3008
        tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index de80781..3a74d07 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -28,6 +28,7 @@ snd-soc-lm4857-objs := lm4857.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98095-objs := max98095.o
 snd-soc-max9850-objs := max9850.o
+snd-soc-omap-hdmi-codec-objs := omap-hdmi.o
 snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-sgtl5000-objs := sgtl5000.o
@@ -132,6 +133,7 @@ obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
+obj-$(CONFIG_SND_SOC_OMAP_HDMI_CODEC) += snd-soc-omap-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
@@ -201,3 +203,6 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+
+# for OMAP HDMI audio, DSS definitions are needed
+ccflags-$(CONFIG_SND_SOC_OMAP_HDMI_CODEC:m=y) += -Idrivers/video/omap2/dss
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fb1bf25..357490d 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -112,6 +112,7 @@ config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
 	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
 	select SND_OMAP_SOC_HDMI
+	select SND_SOC_OMAP_HDMI_CODEC
 	help
 	  Say Y if you want to add support for SoC HDMI audio on Texas Instruments
 	  OMAP4 chips
-- 
1.7.0.4
