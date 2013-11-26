From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: cs46xx: Move DSP blob out of kernel tree
Date: Tue, 26 Nov 2013 09:22:28 +0100
Message-ID: <1385454148-11860-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C3A2261092
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:22:29 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DA801A79B7
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:22:28 +0100 (CET)
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

... and load from the external firmware files.

The firmware binary blobs in cs46xx driver have been in a gray zone
regarding the license.  It's most likely should be OK, but still
unclear.  And, the size isn't that small, too.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=10750
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/Kconfig                  |    1 +
 sound/pci/cs46xx/cs46xx.h          |    5 +
 sound/pci/cs46xx/cs46xx_image.h    | 3468 ------------------------------------
 sound/pci/cs46xx/cs46xx_lib.c      |  265 ++-
 sound/pci/cs46xx/imgs/cwc4630.h    |  320 ----
 sound/pci/cs46xx/imgs/cwcasync.h   |  176 --
 sound/pci/cs46xx/imgs/cwcbinhack.h |   48 -
 sound/pci/cs46xx/imgs/cwcdma.asp   |  170 --
 sound/pci/cs46xx/imgs/cwcdma.h     |   68 -
 sound/pci/cs46xx/imgs/cwcsnoop.h   |   46 -
 10 files changed, 226 insertions(+), 4341 deletions(-)
 delete mode 100644 sound/pci/cs46xx/cs46xx_image.h
 delete mode 100644 sound/pci/cs46xx/imgs/cwc4630.h
 delete mode 100644 sound/pci/cs46xx/imgs/cwcasync.h
 delete mode 100644 sound/pci/cs46xx/imgs/cwcbinhack.h
 delete mode 100644 sound/pci/cs46xx/imgs/cwcdma.asp
 delete mode 100644 sound/pci/cs46xx/imgs/cwcdma.h
 delete mode 100644 sound/pci/cs46xx/imgs/cwcsnoop.h

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 46ed9e8ae0fd..3a0504dfeb8a 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -254,6 +254,7 @@ config SND_CS46XX
 	tristate "Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x"
 	select SND_RAWMIDI
 	select SND_AC97_CODEC
+	select FW_LOADER
 	help
 	  Say Y here to include support for Cirrus Logic CS4610/CS4612/
 	  CS4614/CS4615/CS4622/CS4624/CS4630/CS4280 chips.
diff --git a/sound/pci/cs46xx/cs46xx.h b/sound/pci/cs46xx/cs46xx.h
index fc339ef0a0ae..c49a082c378b 100644
--- a/sound/pci/cs46xx/cs46xx.h
+++ b/sound/pci/cs46xx/cs46xx.h
@@ -1716,9 +1716,14 @@ struct snd_cs46xx {
 	struct snd_pcm *pcm_rear;
 	struct snd_pcm *pcm_center_lfe;
 	struct snd_pcm *pcm_iec958;
+
+#define CS46XX_DSP_MODULES	5
+	struct dsp_module_desc *modules[CS46XX_DSP_MODULES];
 #else /* for compatibility */
 	struct snd_cs46xx_pcm *playback_pcm;
 	unsigned int play_ctl;
+
+	struct ba1_struct *ba1;
 #endif
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/sound/pci/cs46xx/cs46xx_image.h b/sound/pci/cs46xx/cs46xx_image.h
deleted file mode 100644
index dc93f62db2c2..000000000000
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 1b66efd9b728..f18e5878f58b 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -54,7 +54,9 @@
 #include <linux/gameport.h>
 #include <linux/mutex.h>
 #include <linux/export.h>
-
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/vmalloc.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -330,13 +332,146 @@ int snd_cs46xx_download(struct snd_cs46xx *chip,
 	return 0;
 }
 
+static inline void memcpy_le32(void *dst, const void *src, unsigned int len)
+{
+#ifdef __LITTLE_ENDIAN
+	memcpy(dst, src, len);
+#else
+	u32 *_dst = dst;
+	const __le32 *_src = src;
+	len /= 4;
+	while (len-- > 0)
+		*_dst++ = le32_to_cpu(*_src++);
+#endif
+}
+
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
-#include "imgs/cwc4630.h"
-#include "imgs/cwcasync.h"
-#include "imgs/cwcsnoop.h"
-#include "imgs/cwcbinhack.h"
-#include "imgs/cwcdma.h"
+static const char *module_names[CS46XX_DSP_MODULES] = {
+	"cwc4630", "cwcasync", "cwcsnoop", "cwcbinhack", "cwcdma"
+};
+
+MODULE_FIRMWARE("cs46xx/cwc4630");
+MODULE_FIRMWARE("cs46xx/cwcasync");
+MODULE_FIRMWARE("cs46xx/cwcsnoop");
+MODULE_FIRMWARE("cs46xx/cwcbinhack");
+MODULE_FIRMWARE("cs46xx/cwcdma");
+
+static void free_module_desc(struct dsp_module_desc *module)
+{
+	if (!module)
+		return;
+	kfree(module->module_name);
+	kfree(module->symbol_table.symbols);
+	if (module->segments) {
+		int i;
+		for (i = 0; i < module->nsegments; i++)
+			kfree(module->segments[i].data);
+		kfree(module->segments);
+	}
+}
+
+/* firmware binary format:
+ * le32 nsymbols;
+ * struct {
+ *	le32 address;
+ *	char symbol_name[DSP_MAX_SYMBOL_NAME];
+ *	le32 symbol_type;
+ * } symbols[nsymbols];
+ * le32 nsegments;
+ * struct {
+ *	le32 segment_type;
+ *	le32 offset;
+ *	le32 size;
+ *	le32 data[size];
+ * } segments[nsegments];
+ */
+
+static int load_firmware(struct snd_cs46xx *chip,
+			 struct dsp_module_desc **module_ret,
+			 const char *fw_name)
+{
+	int i, err;
+	unsigned int nums, fwlen, fwsize;
+	const __le32 *fwdat;
+	struct dsp_module_desc *module = NULL;
+	const struct firmware *fw;
+	char fw_path[32];
+
+	sprintf(fw_path, "cs46xx/%s", fw_name);
+	err = request_firmware(&fw, fw_path, &chip->pci->dev);
+	if (err < 0)
+		return err;
+	fwsize = fw->size / 4;
+	if (fwsize < 2) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	err = -ENOMEM;
+	module = kzalloc(sizeof(*module), GFP_KERNEL);
+	if (!module)
+		goto error;
+	module->module_name = kstrdup(fw_name, GFP_KERNEL);
+	if (!module->module_name)
+		goto error;
+
+	fwlen = 0;
+	fwdat = (const __le32 *)fw->data;
+	nums = module->symbol_table.nsymbols = le32_to_cpu(fwdat[fwlen++]);
+	if (nums >= 40)
+		goto error_inval;
+	module->symbol_table.symbols =
+		kcalloc(nums, sizeof(struct dsp_symbol_entry), GFP_KERNEL);
+	if (!module->symbol_table.symbols)
+		goto error;
+	for (i = 0; i < nums; i++) {
+		struct dsp_symbol_entry *entry =
+			&module->symbol_table.symbols[i];
+		if (fwlen + 2 + DSP_MAX_SYMBOL_NAME / 4 > fwsize)
+			goto error_inval;
+		entry->address = le32_to_cpu(fwdat[fwlen++]);
+		memcpy(entry->symbol_name, &fwdat[fwlen], DSP_MAX_SYMBOL_NAME - 1);
+		fwlen += DSP_MAX_SYMBOL_NAME / 4;
+		entry->symbol_type = le32_to_cpu(fwdat[fwlen++]);
+	}
+
+	if (fwlen >= fwsize)
+		goto error_inval;
+	nums = module->nsegments = le32_to_cpu(fwdat[fwlen++]);
+	if (nums > 10)
+		goto error_inval;
+	module->segments =
+		kcalloc(nums, sizeof(struct dsp_segment_desc), GFP_KERNEL);
+	if (!module->segments)
+		goto error;
+	for (i = 0; i < nums; i++) {
+		struct dsp_segment_desc *entry = &module->segments[i];
+		if (fwlen + 3 > fwsize)
+			goto error_inval;
+		entry->segment_type = le32_to_cpu(fwdat[fwlen++]);
+		entry->offset = le32_to_cpu(fwdat[fwlen++]);
+		entry->size = le32_to_cpu(fwdat[fwlen++]);
+		if (fwlen + entry->size > fwsize)
+			goto error_inval;
+		entry->data = kmalloc(entry->size * 4, GFP_KERNEL);
+		if (!entry->data)
+			goto error;
+		memcpy_le32(entry->data, &fwdat[fwlen], entry->size * 4);
+		fwlen += entry->size;
+	}
+
+	*module_ret = module;
+	release_firmware(fw);
+	return 0;
+
+ error_inval:
+	err = -EINVAL;
+ error:
+	free_module_desc(module);
+	release_firmware(fw);
+	return err;
+}
 
 int snd_cs46xx_clear_BA1(struct snd_cs46xx *chip,
                          unsigned long offset,
@@ -361,20 +496,63 @@ int snd_cs46xx_clear_BA1(struct snd_cs46xx *chip,
 
 #else /* old DSP image */
 
-#include "cs46xx_image.h"
+struct ba1_struct {
+	struct {
+		u32 offset;
+		u32 size;
+	} memory[BA1_MEMORY_COUNT];
+	u32 map[BA1_DWORD_SIZE];
+};
+
+MODULE_FIRMWARE("cs46xx/ba1");
+
+static int load_firmware(struct snd_cs46xx *chip)
+{
+	const struct firmware *fw;
+	int i, size, err;
+
+	err = request_firmware(&fw, "cs46xx/ba1", &chip->pci->dev);
+	if (err < 0)
+		return err;
+	if (fw->size != sizeof(*chip->ba1)) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	chip->ba1 = vmalloc(sizeof(*chip->ba1));
+	if (!chip->ba1) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	memcpy_le32(chip->ba1, fw->data, sizeof(*chip->ba1));
+
+	/* sanity check */
+	size = 0;
+	for (i = 0; i < BA1_MEMORY_COUNT; i++)
+		size += chip->ba1->memory[i].size;
+	if (size > BA1_DWORD_SIZE * 4)
+		err = -EINVAL;
+
+ error:
+	release_firmware(fw);
+	return err;
+}
 
 int snd_cs46xx_download_image(struct snd_cs46xx *chip)
 {
 	int idx, err;
-	unsigned long offset = 0;
+	unsigned int offset = 0;
+	struct ba1_struct *ba1 = chip->ba1;
 
 	for (idx = 0; idx < BA1_MEMORY_COUNT; idx++) {
-		if ((err = snd_cs46xx_download(chip,
-					       &BA1Struct.map[offset],
-					       BA1Struct.memory[idx].offset,
-					       BA1Struct.memory[idx].size)) < 0)
+		err = snd_cs46xx_download(chip,
+					  &ba1->map[offset],
+					  ba1->memory[idx].offset,
+					  ba1->memory[idx].size);
+		if (err < 0)
 			return err;
-		offset += BA1Struct.memory[idx].size >> 2;
+		offset += ba1->memory[idx].size >> 2;
 	}	
 	return 0;
 }
@@ -2798,6 +2976,10 @@ static int snd_cs46xx_free(struct snd_cs46xx *chip)
 		cs46xx_dsp_spos_destroy(chip);
 		chip->dsp_spos_instance = NULL;
 	}
+	for (idx = 0; idx < CS46XX_DSP_MODULES; idx++)
+		free_module_desc(chip->modules[idx]);
+#else
+	vfree(chip->ba1);
 #endif
 	
 #ifdef CONFIG_PM_SLEEP
@@ -3067,6 +3249,11 @@ static void cs46xx_enable_stream_irqs(struct snd_cs46xx *chip)
 int snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
 {	
 	unsigned int tmp;
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	int i;
+#endif
+	int err;
+
 	/*
 	 *  Reset the processor.
 	 */
@@ -3075,45 +3262,33 @@ int snd_cs46xx_start_dsp(struct snd_cs46xx *chip)
 	 *  Download the image to the processor.
 	 */
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-#if 0
-	if (cs46xx_dsp_load_module(chip, &cwcemb80_module) < 0) {
-		snd_printk(KERN_ERR "image download error\n");
-		return -EIO;
-	}
-#endif
-
-	if (cs46xx_dsp_load_module(chip, &cwc4630_module) < 0) {
-		snd_printk(KERN_ERR "image download error [cwc4630]\n");
-		return -EIO;
-	}
-
-	if (cs46xx_dsp_load_module(chip, &cwcasync_module) < 0) {
-		snd_printk(KERN_ERR "image download error [cwcasync]\n");
-		return -EIO;
-	}
-
-	if (cs46xx_dsp_load_module(chip, &cwcsnoop_module) < 0) {
-		snd_printk(KERN_ERR "image download error [cwcsnoop]\n");
-		return -EIO;
-	}
-
-	if (cs46xx_dsp_load_module(chip, &cwcbinhack_module) < 0) {
-		snd_printk(KERN_ERR "image download error [cwcbinhack]\n");
-		return -EIO;
-	}
-
-	if (cs46xx_dsp_load_module(chip, &cwcdma_module) < 0) {
-		snd_printk(KERN_ERR "image download error [cwcdma]\n");
-		return -EIO;
+	for (i = 0; i < CS46XX_DSP_MODULES; i++) {
+		err = load_firmware(chip, &chip->modules[i], module_names[i]);
+		if (err < 0) {
+			snd_printk(KERN_ERR "firmware load error [%s]\n",
+				   module_names[i]);
+			return err;
+		}
+		err = cs46xx_dsp_load_module(chip, chip->modules[i]);
+		if (err < 0) {
+			snd_printk(KERN_ERR "image download error [%s]\n",
+				   module_names[i]);
+			return err;
+		}
 	}
 
 	if (cs46xx_dsp_scb_and_task_init(chip) < 0)
 		return -EIO;
 #else
+	err = load_firmware(chip);
+	if (err < 0)
+		return err;
+
 	/* old image */
-	if (snd_cs46xx_download_image(chip) < 0) {
+	err = snd_cs46xx_download_image(chip);
+	if (err < 0) {
 		snd_printk(KERN_ERR "image download error\n");
-		return -EIO;
+		return err;
 	}
 
 	/*
diff --git a/sound/pci/cs46xx/imgs/cwc4630.h b/sound/pci/cs46xx/imgs/cwc4630.h
deleted file mode 100644
index 37c4f1318dc5..000000000000
diff --git a/sound/pci/cs46xx/imgs/cwcasync.h b/sound/pci/cs46xx/imgs/cwcasync.h
deleted file mode 100644
index 70e63e13c2b3..000000000000
diff --git a/sound/pci/cs46xx/imgs/cwcbinhack.h b/sound/pci/cs46xx/imgs/cwcbinhack.h
deleted file mode 100644
index f4d93689cd49..000000000000
diff --git a/sound/pci/cs46xx/imgs/cwcdma.asp b/sound/pci/cs46xx/imgs/cwcdma.asp
deleted file mode 100644
index a65e1193c89a..000000000000
diff --git a/sound/pci/cs46xx/imgs/cwcdma.h b/sound/pci/cs46xx/imgs/cwcdma.h
deleted file mode 100644
index 7ff0d4587161..000000000000
diff --git a/sound/pci/cs46xx/imgs/cwcsnoop.h b/sound/pci/cs46xx/imgs/cwcsnoop.h
deleted file mode 100644
index 6929d0a5a3f3..000000000000
-- 
1.8.4.3
