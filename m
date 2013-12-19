From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add warning texts when codec
	driver Kconfig doesn't match
Date: Thu, 19 Dec 2013 15:15:00 +0100
Message-ID: <1387462500-28217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A7B32265470
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 15:15:00 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 405E6AC10
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 14:15:00 +0000 (UTC)
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

When a Kconfig of a codec driver doesn't match with the controller
(CONFIG_SND_HDA_INTEL), it'll result in the non-working automatic
probing.  Unfortunately kbuild can't give such a restriction, but at
least, it's possible to show a warning if such a condition is found.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is a patch on top of the previous two patches for making HD-audio
codec kconfigs to tristate.


 sound/pci/hda/Kconfig | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index b0c0481c3339..0e53634dbbd8 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -93,6 +93,9 @@ config SND_HDA_CODEC_REALTEK
 	  Say Y or M here to include Realtek HD-audio codec support in
 	  snd-hda-intel driver, such as ALC880.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_REALTEK=m
+
 config SND_HDA_CODEC_ANALOG
 	tristate "Build Analog Device HD-audio codec support"
 	select SND_HDA_GENERIC
@@ -100,6 +103,9 @@ config SND_HDA_CODEC_ANALOG
 	  Say Y or M here to include Analog Device HD-audio codec support in
 	  snd-hda-intel driver, such as AD1986A.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_ANALOG=m
+
 config SND_HDA_CODEC_SIGMATEL
 	tristate "Build IDT/Sigmatel HD-audio codec support"
 	select SND_HDA_GENERIC
@@ -107,6 +113,9 @@ config SND_HDA_CODEC_SIGMATEL
 	  Say Y or M here to include IDT (Sigmatel) HD-audio codec support in
 	  snd-hda-intel driver, such as STAC9200.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_SIGMATEL=m
+
 config SND_HDA_CODEC_VIA
 	tristate "Build VIA HD-audio codec support"
 	select SND_HDA_GENERIC
@@ -114,6 +123,9 @@ config SND_HDA_CODEC_VIA
 	  Say Y or M here to include VIA HD-audio codec support in
 	  snd-hda-intel driver, such as VT1708.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_VIA=m
+
 config SND_HDA_CODEC_HDMI
 	tristate "Build HDMI/DisplayPort HD-audio codec support"
 	help
@@ -121,6 +133,9 @@ config SND_HDA_CODEC_HDMI
 	  support in snd-hda-intel driver.  This includes all AMD/ATI,
 	  Intel and Nvidia HDMI/DisplayPort codecs.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_HDMI=m
+
 config SND_HDA_I915
 	bool
 	default y
@@ -133,6 +148,9 @@ config SND_HDA_CODEC_CIRRUS
 	  Say Y or M here to include Cirrus Logic codec support in
 	  snd-hda-intel driver, such as CS4206.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CIRRUS=m
+
 config SND_HDA_CODEC_CONEXANT
 	tristate "Build Conexant HD-audio codec support"
 	select SND_HDA_GENERIC
@@ -140,6 +158,9 @@ config SND_HDA_CODEC_CONEXANT
 	  Say Y or M here to include Conexant HD-audio codec support in
 	  snd-hda-intel driver, such as CX20549.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CONEXANT=m
+
 config SND_HDA_CODEC_CA0110
 	tristate "Build Creative CA0110-IBG codec support"
 	select SND_HDA_GENERIC
@@ -147,12 +168,18 @@ config SND_HDA_CODEC_CA0110
 	  Say Y or M here to include Creative CA0110-IBG codec support in
 	  snd-hda-intel driver, found on some Creative X-Fi cards.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CA0110=m
+
 config SND_HDA_CODEC_CA0132
 	tristate "Build Creative CA0132 codec support"
 	help
 	  Say Y or M here to include Creative CA0132 codec support in
 	  snd-hda-intel driver.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CA0132=m
+
 config SND_HDA_CODEC_CA0132_DSP
 	bool "Support new DSP code for CA0132 codec"
 	depends on SND_HDA_CODEC_CA0132
@@ -172,18 +199,27 @@ config SND_HDA_CODEC_CMEDIA
 	  Say Y or M here to include C-Media HD-audio codec support in
 	  snd-hda-intel driver, such as CMI9880.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_CMEDIA=m
+
 config SND_HDA_CODEC_SI3054
 	tristate "Build Silicon Labs 3054 HD-modem codec support"
 	help
 	  Say Y or M here to include Silicon Labs 3054 HD-modem codec
 	  (and compatibles) support in snd-hda-intel driver.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_CODEC_SI3054=m
+
 config SND_HDA_GENERIC
 	tristate "Enable generic HD-audio codec parser"
 	help
 	  Say Y or M here to enable the generic HD-audio codec parser
 	  in snd-hda-intel driver.
 
+comment "Set to Y if you want auto-loading the codec driver"
+	depends on SND_HDA_INTEL=y && SND_HDA_GENERIC=m
+
 config SND_HDA_POWER_SAVE_DEFAULT
 	int "Default time-out for HD-audio power-save mode"
 	depends on PM
-- 
1.8.5
