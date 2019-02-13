From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 20/20] ASoC: SOF: Add Build support for SOF
	core and Intel drivers
Date: Wed, 13 Feb 2019 16:08:47 -0600
Message-ID: <20190213220847.10567-21-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Build SOF core and Intel-specific drivers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/Kconfig            |   1 +
 sound/soc/Makefile           |   1 +
 sound/soc/sof/Kconfig        | 141 +++++++++++++++++++
 sound/soc/sof/Makefile       |  18 +++
 sound/soc/sof/intel/Kconfig  | 253 +++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/Makefile |  17 +++
 6 files changed, 431 insertions(+)
 create mode 100644 sound/soc/sof/Kconfig
 create mode 100644 sound/soc/sof/Makefile
 create mode 100644 sound/soc/sof/intel/Kconfig
 create mode 100644 sound/soc/sof/intel/Makefile

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index aa35940f5c50..297be0ca3dbc 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -63,6 +63,7 @@ source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/sirf/Kconfig"
+source "sound/soc/sof/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sprd/Kconfig"
 source "sound/soc/sti/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 974fb9821e17..d90ce8a32887 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sirf/
+obj-$(CONFIG_SND_SOC)	+= sof/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sprd/
 obj-$(CONFIG_SND_SOC)	+= sti/
diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
new file mode 100644
index 000000000000..4cc9c626eddb
--- /dev/null
+++ b/sound/soc/sof/Kconfig
@@ -0,0 +1,141 @@
+config SND_SOC_SOF_TOPLEVEL
+	bool "Sound Open Firmware Support"
+	help
+          This adds support for Sound Open Firmware (SOF). SOF is a free and
+	  generic open source audio DSP firmware for multiple devices.
+          Say Y if you have such a device that is supported by SOF.
+          If unsure select "N".
+
+if SND_SOC_SOF_TOPLEVEL
+
+config SND_SOC_SOF_PCI
+	tristate "SOF PCI enumeration support"
+	depends on PCI
+	select SND_SOC_SOF
+	select SND_SOC_ACPI if ACPI
+	select SND_SOC_SOF_OPTIONS
+	select SND_SOC_SOF_INTEL_PCI if SND_SOC_SOF_INTEL_TOPLEVEL
+	help
+          This adds support for PCI enumeration. This option is
+	  required to enable Intel Skylake+ devices
+	  Say Y if you need this option
+          If unsure select "N".
+
+config SND_SOC_SOF_ACPI
+	tristate "SOF ACPI enumeration support"
+	depends on ACPI || COMPILE_TEST
+	select SND_SOC_SOF
+	select SND_SOC_ACPI if ACPI
+	select SND_SOC_SOF_OPTIONS
+	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
+	select IOSF_MBI if X86
+	help
+          This adds support for ACPI enumeration. This option is required
+	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices
+	  Say Y if you need this option
+          If unsure select "N".
+
+config SND_SOC_SOF_OPTIONS
+	tristate
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+if SND_SOC_SOF_OPTIONS
+
+config SND_SOC_SOF_NOCODEC
+	tristate "SOF nocodec mode Support"
+	help
+          This adds support for a dummy/nocodec machine driver fallback
+	  option if no known codec is detected. This is typically only
+	  enabled for developers or devices where the sound card is
+	  controlled externally
+          Say Y if you need this nocodec fallback option
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG
+	bool "SOF debugging features"
+	help
+	  This option can be used to enable or disable individual SOF firmware
+	  and driver debugging options.
+	  Say Y if you are debugging SOF FW or drivers.
+          If unsure select "N".
+
+if SND_SOC_SOF_DEBUG
+
+config SND_SOC_SOF_FORCE_NOCODEC_MODE
+	bool "SOF force nocodec Mode"
+	depends on SND_SOC_SOF_NOCODEC
+	help
+          This forces SOF to use dummy/nocodec as machine driver, even
+	  though there is a codec detected on the real platform. This is
+	  typically only enabled for developers for debug purposes, before
+	  codec/machine driver is ready, or to exclude the impact of those
+	  drivers
+          Say Y if you need this force nocodec mode option
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG_XRUN_STOP
+	bool "SOF stop on XRUN"
+	help
+	  This option forces PCMs to stop on any XRUN event. This is useful to
+	  preserve any trace data ond pipeline status prior to the XRUN.
+	  Say Y if you are debugging SOF FW pipeline XRUNs.
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG_VERBOSE_IPC
+	bool "SOF verbose IPC logs"
+	help
+	  This option enables more verbose IPC logs, with command types in
+	  human-readable form instead of just 32-bit hex dumps. This is useful
+	  if you are trying to debug IPC with the DSP firmware.
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG_FORCE_IPC_POSITION
+	bool "SOF force to use IPC for position update on SKL+"
+	help
+	  This option force to handle stream position update IPCs and run pcm
+	  elapse to inform ALSA about that, on platforms (e.g. Intel SKL+) that
+	  with other approach (e.g. HDAC DPIB/posbuf) to elapse PCM.
+	  On platforms (e.g. Intel SKL-) where position update IPC is the only
+	  one choice, this setting won't impact anything.
+	  if you are trying to debug pointer update with position IPCs or where
+	  DPIB/posbuf is not ready, select "Y".
+          If unsure select "N".
+
+config SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE
+	bool "SOF enable debugfs caching"
+	help
+	  This option enables caching of debugfs
+	  memory -> DSP resource (memory, register, etc)
+	  before the audio DSP is suspended. This will increase the suspend
+	  latency and therefore should be used for debug purposes only.
+	  Say Y if you want to enable caching the memory windows.
+	  If unsure, select "N".
+
+endif ## SND_SOC_SOF_DEBUG
+
+endif ## SND_SOC_SOF_OPTIONS
+
+config SND_SOC_SOF
+	tristate
+	select SND_SOC_TOPOLOGY
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+	  The selection is made at the top level and does not exactly follow
+	  module dependencies but since the module or built-in type is decided
+	  at the top level it doesn't matter.
+
+config SND_SOC_SOF_PROBE_WORK_QUEUE
+	bool
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+	  When selected, the probe is handled in two steps, for example to
+	  avoid lockdeps if request_module is used in the probe.
+
+source "sound/soc/sof/intel/Kconfig"
+source "sound/soc/sof/xtensa/Kconfig"
+
+endif
diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
new file mode 100644
index 000000000000..8f14c9d2950b
--- /dev/null
+++ b/sound/soc/sof/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+snd-sof-objs := core.o ops.o loader.o ipc.o pcm.o pm.o debug.o topology.o\
+		control.o trace.o utils.o
+
+snd-sof-pci-objs := sof-pci-dev.o
+snd-sof-acpi-objs := sof-acpi-dev.o
+snd-sof-nocodec-objs := nocodec.o
+
+obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
+obj-$(CONFIG_SND_SOC_SOF_NOCODEC) += snd-sof-nocodec.o
+
+
+obj-$(CONFIG_SND_SOC_SOF_ACPI) += sof-acpi-dev.o
+obj-$(CONFIG_SND_SOC_SOF_PCI) += sof-pci-dev.o
+
+obj-$(CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL) += intel/
+obj-$(CONFIG_SND_SOC_SOF_XTENSA) += xtensa/
diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
new file mode 100644
index 000000000000..50cb06b160a8
--- /dev/null
+++ b/sound/soc/sof/intel/Kconfig
@@ -0,0 +1,253 @@
+config SND_SOC_SOF_INTEL_TOPLEVEL
+	bool "SOF support for Intel audio DSPs"
+	depends on SND_DMA_SGBUF || COMPILE_TEST
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+if SND_SOC_SOF_INTEL_TOPLEVEL
+
+config SND_SOC_SOF_INTEL_ACPI
+	tristate
+	select SND_SOC_SOF_BAYTRAIL  if SND_SOC_SOF_BAYTRAIL_SUPPORT
+	select SND_SOC_SOF_HASWELL   if SND_SOC_SOF_HASWELL_SUPPORT
+	select SND_SOC_SOF_BROADWELL if SND_SOC_SOF_BROADWELL_SUPPORT
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_INTEL_PCI
+	tristate
+	select SND_SOC_SOF_EDISON      if SND_SOC_SOF_EDISON_SUPPORT
+	select SND_SOC_SOF_APOLLOLAKE  if SND_SOC_SOF_APOLLOLAKE_SUPPORT
+	select SND_SOC_SOF_GEMINILAKE  if SND_SOC_SOF_GEMINILAKE_SUPPORT
+	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
+	select SND_SOC_SOF_KABYLAKE    if SND_SOC_SOF_KABYLAKE_SUPPORT
+	select SND_SOC_SOF_SKYLAKE     if SND_SOC_SOF_SKYLAKE_SUPPORT
+	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
+	tristate
+	select SND_SOC_INTEL_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_INTEL_COMMON
+	tristate
+	select SND_SOC_ACPI_INTEL_MATCH
+	select SND_SOC_SOF_XTENSA
+	select SND_SOC_INTEL_MACH
+	select SND_SOC_ACPI if ACPI
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+if SND_SOC_SOF_INTEL_ACPI
+
+config SND_SOC_SOF_BAYTRAIL_SUPPORT
+	bool "SOF support for Baytrail, Braswell and Cherrytrail"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Baytrail, Braswell or Cherrytrail processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_BAYTRAIL
+	tristate
+	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_HASWELL_SUPPORT
+	bool "SOF support for Haswell"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Haswell processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_HASWELL
+	tristate
+	select SND_SOC_SOF_INTEL_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_BROADWELL_SUPPORT
+	bool "SOF support for Broadwell"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Broadwell processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_BROADWELL
+	tristate
+	select SND_SOC_SOF_INTEL_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+endif ## SND_SOC_SOF_INTEL_ACPI
+
+if SND_SOC_SOF_INTEL_PCI
+
+config SND_SOC_SOF_EDISON_SUPPORT
+	bool "SOF support for Tangier/Edison"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Baytrail, Braswell or Cherrytrail processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_EDISON
+	tristate
+	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_APOLLOLAKE_SUPPORT
+	bool "SOF support for Apollolake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Apollolake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_APOLLOLAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_GEMINILAKE_SUPPORT
+	bool "SOF support for GeminiLake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Geminilake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_GEMINILAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_CANNONLAKE_SUPPORT
+	bool "SOF support for Cannonlake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Cannonlake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_CANNONLAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_KABYLAKE_SUPPORT
+	bool "SOF support for Kabylake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Kabylake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_KABYLAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_SKYLAKE_SUPPORT
+	bool "SOF support for Skylake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Skylake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_SKYLAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_ICELAKE_SUPPORT
+	bool "SOF support for Icelake"
+	help
+          This adds support for Sound Open Firmware for Intel(R) platforms
+          using the Icelake processors.
+          Say Y if you have such a device.
+          If unsure select "N".
+
+config SND_SOC_SOF_ICELAKE
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_HDA_COMMON
+	tristate
+	select SND_SOC_SOF_INTEL_COMMON
+	select SND_SOC_SOF_HDA_LINK_BASELINE
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+if SND_SOC_SOF_HDA_COMMON
+
+config SND_SOC_SOF_HDA_LINK
+	bool "SOF support for HDA Links(HDA/HDMI)"
+	select SND_SOC_SOF_PROBE_WORK_QUEUE
+	help
+          This adds support for HDA links(HDA/HDMI) with Sound Open Firmware
+		  for Intel(R) platforms.
+          Say Y if you want to enble HDA links with SOF.
+          If unsure select "N".
+
+config SND_SOC_SOF_HDA_AUDIO_CODEC
+	bool "SOF support for HDAudio codecs"
+	depends on SND_SOC_SOF_HDA_LINK
+	help
+          This adds support for HDAudio codecs with Sound Open Firmware
+		  for Intel(R) platforms.
+          Say Y if you want to enble HDAudio codecs with SOF.
+          If unsure select "N".
+
+endif ## SND_SOC_SOF_HDA_COMMON
+
+config SND_SOC_SOF_HDA_LINK_BASELINE
+	tristate
+	select SND_SOC_SOF_HDA if SND_SOC_SOF_HDA_LINK
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+config SND_SOC_SOF_HDA
+	tristate
+	select SND_HDA_EXT_CORE if SND_SOC_SOF_HDA_LINK
+	select SND_SOC_HDAC_HDA if SND_SOC_SOF_HDA_AUDIO_CODEC
+	help
+          This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level
+
+endif ## SND_SOC_SOF_INTEL_PCI
+
+endif ## SND_SOC_SOF_INTEL_TOPLEVEL
diff --git a/sound/soc/sof/intel/Makefile b/sound/soc/sof/intel/Makefile
new file mode 100644
index 000000000000..c0b63f87ada7
--- /dev/null
+++ b/sound/soc/sof/intel/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+snd-sof-intel-byt-objs := byt.o
+snd-sof-intel-hsw-objs := hsw.o
+snd-sof-intel-bdw-objs := bdw.o
+snd-sof-intel-hda-common-objs := hda.o hda-loader.o hda-stream.o hda-trace.o \
+				 hda-dsp.o hda-ipc.o hda-ctrl.o hda-pcm.o \
+				 hda-dai.o hda-bus.o hda-loader-skl.o \
+				 skl.o apl.o cnl.o
+
+snd-sof-intel-hda-objs := hda-codec.o
+
+obj-$(CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP) += snd-sof-intel-byt.o
+obj-$(CONFIG_SND_SOC_SOF_HASWELL) += snd-sof-intel-hsw.o
+obj-$(CONFIG_SND_SOC_SOF_BROADWELL) += snd-sof-intel-bdw.o
+obj-$(CONFIG_SND_SOC_SOF_HDA_COMMON) += snd-sof-intel-hda-common.o
+obj-$(CONFIG_SND_SOC_SOF_HDA) += snd-sof-intel-hda.o
-- 
2.17.1
