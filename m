From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 18/19] ALSA: hda - remove PCI dependency in
	Kconfig
Date: Thu, 27 Feb 2014 22:36:01 -0800
Message-ID: <1393569362-27285-19-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f74.google.com (mail-oa0-f74.google.com
 [209.85.219.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 309C92650E1
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:14 +0100 (CET)
Received: by mail-oa0-f74.google.com with SMTP id i11so306152oag.5
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:13 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Remove the dependency on CONFIG_PCI for building hda codec drivers so
that platforms with HDA attach via means other than PCI can use them.
This was as suggested by tiwai.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/Kconfig      |  4 ++--
 sound/pci/hda/Kconfig  | 41 +++++++++++++++++++++++++----------------
 sound/pci/hda/Makefile |  6 ++++--
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 8756c8e..56d93bf 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -578,8 +578,6 @@ config SND_FM801_TEA575X_BOOL
 	  FM801 chip with a TEA5757 tuner (MediaForte SF256-PCS, SF256-PCP and
 	  SF64-PCR) into the snd-fm801 driver.
 
-source "sound/pci/hda/Kconfig"
-
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
 	select FW_LOADER
@@ -889,3 +887,5 @@ config SND_YMFPCI
 	  will be called snd-ymfpci.
 
 endif	# SND_PCI
+
+source "sound/pci/hda/Kconfig"
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index f2032dd..ac17c3f 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -1,8 +1,15 @@
-menuconfig SND_HDA_INTEL
-	tristate "Intel HD Audio"
+menu "HD-Audio"
+
+config SND_HDA
+	tristate
 	select SND_PCM
 	select SND_VMASTER
 	select SND_KCTL_JACK
+
+config SND_HDA_INTEL
+	tristate "HD Audio PCI"
+	depends on SND_PCI
+	select SND_HDA
 	help
 	  Say Y here to include support for Intel "High Definition
 	  Audio" (Azalia) and its compatible devices.
@@ -13,7 +20,7 @@ menuconfig SND_HDA_INTEL
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-hda-intel.
 
-if SND_HDA_INTEL
+if SND_HDA
 
 config SND_HDA_DSP_LOADER
 	bool
@@ -49,7 +56,7 @@ config SND_HDA_RECONFIG
 
 config SND_HDA_INPUT_BEEP
 	bool "Support digital beep via input layer"
-	depends on INPUT=y || INPUT=SND_HDA_INTEL
+	depends on INPUT=y || INPUT=SND_HDA
 	help
 	  Say Y here to build a digital beep interface for HD-audio
 	  driver. This interface is used to generate digital beeps.
@@ -90,7 +97,7 @@ config SND_HDA_CODEC_REALTEK
 	  snd-hda-intel driver, such as ALC880.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_REALTEK=m
+	depends on SND_HDA=y && SND_HDA_CODEC_REALTEK=m
 
 config SND_HDA_CODEC_ANALOG
 	tristate "Build Analog Device HD-audio codec support"
@@ -100,7 +107,7 @@ config SND_HDA_CODEC_ANALOG
 	  snd-hda-intel driver, such as AD1986A.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_ANALOG=m
+	depends on SND_HDA=y && SND_HDA_CODEC_ANALOG=m
 
 config SND_HDA_CODEC_SIGMATEL
 	tristate "Build IDT/Sigmatel HD-audio codec support"
@@ -110,7 +117,7 @@ config SND_HDA_CODEC_SIGMATEL
 	  snd-hda-intel driver, such as STAC9200.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_SIGMATEL=m
+	depends on SND_HDA=y && SND_HDA_CODEC_SIGMATEL=m
 
 config SND_HDA_CODEC_VIA
 	tristate "Build VIA HD-audio codec support"
@@ -120,7 +127,7 @@ config SND_HDA_CODEC_VIA
 	  snd-hda-intel driver, such as VT1708.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_VIA=m
+	depends on SND_HDA=y && SND_HDA_CODEC_VIA=m
 
 config SND_HDA_CODEC_HDMI
 	tristate "Build HDMI/DisplayPort HD-audio codec support"
@@ -130,7 +137,7 @@ config SND_HDA_CODEC_HDMI
 	  Intel and Nvidia HDMI/DisplayPort codecs.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_HDMI=m
+	depends on SND_HDA=y && SND_HDA_CODEC_HDMI=m
 
 config SND_HDA_I915
 	bool
@@ -145,7 +152,7 @@ config SND_HDA_CODEC_CIRRUS
 	  snd-hda-intel driver, such as CS4206.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CIRRUS=m
+	depends on SND_HDA=y && SND_HDA_CODEC_CIRRUS=m
 
 config SND_HDA_CODEC_CONEXANT
 	tristate "Build Conexant HD-audio codec support"
@@ -155,7 +162,7 @@ config SND_HDA_CODEC_CONEXANT
 	  snd-hda-intel driver, such as CX20549.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CONEXANT=m
+	depends on SND_HDA=y && SND_HDA_CODEC_CONEXANT=m
 
 config SND_HDA_CODEC_CA0110
 	tristate "Build Creative CA0110-IBG codec support"
@@ -165,7 +172,7 @@ config SND_HDA_CODEC_CA0110
 	  snd-hda-intel driver, found on some Creative X-Fi cards.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CA0110=m
+	depends on SND_HDA=y && SND_HDA_CODEC_CA0110=m
 
 config SND_HDA_CODEC_CA0132
 	tristate "Build Creative CA0132 codec support"
@@ -174,7 +181,7 @@ config SND_HDA_CODEC_CA0132
 	  snd-hda-intel driver.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CA0132=m
+	depends on SND_HDA=y && SND_HDA_CODEC_CA0132=m
 
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
@@ -196,7 +203,7 @@ config SND_HDA_CODEC_CMEDIA
 	  snd-hda-intel driver, such as CMI9880.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CMEDIA=m
+	depends on SND_HDA=y && SND_HDA_CODEC_CMEDIA=m
 
 config SND_HDA_CODEC_SI3054
 	tristate "Build Silicon Labs 3054 HD-modem codec support"
@@ -205,7 +212,7 @@ config SND_HDA_CODEC_SI3054
 	  (and compatibles) support in snd-hda-intel driver.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_SI3054=m
+	depends on SND_HDA=y && SND_HDA_CODEC_SI3054=m
 
 config SND_HDA_GENERIC
 	tristate "Enable generic HD-audio codec parser"
@@ -214,7 +221,7 @@ config SND_HDA_GENERIC
 	  in snd-hda-intel driver.
 
 comment "Set to Y if you want auto-loading the codec driver"
-	depends on SND_HDA_INTEL=y && SND_HDA_GENERIC=m
+	depends on SND_HDA=y && SND_HDA_GENERIC=m
 
 config SND_HDA_POWER_SAVE_DEFAULT
 	int "Default time-out for HD-audio power-save mode"
@@ -225,3 +232,5 @@ config SND_HDA_POWER_SAVE_DEFAULT
 	  power-save mode.  0 means to disable the power-save mode.
 
 endif
+
+endmenu
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 52d8ffe..582b21c 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,4 +1,5 @@
-snd-hda-intel-objs := hda_shared.o hda_intel.o
+snd-hda-intel-objs := hda_intel.o
+snd-hda-shared-objs := hda_shared.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
@@ -25,7 +26,8 @@ snd-hda-codec-via-objs :=	patch_via.o
 snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # common driver
-obj-$(CONFIG_SND_HDA_INTEL) := snd-hda-codec.o
+obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
+obj-$(CONFIG_SND_HDA) += snd-hda-shared.o
 
 # codec drivers
 obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
-- 
1.8.1.3.605.g02339dd
