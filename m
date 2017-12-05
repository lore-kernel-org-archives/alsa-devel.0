From: "Andrew F. Davis" <afd@ti.com>
Subject: [RFC PATCH 2/3] ASoC: Platforms: Move Davinci platform
	drivers into platforms directory
Date: Tue, 5 Dec 2017 12:14:47 -0600
Message-ID: <20171205181448.18513-3-afd@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 29AA2267670
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

Split the Davinci platform drivers from the machine drivers that use
these platform drivers by moving them into the new platforms directory.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/davinci/Kconfig                         | 37 -----------------------
 sound/soc/davinci/Makefile                        | 21 +++----------
 sound/soc/platforms/Kconfig                       |  2 ++
 sound/soc/platforms/Makefile                      |  2 ++
 sound/soc/platforms/davinci/Kconfig               | 36 ++++++++++++++++++++++
 sound/soc/{ => platforms}/davinci/Makefile        |  5 ---
 sound/soc/{ => platforms}/davinci/davinci-i2s.c   |  0
 sound/soc/{ => platforms}/davinci/davinci-i2s.h   |  0
 sound/soc/{ => platforms}/davinci/davinci-mcasp.c |  0
 sound/soc/{ => platforms}/davinci/davinci-mcasp.h |  0
 sound/soc/{ => platforms}/davinci/davinci-vcif.c  |  0
 sound/soc/{ => platforms}/davinci/edma-pcm.c      |  0
 sound/soc/{ => platforms}/davinci/edma-pcm.h      |  0
 13 files changed, 45 insertions(+), 58 deletions(-)
 rewrite sound/soc/davinci/Makefile (71%)
 create mode 100644 sound/soc/platforms/davinci/Kconfig
 copy sound/soc/{ => platforms}/davinci/Makefile (76%)
 rename sound/soc/{ => platforms}/davinci/davinci-i2s.c (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-i2s.h (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-mcasp.c (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-mcasp.h (100%)
 rename sound/soc/{ => platforms}/davinci/davinci-vcif.c (100%)
 rename sound/soc/{ => platforms}/davinci/edma-pcm.c (100%)
 rename sound/soc/{ => platforms}/davinci/edma-pcm.h (100%)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 6b732d8e5896..f1f0686acce4 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,40 +1,3 @@
-config SND_DAVINCI_SOC
-	tristate
-	depends on ARCH_DAVINCI
-	select SND_EDMA_SOC
-
-config SND_EDMA_SOC
-	tristate "SoC Audio for Texas Instruments chips using eDMA"
-	depends on TI_EDMA
-	select SND_SOC_GENERIC_DMAENGINE_PCM
-	help
-	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
-	  The following line of SoCs are supported by this platform driver:
-	  - daVinci devices
-	  - AM335x
-	  - AM437x/AM438x
-	  - DRA7xx family
-
-config SND_DAVINCI_SOC_I2S
-	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
-	depends on SND_EDMA_SOC
-	help
-	  Say Y or M here if you want to have support for McBSP IP found in
-	  Texas Instruments DaVinci DA850 SoCs.
-
-config SND_DAVINCI_SOC_MCASP
-	tristate "Multichannel Audio Serial Port (McASP) support"
-	depends on SND_OMAP_SOC || SND_EDMA_SOC
-	help
-	  Say Y or M here if you want to have support for McASP IP found in
-	  various Texas Instruments SoCs like:
-	  - daVinci devices
-	  - Sitara line of SoCs (AM335x, AM438x, etc)
-	  - DRA7x devices
-
-config SND_DAVINCI_SOC_VCIF
-	tristate
-
 config SND_DAVINCI_SOC_GENERIC_EVM
 	tristate
 	select SND_SOC_TLV320AIC3X
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
dissimilarity index 71%
index 23c6592eb31a..51b0d06e267b 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -1,16 +1,5 @@
-# SPDX-License-Identifier: GPL-2.0
-# DAVINCI Platform Support
-snd-soc-edma-objs := edma-pcm.o
-snd-soc-davinci-i2s-objs := davinci-i2s.o
-snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
-snd-soc-davinci-vcif-objs:= davinci-vcif.o
-
-obj-$(CONFIG_SND_EDMA_SOC) += snd-soc-edma.o
-obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
-obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
-obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
-
-# Generic DAVINCI/AM33xx Machine Support
-snd-soc-evm-objs := davinci-evm.o
-
-obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
+# SPDX-License-Identifier: GPL-2.0
+# Generic DAVINCI/AM33xx Machine Support
+snd-soc-evm-objs := davinci-evm.o
+
+obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
diff --git a/sound/soc/platforms/Kconfig b/sound/soc/platforms/Kconfig
index 620d1f292246..c4ba367e41c4 100644
--- a/sound/soc/platforms/Kconfig
+++ b/sound/soc/platforms/Kconfig
@@ -4,4 +4,6 @@
 
 menu "Platform drivers"
 
+source "sound/soc/platforms/davinci/Kconfig"
+
 endmenu
diff --git a/sound/soc/platforms/Makefile b/sound/soc/platforms/Makefile
index f66554cd5c45..49629e238da9 100644
--- a/sound/soc/platforms/Makefile
+++ b/sound/soc/platforms/Makefile
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+
+obj-y	+= davinci/
diff --git a/sound/soc/platforms/davinci/Kconfig b/sound/soc/platforms/davinci/Kconfig
new file mode 100644
index 000000000000..0a11b8f018ae
--- /dev/null
+++ b/sound/soc/platforms/davinci/Kconfig
@@ -0,0 +1,36 @@
+config SND_DAVINCI_SOC
+	tristate
+	depends on ARCH_DAVINCI
+	select SND_EDMA_SOC
+
+config SND_EDMA_SOC
+	tristate "SoC Audio for Texas Instruments chips using eDMA"
+	depends on TI_EDMA
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
+	  The following line of SoCs are supported by this platform driver:
+	  - daVinci devices
+	  - AM335x
+	  - AM437x/AM438x
+	  - DRA7xx family
+
+config SND_DAVINCI_SOC_I2S
+	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
+	depends on SND_EDMA_SOC
+	help
+	  Say Y or M here if you want to have support for McBSP IP found in
+	  Texas Instruments DaVinci DA850 SoCs.
+
+config SND_DAVINCI_SOC_MCASP
+	tristate "Multichannel Audio Serial Port (McASP) support"
+	depends on SND_OMAP_SOC || SND_EDMA_SOC
+	help
+	  Say Y or M here if you want to have support for McASP IP found in
+	  various Texas Instruments SoCs like:
+	  - daVinci devices
+	  - Sitara line of SoCs (AM335x, AM438x, etc)
+	  - DRA7x devices
+
+config SND_DAVINCI_SOC_VCIF
+	tristate
diff --git a/sound/soc/davinci/Makefile b/sound/soc/platforms/davinci/Makefile
similarity index 76%
copy from sound/soc/davinci/Makefile
copy to sound/soc/platforms/davinci/Makefile
index 23c6592eb31a..8d7d8017d82b 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/platforms/davinci/Makefile
@@ -9,8 +9,3 @@ obj-$(CONFIG_SND_EDMA_SOC) += snd-soc-edma.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
 obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
-
-# Generic DAVINCI/AM33xx Machine Support
-snd-soc-evm-objs := davinci-evm.o
-
-obj-$(CONFIG_SND_DAVINCI_SOC_GENERIC_EVM) += snd-soc-evm.o
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/platforms/davinci/davinci-i2s.c
similarity index 100%
rename from sound/soc/davinci/davinci-i2s.c
rename to sound/soc/platforms/davinci/davinci-i2s.c
diff --git a/sound/soc/davinci/davinci-i2s.h b/sound/soc/platforms/davinci/davinci-i2s.h
similarity index 100%
rename from sound/soc/davinci/davinci-i2s.h
rename to sound/soc/platforms/davinci/davinci-i2s.h
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/platforms/davinci/davinci-mcasp.c
similarity index 100%
rename from sound/soc/davinci/davinci-mcasp.c
rename to sound/soc/platforms/davinci/davinci-mcasp.c
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/platforms/davinci/davinci-mcasp.h
similarity index 100%
rename from sound/soc/davinci/davinci-mcasp.h
rename to sound/soc/platforms/davinci/davinci-mcasp.h
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/platforms/davinci/davinci-vcif.c
similarity index 100%
rename from sound/soc/davinci/davinci-vcif.c
rename to sound/soc/platforms/davinci/davinci-vcif.c
diff --git a/sound/soc/davinci/edma-pcm.c b/sound/soc/platforms/davinci/edma-pcm.c
similarity index 100%
rename from sound/soc/davinci/edma-pcm.c
rename to sound/soc/platforms/davinci/edma-pcm.c
diff --git a/sound/soc/davinci/edma-pcm.h b/sound/soc/platforms/davinci/edma-pcm.h
similarity index 100%
rename from sound/soc/davinci/edma-pcm.h
rename to sound/soc/platforms/davinci/edma-pcm.h
-- 
2.15.0
