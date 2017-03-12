From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 3/4] sound: arm: Add build system for bcm2835-analog-audio driver.
Date: Sat, 11 Mar 2017 22:38:19 -0800
Message-ID: <20170312063820.19313-3-mzoran@crowfest.net>
References: <20170312063820.19313-1-mzoran@crowfest.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170312063820.19313-1-mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-AbSShOkvfpQ@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, stefan.wahren-eS4NqCHxEME@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Update the build system to add the bcm2835-analog-audio driver.

Signed-off-by: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
---
 sound/arm/Kconfig  | 10 +++++++++-
 sound/arm/Makefile |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 65171f6657a2..71aef1dae6b8 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -2,7 +2,7 @@
 
 menuconfig SND_ARM
 	bool "ARM sound devices"
-	depends on ARM
+	depends on ARM || ARM64
 	default y
 	help
 	  Support for sound devices specific to ARM architectures.
@@ -11,6 +11,14 @@ menuconfig SND_ARM
 
 if SND_ARM
 
+config SND_BCM2835_ANALOG_AUDIO
+	tristate "Analog/Headphone jack support for BCM2835"
+	depends on ARCH_BCM2835 && HAS_DMA
+	select SND_PCM
+	help
+	    Say y or m to support the analog/headphone jack
+	    for the BCM2835 as used by the Raspberry PI.
+
 config SND_ARMAACI
 	tristate "ARM PrimeCell PL041 AC Link support"
 	depends on ARM_AMBA
diff --git a/sound/arm/Makefile b/sound/arm/Makefile
index 8c0c851d4641..744ff77e580a 100644
--- a/sound/arm/Makefile
+++ b/sound/arm/Makefile
@@ -14,3 +14,6 @@ snd-pxa2xx-lib-$(CONFIG_SND_PXA2XX_LIB_AC97)	+= pxa2xx-ac97-lib.o
 
 obj-$(CONFIG_SND_PXA2XX_AC97)	+= snd-pxa2xx-ac97.o
 snd-pxa2xx-ac97-objs		:= pxa2xx-ac97.o
+
+obj-$(CONFIG_SND_BCM2835_ANALOG_AUDIO) += bcm2835-analog-audio.o
+
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
