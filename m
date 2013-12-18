From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Make CONFIG_SND_HDA_CODEC_*
	tristate
Date: Wed, 18 Dec 2013 18:41:17 +0100
Message-ID: <1387388478-1130-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EFC5E2616FB
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 18:41:18 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C80FDABCA
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 17:41:18 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

So far, CONFIG_SND_HDA_CODEC_* kconfigs have been booleans due to
historical reasons.  The major reason was that the automatic codec
driver probing wouldn't work if user sets a codec driver as a module
while the controller driver as a built-in.  And, another reason was to
avoid exporting symbols of the helper codes when all drivers are built
in.

But, this sort of "kindness" rather confuses people in the end,
especially makes the config refinement via localmodconfig unhappy.
Also, a codec module would still work if you re-bind the controller
driver via sysfs (although it's no automatic loading), so there might
be a slight use case.

That said, better to let people fallen into a pitfall than being too
smart and restrict something.  Let's make things straightforward: now
all CONFIG_SND_HDA_CODEC_* become tristate, and all symbols exported
unconditionally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Kconfig     | 115 ++++++++++------------------------------------
 sound/pci/hda/Makefile    |  50 ++++++--------------
 sound/pci/hda/hda_codec.h |  13 ------
 3 files changed, 37 insertions(+), 141 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 4cdd9ded4563..b0c0481c3339 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -87,126 +87,72 @@ config SND_HDA_PATCH_LOADER
 	  This option turns on hwdep and reconfig features automatically.
 
 config SND_HDA_CODEC_REALTEK
-	bool "Build Realtek HD-audio codec support"
-	default y
+	tristate "Build Realtek HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include Realtek HD-audio codec support in
+	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-realtek.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_ANALOG
-	bool "Build Analog Device HD-audio codec support"
-	default y
+	tristate "Build Analog Device HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include Analog Device HD-audio codec support in
+	  Say Y or M here to include Analog Device HD-audio codec support in
 	  snd-hda-intel driver, such as AD1986A.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-analog.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_SIGMATEL
-	bool "Build IDT/Sigmatel HD-audio codec support"
-	default y
+	tristate "Build IDT/Sigmatel HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include IDT (Sigmatel) HD-audio codec support in
+	  Say Y or M here to include IDT (Sigmatel) HD-audio codec support in
 	  snd-hda-intel driver, such as STAC9200.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-idt.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_VIA
-	bool "Build VIA HD-audio codec support"
-	default y
+	tristate "Build VIA HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include VIA HD-audio codec support in
+	  Say Y or M here to include VIA HD-audio codec support in
 	  snd-hda-intel driver, such as VT1708.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-via.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_HDMI
-	bool "Build HDMI/DisplayPort HD-audio codec support"
-	default y
+	tristate "Build HDMI/DisplayPort HD-audio codec support"
 	help
-	  Say Y here to include HDMI and DisplayPort HD-audio codec
+	  Say Y or M here to include HDMI and DisplayPort HD-audio codec
 	  support in snd-hda-intel driver.  This includes all AMD/ATI,
 	  Intel and Nvidia HDMI/DisplayPort codecs.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-hdmi.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_I915
 	bool
 	default y
 	depends on DRM_I915
 
 config SND_HDA_CODEC_CIRRUS
-	bool "Build Cirrus Logic codec support"
-	default y
+	tristate "Build Cirrus Logic codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include Cirrus Logic codec support in
+	  Say Y or M here to include Cirrus Logic codec support in
 	  snd-hda-intel driver, such as CS4206.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-cirrus.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_CONEXANT
-	bool "Build Conexant HD-audio codec support"
-	default y
+	tristate "Build Conexant HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include Conexant HD-audio codec support in
+	  Say Y or M here to include Conexant HD-audio codec support in
 	  snd-hda-intel driver, such as CX20549.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-conexant.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_CA0110
-	bool "Build Creative CA0110-IBG codec support"
-	default y
+	tristate "Build Creative CA0110-IBG codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include Creative CA0110-IBG codec support in
+	  Say Y or M here to include Creative CA0110-IBG codec support in
 	  snd-hda-intel driver, found on some Creative X-Fi cards.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-ca0110.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_CA0132
-	bool "Build Creative CA0132 codec support"
-	default y
+	tristate "Build Creative CA0132 codec support"
 	help
-	  Say Y here to include Creative CA0132 codec support in
+	  Say Y or M here to include Creative CA0132 codec support in
 	  snd-hda-intel driver.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-ca0132.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
 	depends on SND_HDA_CODEC_CA0132
@@ -220,35 +166,22 @@ config SND_HDA_CODEC_CA0132_DSP
 	  (ctefx.bin).
 
 config SND_HDA_CODEC_CMEDIA
-	bool "Build C-Media HD-audio codec support"
-	default y
+	tristate "Build C-Media HD-audio codec support"
 	select SND_HDA_GENERIC
 	help
-	  Say Y here to include C-Media HD-audio codec support in
+	  Say Y or M here to include C-Media HD-audio codec support in
 	  snd-hda-intel driver, such as CMI9880.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-cmedia.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_CODEC_SI3054
-	bool "Build Silicon Labs 3054 HD-modem codec support"
-	default y
+	tristate "Build Silicon Labs 3054 HD-modem codec support"
 	help
-	  Say Y here to include Silicon Labs 3054 HD-modem codec
+	  Say Y or M here to include Silicon Labs 3054 HD-modem codec
 	  (and compatibles) support in snd-hda-intel driver.
 
-	  When the HD-audio driver is built as a module, the codec
-	  support code is also built as another module,
-	  snd-hda-codec-si3054.
-	  This module is automatically loaded at probing.
-
 config SND_HDA_GENERIC
-	bool "Enable generic HD-audio codec parser"
-	default y
+	tristate "Enable generic HD-audio codec parser"
 	help
-	  Say Y here to enable the generic HD-audio codec parser
+	  Say Y or M here to enable the generic HD-audio codec parser
 	  in snd-hda-intel driver.
 
 config SND_HDA_POWER_SAVE_DEFAULT
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 5a40c652df41..1fcb118e480a 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -27,43 +27,19 @@ snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 # common driver
 obj-$(CONFIG_SND_HDA_INTEL) := snd-hda-codec.o
 
-# codec drivers (note: CONFIG_SND_HDA_CODEC_XXX are booleans)
-ifdef CONFIG_SND_HDA_GENERIC
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-generic.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_REALTEK
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-realtek.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_CMEDIA
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-cmedia.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_ANALOG
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-analog.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_SIGMATEL
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-idt.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_SI3054
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-si3054.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_CIRRUS
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-cirrus.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_CA0110
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-ca0110.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_CA0132
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-ca0132.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_CONEXANT
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-conexant.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_VIA
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-via.o
-endif
-ifdef CONFIG_SND_HDA_CODEC_HDMI
-obj-$(CONFIG_SND_HDA_INTEL) += snd-hda-codec-hdmi.o
-endif
+# codec drivers
+obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
+obj-$(CONFIG_SND_HDA_CODEC_REALTEK) += snd-hda-codec-realtek.o
+obj-$(CONFIG_SND_HDA_CODEC_CMEDIA) += snd-hda-codec-cmedia.o
+obj-$(CONFIG_SND_HDA_CODEC_ANALOG) += snd-hda-codec-analog.o
+obj-$(CONFIG_SND_HDA_CODEC_SIGMATEL) += snd-hda-codec-idt.o
+obj-$(CONFIG_SND_HDA_CODEC_SI3054) += snd-hda-codec-si3054.o
+obj-$(CONFIG_SND_HDA_CODEC_CIRRUS) += snd-hda-codec-cirrus.o
+obj-$(CONFIG_SND_HDA_CODEC_CA0110) += snd-hda-codec-ca0110.o
+obj-$(CONFIG_SND_HDA_CODEC_CA0132) += snd-hda-codec-ca0132.o
+obj-$(CONFIG_SND_HDA_CODEC_CONEXANT) += snd-hda-codec-conexant.o
+obj-$(CONFIG_SND_HDA_CODEC_VIA) += snd-hda-codec-via.o
+obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 3c484c27048b..2b5d19e48a27 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -681,19 +681,6 @@ snd_hda_codec_load_dsp_cleanup(struct hda_codec *codec,
 				struct snd_dma_buffer *dmab) {}
 #endif
 
-/*
- * Codec modularization
- */
-
-/* Export symbols only for communication with codec drivers;
- * When built in kernel, all HD-audio drivers are supposed to be statically
- * linked to the kernel.  Thus, the symbols don't have to (or shouldn't) be
- * exported unless it's built as a module.
- */
-#ifdef MODULE
 #define EXPORT_SYMBOL_HDA(sym) EXPORT_SYMBOL_GPL(sym)
-#else
-#define EXPORT_SYMBOL_HDA(sym)
-#endif
 
 #endif /* __SOUND_HDA_CODEC_H */
-- 
1.8.5
