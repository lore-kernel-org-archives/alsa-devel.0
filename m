From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 2/5] ALSA: HDA: create HDA common lib
Date: Sun,  8 Mar 2015 20:07:56 +0530
Message-ID: <1425825479-28780-3-git-send-email-vinod.koul@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B106260481
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:28 +0100 (CET)
In-Reply-To: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Move the common hda controller and hda codec code from sound/pci/hda/ to
sound/hda. This new location will serve as common HDA lib uses by current
code as well as upcoming ASoC HDA implementations

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/Kconfig                         |    2 +
 sound/Makefile                        |    2 +-
 sound/hda/Kconfig                     |   85 +++++++++++++++++++++++++++++++++
 sound/hda/Makefile                    |   20 ++++++++
 sound/{pci => }/hda/hda_auto_parser.c |    0
 sound/{pci => }/hda/hda_beep.c        |    0
 sound/{pci => }/hda/hda_codec.c       |    0
 sound/{pci => }/hda/hda_controller.c  |    0
 sound/{pci => }/hda/hda_eld.c         |    0
 sound/{pci => }/hda/hda_generic.c     |    0
 sound/{pci => }/hda/hda_hwdep.c       |    0
 sound/{pci => }/hda/hda_intel_trace.h |    0
 sound/{pci => }/hda/hda_jack.c        |    0
 sound/{pci => }/hda/hda_proc.c        |    0
 sound/{pci => }/hda/hda_sysfs.c       |    0
 sound/{pci => }/hda/hda_trace.h       |    0
 sound/pci/hda/Kconfig                 |   44 -----------------
 sound/pci/hda/Makefile                |   14 +-----
 18 files changed, 110 insertions(+), 57 deletions(-)
 create mode 100644 sound/hda/Kconfig
 create mode 100644 sound/hda/Makefile
 rename sound/{pci => }/hda/hda_auto_parser.c (100%)
 rename sound/{pci => }/hda/hda_beep.c (100%)
 rename sound/{pci => }/hda/hda_codec.c (100%)
 rename sound/{pci => }/hda/hda_controller.c (100%)
 rename sound/{pci => }/hda/hda_eld.c (100%)
 rename sound/{pci => }/hda/hda_generic.c (100%)
 rename sound/{pci => }/hda/hda_hwdep.c (100%)
 rename sound/{pci => }/hda/hda_intel_trace.h (100%)
 rename sound/{pci => }/hda/hda_jack.c (100%)
 rename sound/{pci => }/hda/hda_proc.c (100%)
 rename sound/{pci => }/hda/hda_sysfs.c (100%)
 rename sound/{pci => }/hda/hda_trace.h (100%)

diff --git a/sound/Kconfig b/sound/Kconfig
index c710ce2c5c37..63233752ee01 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -90,6 +90,8 @@ source "sound/mips/Kconfig"
 
 source "sound/sh/Kconfig"
 
+source "sound/hda/Kconfig"
+
 # the following will depend on the order of config.
 # here assuming USB is defined before ALSA
 source "sound/usb/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index ce9132b1c395..0e5c4283f4a4 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ hda/ synth/ usb/ \
 	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/
 obj-$(CONFIG_SND_AOA) += aoa/
 
diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
new file mode 100644
index 000000000000..7e1f1a07cb6e
--- /dev/null
+++ b/sound/hda/Kconfig
@@ -0,0 +1,85 @@
+menu "HD-Audio Common Library"
+
+config SND_CORE_HDA
+	tristate "Enable HD Audio Common Library"
+	default n
+	select SND_VMASTER
+	select SND_KCTL_JACK
+	help
+	  Say Y here to enable the HD-audio codec common library.
+
+if SND_CORE_HDA
+
+config SND_HDA_PREALLOC_SIZE
+	int "Pre-allocated buffer size for HD-audio driver"
+	range 0 32768
+        default 64
+	help
+	Specifies the default pre-allocated buffer-size in kB for the
+	HD-audio driver.  A larger buffer (e.g. 2048) is preferred for systems
+	using PulseAudio.  The default 64 is chosen just
+	for compatibility reasons.
+
+	Note that the pre-allocation size can be changed dynamically
+	via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
+
+config SND_HDA_HWDEP
+        bool "Build hwdep interface for HD-audio driver"
+        select SND_HWDEP
+        help
+          Say Y here to build a hwdep interface for HD-audio driver.
+          This interface can be used for out-of-band communication
+          with codecs for debugging purposes.
+
+config SND_HDA_PATCH_LOADER
+	bool "Support initialization patch loading for HD-audio"
+	select FW_LOADER
+	select SND_HDA_RECONFIG
+	help
+	  Say Y here to allow the HD-audio driver to load a pseudo
+	  firmware file ("patch") for overriding the BIOS setup at
+	  start up.  The "patch" file can be specified via patch module
+	  option, such as patch=hda-init.
+
+config SND_HDA_RECONFIG
+	bool "Allow dynamic codec reconfiguration"
+	help
+	  Say Y here to enable the HD-audio codec re-configuration feature.
+	  This adds the sysfs interfaces to allow user to clear the whole
+	  codec configuration, change the codec setup, add extra verbs,
+	  and re-configure the codec dynamically.
+
+config SND_HDA_INPUT_BEEP
+	bool "Support digital beep via input layer"
+	depends on INPUT=y || INPUT=SND_HDA
+	help
+	  Say Y here to build a digital beep interface for HD-audio
+	  driver. This interface is used to generate digital beeps.
+
+config SND_HDA_INPUT_BEEP_MODE
+	int "Digital beep registration mode (0=off, 1=on)"
+	depends on SND_HDA_INPUT_BEEP=y
+	default "1"
+	range 0 1
+	help
+	  Set 0 to disable the digital beep interface for HD-audio by default.
+	  Set 1 to always enable the digital beep interface for HD-audio by
+	  default.
+
+config SND_HDA_INPUT_JACK
+	bool "Support jack plugging notification via input layer"
+	depends on INPUT=y || INPUT=SND
+	select SND_JACK
+	help
+	  Say Y here to enable the jack plugging notification via
+	  input layer.
+
+config SND_CORE_HDA_GENERIC
+	tristate "Enable generic HD-audio codec parser"
+	help
+	  Say Y or M here to enable the generic HD-audio codec parser
+	  in HDA library.
+
+endif
+
+endmenu
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
new file mode 100644
index 000000000000..6862de9bcbb6
--- /dev/null
+++ b/sound/hda/Makefile
@@ -0,0 +1,20 @@
+snd-hda-controller-objs := hda_controller.o
+snd-hda-codec-y := hda_codec.o hda_jack.o hda_auto_parser.o \
+	hda_eld.o hda_sysfs.o
+
+snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
+snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
+snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
+
+# for trace-points
+CFLAGS_hda_controller.o := -I$(src)
+CFLAGS_hda_codec.o := -I$(src)
+
+snd-hda-codec-generic-objs := hda_generic.o
+
+# common driver
+obj-$(CONFIG_SND_CORE_HDA) += snd-hda-codec.o
+obj-$(CONFIG_SND_CORE_HDA) += snd-hda-controller.o
+
+# codec drivers
+obj-$(CONFIG_SND_CORE_HDA_GENERIC) += snd-hda-codec-generic.o
diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/hda/hda_auto_parser.c
similarity index 100%
rename from sound/pci/hda/hda_auto_parser.c
rename to sound/hda/hda_auto_parser.c
diff --git a/sound/pci/hda/hda_beep.c b/sound/hda/hda_beep.c
similarity index 100%
rename from sound/pci/hda/hda_beep.c
rename to sound/hda/hda_beep.c
diff --git a/sound/pci/hda/hda_codec.c b/sound/hda/hda_codec.c
similarity index 100%
rename from sound/pci/hda/hda_codec.c
rename to sound/hda/hda_codec.c
diff --git a/sound/pci/hda/hda_controller.c b/sound/hda/hda_controller.c
similarity index 100%
rename from sound/pci/hda/hda_controller.c
rename to sound/hda/hda_controller.c
diff --git a/sound/pci/hda/hda_eld.c b/sound/hda/hda_eld.c
similarity index 100%
rename from sound/pci/hda/hda_eld.c
rename to sound/hda/hda_eld.c
diff --git a/sound/pci/hda/hda_generic.c b/sound/hda/hda_generic.c
similarity index 100%
rename from sound/pci/hda/hda_generic.c
rename to sound/hda/hda_generic.c
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/hda/hda_hwdep.c
similarity index 100%
rename from sound/pci/hda/hda_hwdep.c
rename to sound/hda/hda_hwdep.c
diff --git a/sound/pci/hda/hda_intel_trace.h b/sound/hda/hda_intel_trace.h
similarity index 100%
rename from sound/pci/hda/hda_intel_trace.h
rename to sound/hda/hda_intel_trace.h
diff --git a/sound/pci/hda/hda_jack.c b/sound/hda/hda_jack.c
similarity index 100%
rename from sound/pci/hda/hda_jack.c
rename to sound/hda/hda_jack.c
diff --git a/sound/pci/hda/hda_proc.c b/sound/hda/hda_proc.c
similarity index 100%
rename from sound/pci/hda/hda_proc.c
rename to sound/hda/hda_proc.c
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/hda/hda_sysfs.c
similarity index 100%
rename from sound/pci/hda/hda_sysfs.c
rename to sound/hda/hda_sysfs.c
diff --git a/sound/pci/hda/hda_trace.h b/sound/hda/hda_trace.h
similarity index 100%
rename from sound/pci/hda/hda_trace.h
rename to sound/hda/hda_trace.h
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index ebf4c2fb99df..7a821ebb3bc2 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -3,8 +3,6 @@ menu "HD-Audio"
 config SND_HDA
 	tristate
 	select SND_PCM
-	select SND_VMASTER
-	select SND_KCTL_JACK
 
 config SND_HDA_INTEL
 	tristate "HD Audio PCI"
@@ -61,39 +59,6 @@ config SND_HDA_HWDEP
 	  This interface can be used for out-of-band communication
 	  with codecs for debugging purposes.
 
-config SND_HDA_RECONFIG
-	bool "Allow dynamic codec reconfiguration"
-	help
-	  Say Y here to enable the HD-audio codec re-configuration feature.
-	  This adds the sysfs interfaces to allow user to clear the whole
-	  codec configuration, change the codec setup, add extra verbs,
-	  and re-configure the codec dynamically.
-
-config SND_HDA_INPUT_BEEP
-	bool "Support digital beep via input layer"
-	depends on INPUT=y || INPUT=SND_HDA
-	help
-	  Say Y here to build a digital beep interface for HD-audio
-	  driver. This interface is used to generate digital beeps.
-
-config SND_HDA_INPUT_BEEP_MODE
-	int "Digital beep registration mode (0=off, 1=on)"
-	depends on SND_HDA_INPUT_BEEP=y
-	default "1"
-	range 0 1
-	help
-	  Set 0 to disable the digital beep interface for HD-audio by default.
-	  Set 1 to always enable the digital beep interface for HD-audio by
-	  default.
-
-config SND_HDA_INPUT_JACK
-	bool "Support jack plugging notification via input layer"
-	depends on INPUT=y || INPUT=SND
-	select SND_JACK
-	help
-	  Say Y here to enable the jack plugging notification via
-	  input layer.
-
 config SND_HDA_PATCH_LOADER
 	bool "Support initialization patch loading for HD-audio"
 	select FW_LOADER
@@ -229,15 +194,6 @@ config SND_HDA_CODEC_SI3054
 comment "Set to Y if you want auto-loading the codec driver"
 	depends on SND_HDA=y && SND_HDA_CODEC_SI3054=m
 
-config SND_HDA_GENERIC
-	tristate "Enable generic HD-audio codec parser"
-	help
-	  Say Y or M here to enable the generic HD-audio codec parser
-	  in snd-hda-intel driver.
-
-comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA=y && SND_HDA_GENERIC=m
-
 config SND_HDA_POWER_SAVE_DEFAULT
 	int "Default time-out for HD-audio power-save mode"
 	depends on PM
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 194f30935e77..62c0f3f3424f 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,19 +1,11 @@
 snd-hda-intel-objs := hda_intel.o
-snd-hda-controller-objs := hda_controller.o
 snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
-snd-hda-codec-y := hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
-snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
-snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
-snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
-
 # for trace-points
-CFLAGS_hda_codec.o := -I$(src)
-CFLAGS_hda_controller.o := -I$(src)
+#CFLAGS_hda_controller.o := -I$(src)
 
-snd-hda-codec-generic-objs :=	hda_generic.o
 snd-hda-codec-realtek-objs :=	patch_realtek.o
 snd-hda-codec-cmedia-objs :=	patch_cmedia.o
 snd-hda-codec-analog-objs :=	patch_analog.o
@@ -27,11 +19,9 @@ snd-hda-codec-via-objs :=	patch_via.o
 snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # common driver
-obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
-obj-$(CONFIG_SND_HDA) += snd-hda-controller.o
+#obj-$(CONFIG_SND_HDA) += snd-hda-controller.o
 
 # codec drivers
-obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
 obj-$(CONFIG_SND_HDA_CODEC_REALTEK) += snd-hda-codec-realtek.o
 obj-$(CONFIG_SND_HDA_CODEC_CMEDIA) += snd-hda-codec-cmedia.o
 obj-$(CONFIG_SND_HDA_CODEC_ANALOG) += snd-hda-codec-analog.o
-- 
1.7.9.5
