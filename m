From: "Andrew F. Davis" <afd@ti.com>
Subject: [RFC PATCH 3/3] ASoC: Platforms: Move OMAP platform
	drivers into platforms directory
Date: Tue, 5 Dec 2017 12:14:48 -0600
Message-ID: <20171205181448.18513-4-afd@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 32A622677B7
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 19:14:50 +0100 (CET)
In-Reply-To: <20171205181448.18513-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Split the OMAP platform drivers from the machine drivers that use
these platform drivers by moving them into the new platforms directory.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 MAINTAINERS                                      |  1 +
 sound/soc/omap/Kconfig                           | 29 ------------------------
 sound/soc/omap/Makefile                          | 13 -----------
 sound/soc/omap/am3517evm.c                       |  2 +-
 sound/soc/omap/ams-delta.c                       |  2 +-
 sound/soc/omap/n810.c                            |  2 +-
 sound/soc/omap/omap-abe-twl6040.c                |  4 ++--
 sound/soc/omap/omap-twl4030.c                    |  2 +-
 sound/soc/omap/omap3pandora.c                    |  2 +-
 sound/soc/omap/osk5912.c                         |  2 +-
 sound/soc/omap/rx51.c                            |  2 +-
 sound/soc/platforms/Kconfig                      |  1 +
 sound/soc/platforms/Makefile                     |  1 +
 sound/soc/platforms/omap/Kconfig                 | 28 +++++++++++++++++++++++
 sound/soc/platforms/omap/Makefile                | 13 +++++++++++
 sound/soc/{ => platforms}/omap/mcbsp.c           |  0
 sound/soc/{ => platforms}/omap/mcbsp.h           |  0
 sound/soc/{ => platforms}/omap/omap-dmic.c       |  0
 sound/soc/{ => platforms}/omap/omap-dmic.h       |  0
 sound/soc/{ => platforms}/omap/omap-hdmi-audio.c |  0
 sound/soc/{ => platforms}/omap/omap-mcbsp.c      |  0
 sound/soc/{ => platforms}/omap/omap-mcbsp.h      |  0
 sound/soc/{ => platforms}/omap/omap-mcpdm.c      |  0
 sound/soc/{ => platforms}/omap/omap-mcpdm.h      |  0
 sound/soc/{ => platforms}/omap/omap-pcm.c        |  0
 25 files changed, 53 insertions(+), 51 deletions(-)
 create mode 100644 sound/soc/platforms/omap/Kconfig
 create mode 100644 sound/soc/platforms/omap/Makefile
 rename sound/soc/{ => platforms}/omap/mcbsp.c (100%)
 rename sound/soc/{ => platforms}/omap/mcbsp.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-dmic.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-dmic.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-hdmi-audio.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcbsp.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcbsp.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcpdm.c (100%)
 rename sound/soc/{ => platforms}/omap/omap-mcpdm.h (100%)
 rename sound/soc/{ => platforms}/omap/omap-pcm.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..5dbd55449564 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9826,6 +9826,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	sound/soc/omap/
+F:	sound/soc/platforms/omap/
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index f5451c78ede5..aed03c4894a9 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -1,32 +1,3 @@
-config SND_OMAP_SOC
-	tristate "SoC Audio for the Texas Instruments OMAP chips"
-	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
-	select SND_DMAENGINE_PCM
-
-config SND_OMAP_SOC_DMIC
-	tristate
-
-config SND_OMAP_SOC_MCBSP
-	tristate
-
-config SND_OMAP_SOC_MCPDM
-	tristate
-
-config SND_OMAP_SOC_HDMI_AUDIO
-	tristate "HDMI audio support for OMAP4+ based SoCs"
-	depends on SND_OMAP_SOC
-	help
-	  For HDMI audio to work OMAPDSS HDMI support should be
-	  enabled.
-	  The hdmi audio driver implements cpu-dai component using the
-	  callbacks provided by OMAPDSS and registers the component
-	  under DSS HDMI device. Omap-pcm is registered for platform
-	  component also under DSS HDMI device. Dummy codec is used as
-	  as codec component. The hdmi audio driver implements also
-	  the card and registers it under its own platform device.
-	  The device for the driver is registered by OMAPDSS hdmi
-	  driver.
-
 config SND_OMAP_SOC_N810
 	tristate "SoC Audio support for Nokia N810"
 	depends on SND_OMAP_SOC && MACH_NOKIA_N810 && I2C
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index a6785dc4fc90..827f8a211e03 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,17 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# OMAP Platform Support
-snd-soc-omap-objs := omap-pcm.o
-snd-soc-omap-dmic-objs := omap-dmic.o
-snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
-snd-soc-omap-mcpdm-objs := omap-mcpdm.o
-snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
-
-obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
-obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
-obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
-obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
-obj-$(CONFIG_SND_OMAP_SOC_HDMI_AUDIO) += snd-soc-omap-hdmi-audio.o
-
 # OMAP Machine Support
 snd-soc-n810-objs := n810.o
 snd-soc-rx51-objs := rx51.o
diff --git a/sound/soc/omap/am3517evm.c b/sound/soc/omap/am3517evm.c
index d5651026ec10..7de6a4d08df8 100644
--- a/sound/soc/omap/am3517evm.c
+++ b/sound/soc/omap/am3517evm.c
@@ -27,7 +27,7 @@
 #include <asm/mach-types.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 
 #include "../codecs/tlv320aic23.h"
 
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index d40219678700..2d4020594935 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -35,7 +35,7 @@
 #include <mach/board-ams-delta.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 #include "../codecs/cx20442.h"
 
 /* Board specific DAPM widgets */
diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 71e5f31fa306..fa00121da632 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -33,7 +33,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 
 #define N810_HEADSET_AMP_GPIO	10
 #define N810_SPEAKER_AMP_GPIO	101
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 614b18d2f631..b98c017d2da9 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -31,8 +31,8 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include "omap-dmic.h"
-#include "omap-mcpdm.h"
+#include "../platforms/omap/omap-dmic.h"
+#include "../platforms/omap/omap-mcpdm.h"
 #include "../codecs/twl6040.h"
 
 struct abe_twl6040 {
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4030.c
index cccc316743fa..997e1bb9c979 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -42,7 +42,7 @@
 #include <sound/soc.h>
 #include <sound/jack.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 
 struct omap_twl4030 {
 	int jack_detect;	/* board can detect jack events */
diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 4e3de712159c..5912b4b9661f 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -33,7 +33,7 @@
 #include <asm/mach-types.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 
 #define OMAP3_PANDORA_DAC_POWER_GPIO	118
 #define OMAP3_PANDORA_AMP_POWER_GPIO	14
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index e4096779ca05..9a58403f29ff 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -32,7 +32,7 @@
 #include <linux/module.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 #include "../codecs/tlv320aic23.h"
 
 #define CODEC_CLOCK 	12000000
diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 57448bd5ad77..adf078e76fab 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -36,7 +36,7 @@
 
 #include <asm/mach-types.h>
 
-#include "omap-mcbsp.h"
+#include "../platforms/omap/omap-mcbsp.h"
 
 enum {
 	RX51_JACK_DISABLED,
diff --git a/sound/soc/platforms/Kconfig b/sound/soc/platforms/Kconfig
index c4ba367e41c4..472988d07f9d 100644
--- a/sound/soc/platforms/Kconfig
+++ b/sound/soc/platforms/Kconfig
@@ -5,5 +5,6 @@
 menu "Platform drivers"
 
 source "sound/soc/platforms/davinci/Kconfig"
+source "sound/soc/platforms/omap/Kconfig"
 
 endmenu
diff --git a/sound/soc/platforms/Makefile b/sound/soc/platforms/Makefile
index 49629e238da9..c9ebc3606069 100644
--- a/sound/soc/platforms/Makefile
+++ b/sound/soc/platforms/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y	+= davinci/
+obj-y	+= omap/
diff --git a/sound/soc/platforms/omap/Kconfig b/sound/soc/platforms/omap/Kconfig
new file mode 100644
index 000000000000..90cf9a78c24b
--- /dev/null
+++ b/sound/soc/platforms/omap/Kconfig
@@ -0,0 +1,28 @@
+config SND_OMAP_SOC
+	tristate "SoC Audio for the Texas Instruments OMAP chips"
+	depends on (ARCH_OMAP && DMA_OMAP) || (ARM && COMPILE_TEST)
+	select SND_DMAENGINE_PCM
+
+config SND_OMAP_SOC_DMIC
+	tristate
+
+config SND_OMAP_SOC_MCBSP
+	tristate
+
+config SND_OMAP_SOC_MCPDM
+	tristate
+
+config SND_OMAP_SOC_HDMI_AUDIO
+	tristate "HDMI audio support for OMAP4+ based SoCs"
+	depends on SND_OMAP_SOC
+	help
+	  For HDMI audio to work OMAPDSS HDMI support should be
+	  enabled.
+	  The hdmi audio driver implements cpu-dai component using the
+	  callbacks provided by OMAPDSS and registers the component
+	  under DSS HDMI device. Omap-pcm is registered for platform
+	  component also under DSS HDMI device. Dummy codec is used as
+	  as codec component. The hdmi audio driver implements also
+	  the card and registers it under its own platform device.
+	  The device for the driver is registered by OMAPDSS hdmi
+	  driver.
diff --git a/sound/soc/platforms/omap/Makefile b/sound/soc/platforms/omap/Makefile
new file mode 100644
index 000000000000..1e83ac1f664b
--- /dev/null
+++ b/sound/soc/platforms/omap/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# OMAP Platform Support
+snd-soc-omap-objs := omap-pcm.o
+snd-soc-omap-dmic-objs := omap-dmic.o
+snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
+snd-soc-omap-mcpdm-objs := omap-mcpdm.o
+snd-soc-omap-hdmi-audio-objs := omap-hdmi-audio.o
+
+obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
+obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
+obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
+obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
+obj-$(CONFIG_SND_OMAP_SOC_HDMI_AUDIO) += snd-soc-omap-hdmi-audio.o
diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/platforms/omap/mcbsp.c
similarity index 100%
rename from sound/soc/omap/mcbsp.c
rename to sound/soc/platforms/omap/mcbsp.c
diff --git a/sound/soc/omap/mcbsp.h b/sound/soc/platforms/omap/mcbsp.h
similarity index 100%
rename from sound/soc/omap/mcbsp.h
rename to sound/soc/platforms/omap/mcbsp.h
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/platforms/omap/omap-dmic.c
similarity index 100%
rename from sound/soc/omap/omap-dmic.c
rename to sound/soc/platforms/omap/omap-dmic.c
diff --git a/sound/soc/omap/omap-dmic.h b/sound/soc/platforms/omap/omap-dmic.h
similarity index 100%
rename from sound/soc/omap/omap-dmic.h
rename to sound/soc/platforms/omap/omap-dmic.h
diff --git a/sound/soc/omap/omap-hdmi-audio.c b/sound/soc/platforms/omap/omap-hdmi-audio.c
similarity index 100%
rename from sound/soc/omap/omap-hdmi-audio.c
rename to sound/soc/platforms/omap/omap-hdmi-audio.c
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/platforms/omap/omap-mcbsp.c
similarity index 100%
rename from sound/soc/omap/omap-mcbsp.c
rename to sound/soc/platforms/omap/omap-mcbsp.c
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/platforms/omap/omap-mcbsp.h
similarity index 100%
rename from sound/soc/omap/omap-mcbsp.h
rename to sound/soc/platforms/omap/omap-mcbsp.h
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/platforms/omap/omap-mcpdm.c
similarity index 100%
rename from sound/soc/omap/omap-mcpdm.c
rename to sound/soc/platforms/omap/omap-mcpdm.c
diff --git a/sound/soc/omap/omap-mcpdm.h b/sound/soc/platforms/omap/omap-mcpdm.h
similarity index 100%
rename from sound/soc/omap/omap-mcpdm.h
rename to sound/soc/platforms/omap/omap-mcpdm.h
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/platforms/omap/omap-pcm.c
similarity index 100%
rename from sound/soc/omap/omap-pcm.c
rename to sound/soc/platforms/omap/omap-pcm.c
-- 
2.15.0
