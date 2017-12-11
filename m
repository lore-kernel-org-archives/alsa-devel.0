From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v2 10/11] ASoC: patch_realtek: add ASoC based
	Realtek HDA codec driver patch
Date: Mon, 11 Dec 2017 16:23:02 +0530
Message-ID: <1512989583-10877-11-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 16E22267557
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 11:48:58 +0100 (CET)
In-Reply-To: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds support for ASoC HDA codec driver for realtek
codecs.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/patch_realtek.c    |  3 ++-
 sound/soc/codecs/Kconfig         |  6 +++++
 sound/soc/codecs/Makefile        |  2 ++
 sound/soc/codecs/patch_realtek.c | 48 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/patch_realtek.c

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 921a10e..88a965c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7903,7 +7903,7 @@ static int patch_alc680(struct hda_codec *codec)
 /*
  * patch entries
  */
-static const struct hda_device_id snd_hda_id_realtek[] = {
+const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec0215, "ALC215", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0221, "ALC221", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0225, "ALC225", patch_alc269),
@@ -7974,6 +7974,7 @@ static const struct hda_device_id snd_hda_id_realtek[] = {
 	HDA_CODEC_ENTRY(0x10ec1220, "ALC1220", patch_alc882),
 	{} /* terminator */
 };
+EXPORT_SYMBOL_GPL(snd_hda_id_realtek);
 MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_realtek);
 
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1d41d11..97fd997 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -80,6 +80,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
 	select SND_SOC_HDAC_HDA
+	select SND_SOC_HDA_REALTEK
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
@@ -587,6 +588,11 @@ config SND_SOC_HDAC_HDA
 	select SND_HDA_EXT_CORE
 	select SND_PCM_ELD
 
+config SND_SOC_HDA_REALTEK
+	select SND_HDA_CODEC_REALTEK
+	select SND_SOC_HDAC_HDA
+	tristate "Realtek ASoC HDA Codec Driver patch"
+
 config SND_SOC_ICS43432
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index dd5f90f..158ee89 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -102,6 +102,7 @@ snd-soc-nau8810-objs := nau8810.o
 snd-soc-nau8824-objs := nau8824.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
+snd-soc-patch_realtek-objs := patch_realtek.o
 snd-soc-pcm1681-objs := pcm1681.o
 snd-soc-pcm179x-codec-objs := pcm179x.o
 snd-soc-pcm179x-i2c-objs := pcm179x-i2c.o
@@ -319,6 +320,7 @@ obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
+obj-$(CONFIG_SND_SOC_HDA_REALTEK)	+= snd-soc-patch_realtek.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
diff --git a/sound/soc/codecs/patch_realtek.c b/sound/soc/codecs/patch_realtek.c
new file mode 100644
index 0000000..80772c3
--- /dev/null
+++ b/sound/soc/codecs/patch_realtek.c
@@ -0,0 +1,48 @@
+/*
+ * Universal Interface for Intel High Definition Audio Codec
+ *
+ * ASoC HD audio interface patch for Realtek ALC codecs
+ *
+ * Copyright (c) 2004 Kailang Yang <kailang@realtek.com.tw>
+ *                    PeiSen Hou <pshou@realtek.com.tw>
+ *                    Takashi Iwai <tiwai@suse.de>
+ *                    Jonathan Woithe <jwoithe@just42.net>
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+/*
+ * license header and copyright is copy/pasted from the legacy realtek HDA
+ * driver, is that fine or I need to create a new one?
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <sound/hdaudio_ext.h>
+#include "../../pci/hda/hda_codec.h"
+#include "hdac_hda.h"
+
+/*
+ * Is snd_hda_id_realtek okay to keep it here or better to move into
+ * hda_codec.h file?
+ * Is it okay to define this as extern ?
+ */
+extern struct hda_device_id snd_hda_id_realtek[];
+
+static struct hdac_driver realtek_driver = {
+	.id_table = snd_hda_id_realtek,
+};
+
+module_hdac_hda_codec_driver(realtek_driver);
+
+MODULE_DESCRIPTION("Realtek ASoC HDA Codec driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
