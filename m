From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 12/12] ASoC: SOF: Add Build support for SOF
	core
Date: Fri, 31 Aug 2018 16:19:10 +0100
Message-ID: <20180831151910.16122-13-liam.r.girdwood@linux.intel.com>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id C7F3526798F
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:20:03 +0200 (CEST)
In-Reply-To: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
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

Build SOF core and Intel-specific drivers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/Kconfig      |  1 +
 sound/soc/Makefile     |  1 +
 sound/soc/sof/Kconfig  | 36 ++++++++++++++++++++++++++++++++++++
 sound/soc/sof/Makefile |  6 ++++++
 4 files changed, 44 insertions(+)
 create mode 100644 sound/soc/sof/Kconfig
 create mode 100644 sound/soc/sof/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 1cf11cf51e1d..32eab7d21aaa 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -65,6 +65,7 @@ source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
+source "sound/soc/sof/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sti/Kconfig"
 source "sound/soc/stm/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 62a5f87c3cfc..cb336e803d5a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
+obj-$(CONFIG_SND_SOC)	+= sof/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= stm/
diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
new file mode 100644
index 000000000000..f6ca89321a5f
--- /dev/null
+++ b/sound/soc/sof/Kconfig
@@ -0,0 +1,36 @@
+config SND_SOC_SOF
+	tristate "Sound Open Firmware Support"
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
+config SND_SOC_SOF_DEBUG_VERBOSE_IPC
+	bool "SOF verbose IPC logs"
+	depends on SND_SOC_SOF_DEBUG
+	help
+	  This option enables more verbose IPC logs, with command types in
+	  human-readable form instead of just 32-bit hex dumps. This is useful
+	  if you are trying to debug IPC with the DSP firmware.
+          If unsure select "N".
diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
new file mode 100644
index 000000000000..366c613a0cee
--- /dev/null
+++ b/sound/soc/sof/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+snd-sof-objs := core.o ops.o loader.o ipc.o pcm.o pm.o debug.o topology.o\
+		control.o trace.o
+
+obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
-- 
2.17.1
