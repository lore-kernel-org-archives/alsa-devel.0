From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 11/11] ASoC: SOF: Add Build support for SOF core
Date: Thu, 19 Jul 2018 19:53:35 +0100
Message-ID: <20180719185335.30912-11-liam.r.girdwood@linux.intel.com>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 361FD26770A
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 20:54:07 +0200 (CEST)
In-Reply-To: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Build SOF core.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/Kconfig      |  1 +
 sound/soc/Makefile     |  1 +
 sound/soc/sof/Kconfig  | 38 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/Makefile |  6 ++++++
 4 files changed, 46 insertions(+)
 create mode 100644 sound/soc/sof/Kconfig
 create mode 100644 sound/soc/sof/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 41af6b9cc350..2c0e6e5c7d7e 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -64,6 +64,7 @@ source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
+source "sound/soc/sof/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sti/Kconfig"
 source "sound/soc/stm/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 06389a5385d7..06ecbabefe03 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
+obj-$(CONFIG_SND_SOC)	+= sof/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= stm/
diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
new file mode 100644
index 000000000000..73cb59801d1e
--- /dev/null
+++ b/sound/soc/sof/Kconfig
@@ -0,0 +1,38 @@
+config SND_SOC_SOF_PCI
+	tristate
+
+config SND_SOC_SOF_ACPI
+	tristate
+
+config SND_SOC_SOF_PLATFORM
+	tristate
+
+config SND_SOC_SOF
+	tristate "Sound Open Firmware Support"
+	default m
+	select SND_SOC_TOPOLOGY
+	select SND_SOC_COMPRESS
+	help
+          This adds support for Sound Open Firmware (SOF). SOF is a free and
+	  generic open source audio DSP firmware for multiple devices.
+          Say Y if you have such a device that is supported by SOF.
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG
+	bool "SOF debugging features"
+	depends on SND_SOC_SOF
+	help
+	  This option can be used to enable or disable individual SOF firmware
+	  and driver debugging options.
+	  Say Y if you are debugging SOF FW or drivers.
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG_XRUN_STOP
+	bool "SOF stop on XRUN"
+	depends on SND_SOC_SOF_DEBUG
+	help
+	  This option forces PCMs to stop on any XRUN event. This is useful to
+	  preserve any trace data ond pipeline status prior to the XRUN.
+	  Say Y if you are debugging SOF FW pipeline XRUNs.
+          If unsure select "N".
+
diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
new file mode 100644
index 000000000000..aad44d2f6697
--- /dev/null
+++ b/sound/soc/sof/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+snd-sof-objs := core.o ops.o loader.o ipc.o pcm.o debug.o topology.o\
+		control.o trace.o
+
+obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
-- 
2.17.1
