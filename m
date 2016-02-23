From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/4 RESEND] ARC: axs10x: Update defconfigs so that audio is enabled
Date: Tue, 23 Feb 2016 13:51:12 +0000
Message-ID: <174bd675951f46071d0db8ea1f67abb083053332.1456234503.git.joabreu@synopsys.com>
References: <cover.1456234503.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
In-Reply-To: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
References: <cover.1456234503.git.joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The defconfigs for the AXS boards were updated so that
ALSA SoC is enabled and also the audio for the ADV7511
HDMI transmitter.

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 arch/arc/configs/axs101_defconfig     | 3 +++
 arch/arc/configs/axs103_defconfig     | 5 +++++
 arch/arc/configs/axs103_smp_defconfig | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index e359099..7c22163 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -113,3 +113,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 323486d..d63aef0 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -76,12 +76,14 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_DRM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
+CONFIG_DRM_I2C_ADV7511=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
@@ -114,3 +116,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 66191cd..f4b51ce 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -77,12 +77,14 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_DRM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
+CONFIG_DRM_I2C_ADV7511=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
@@ -115,3 +117,6 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
