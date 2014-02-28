From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 16/19] ALSA: hda - Move codec create to hda_shared
Date: Thu, 27 Feb 2014 22:35:59 -0800
Message-ID: <1393569362-27285-17-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f74.google.com (mail-qa0-f74.google.com
 [209.85.216.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B4A22650AE
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-qa0-f74.google.com with SMTP id cm18so34323qab.5
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

Codec creation and stream initialization can be shared between
hda_intel and hda platform drivers.  Move it and the static functions
it depends on.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 218 ----------------------------------------
 sound/pci/hda/hda_shared.c | 241 ++++++++++++++++++++++++++++++++++++++++++---
 sound/pci/hda/hda_shared.h |  26 ++---
 3 files changed, 238 insertions(+), 247 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a42c576..293a616 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -319,10 +319,6 @@ static const struct azx_reg_ops pci_reg_ops = {
 
 static int azx_acquire_irq(struct azx *chip, int do_disconnect);
 
-#ifdef CONFIG_PM
-static void azx_power_notify(struct hda_bus *bus, bool power_up);
-#endif
-
 /*
  * initialize the PCI registers
  */
@@ -396,206 +392,6 @@ static void azx_init_pci(struct azx *chip)
         }
 }
 
-/*
- * Probe the given codec address
- */
-static int probe_codec(struct azx *chip, int addr)
-{
-	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
-		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
-	unsigned int res;
-
-	mutex_lock(&chip->bus->cmd_mutex);
-	chip->probing = 1;
-	azx_send_cmd(chip->bus, cmd);
-	res = azx_get_response(chip->bus, addr);
-	chip->probing = 0;
-	mutex_unlock(&chip->bus->cmd_mutex);
-	if (res == -1)
-		return -EIO;
-	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);
-	return 0;
-}
-
-static void azx_bus_reset(struct hda_bus *bus)
-{
-	struct azx *chip = bus->private_data;
-
-	bus->in_reset = 1;
-	azx_stop_chip(chip);
-	azx_init_chip(chip, 1);
-#ifdef CONFIG_PM
-	if (chip->initialized) {
-		struct azx_pcm *p;
-		list_for_each_entry(p, &chip->pcm_list, list)
-			snd_pcm_suspend_all(p->pcm);
-		snd_hda_suspend(chip->bus);
-		snd_hda_resume(chip->bus);
-	}
-#endif
-	bus->in_reset = 0;
-}
-
-static int get_jackpoll_interval(struct azx *chip)
-{
-	int i;
-	unsigned int j;
-
-	if (!chip->jackpoll_ms)
-		return 0;
-
-	i = chip->jackpoll_ms[chip->dev_index];
-	if (i == 0)
-		return 0;
-	if (i < 50 || i > 60000)
-		j = 0;
-	else
-		j = msecs_to_jiffies(i);
-	if (j == 0)
-		dev_warn(chip->card->dev,
-			 "jackpoll_ms value out of range: %d\n", i);
-	return j;
-}
-
-/*
- * Codec initialization
- */
-
-static int azx_codec_create(struct azx *chip, const char *model,
-			    unsigned int max_slots,
-			    int *power_save_to)
-{
-	struct hda_bus_template bus_temp;
-	int c, codecs, err;
-
-	memset(&bus_temp, 0, sizeof(bus_temp));
-	bus_temp.private_data = chip;
-	bus_temp.modelname = model;
-	bus_temp.pci = chip->pci;
-	bus_temp.ops.command = azx_send_cmd;
-	bus_temp.ops.get_response = azx_get_response;
-	bus_temp.ops.attach_pcm = azx_attach_pcm_stream;
-	bus_temp.ops.bus_reset = azx_bus_reset;
-#ifdef CONFIG_PM
-	bus_temp.power_save = power_save_to;
-	bus_temp.ops.pm_notify = azx_power_notify;
-#endif
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-	bus_temp.ops.load_dsp_prepare = azx_load_dsp_prepare;
-	bus_temp.ops.load_dsp_trigger = azx_load_dsp_trigger;
-	bus_temp.ops.load_dsp_cleanup = azx_load_dsp_cleanup;
-#endif
-
-	err = snd_hda_bus_new(chip->card, &bus_temp, &chip->bus);
-	if (err < 0)
-		return err;
-
-	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY) {
-		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
-		chip->bus->needs_damn_long_delay = 1;
-	}
-
-	codecs = 0;
-	if (!max_slots)
-		max_slots = AZX_DEFAULT_CODECS;
-
-	/* First try to probe all given codec slots */
-	for (c = 0; c < max_slots; c++) {
-		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
-			if (probe_codec(chip, c) < 0) {
-				/* Some BIOSen give you wrong codec addresses
-				 * that don't exist
-				 */
-				dev_warn(chip->card->dev,
-					 "Codec #%d probe error; disabling it...\n", c);
-				chip->codec_mask &= ~(1 << c);
-				/* More badly, accessing to a non-existing
-				 * codec often screws up the controller chip,
-				 * and disturbs the further communications.
-				 * Thus if an error occurs during probing,
-				 * better to reset the controller chip to
-				 * get back to the sanity state.
-				 */
-				azx_stop_chip(chip);
-				azx_init_chip(chip, 1);
-			}
-		}
-	}
-
-	/* AMD chipsets often cause the communication stalls upon certain
-	 * sequence like the pin-detection.  It seems that forcing the synced
-	 * access works around the stall.  Grrr...
-	 */
-	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
-		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
-		chip->bus->sync_write = 1;
-		chip->bus->allow_bus_reset = 1;
-	}
-
-	/* Then create codec instances */
-	for (c = 0; c < max_slots; c++) {
-		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
-			struct hda_codec *codec;
-			err = snd_hda_codec_new(chip->bus, c, &codec);
-			if (err < 0)
-				continue;
-			codec->jackpoll_interval = get_jackpoll_interval(chip);
-			codec->beep_mode = chip->beep_mode;
-			codecs++;
-		}
-	}
-	if (!codecs) {
-		dev_err(chip->card->dev, "no codecs initialized\n");
-		return -ENXIO;
-	}
-	return 0;
-}
-
-/* configure each codec instance */
-static int azx_codec_configure(struct azx *chip)
-{
-	struct hda_codec *codec;
-	list_for_each_entry(codec, &chip->bus->codec_list, list) {
-		snd_hda_codec_configure(codec);
-	}
-	return 0;
-}
-
-/*
- * mixer creation - all stuff is implemented in hda module
- */
-static int azx_mixer_create(struct azx *chip)
-{
-	return snd_hda_build_controls(chip->bus);
-}
-
-
-/*
- * initialize SD streams
- */
-static int azx_init_stream(struct azx *chip)
-{
-	int i;
-
-	/* initialize each stream (aka device)
-	 * assign the starting bdl address to each stream (device)
-	 * and initialize
-	 */
-	for (i = 0; i < chip->num_streams; i++) {
-		struct azx_dev *azx_dev = &chip->azx_dev[i];
-		azx_dev->posbuf = (u32 __iomem *)(chip->posbuf.area + i * 8);
-		/* offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
-		azx_dev->sd_addr = chip->remap_addr + (0x20 * i + 0x80);
-		/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
-		azx_dev->sd_int_sta_mask = 1 << i;
-		/* stream tag: must be non-zero and unique */
-		azx_dev->index = i;
-		azx_dev->stream_tag = i + 1;
-	}
-
-	return 0;
-}
-
 static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 {
 	if (request_irq(chip->pci->irq, azx_interrupt,
@@ -614,20 +410,6 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 }
 
 #ifdef CONFIG_PM
-/* power-up/down the controller */
-static void azx_power_notify(struct hda_bus *bus, bool power_up)
-{
-	struct azx *chip = bus->private_data;
-
-	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
-		return;
-
-	if (power_up)
-		pm_runtime_get_sync(chip->card->dev);
-	else
-		pm_runtime_put_sync(chip->card->dev);
-}
-
 static DEFINE_MUTEX(card_list_lock);
 static LIST_HEAD(card_list);
 
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index 2821363..952d764 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #ifdef CONFIG_X86
 /* for snoop control */
@@ -1034,8 +1035,8 @@ static void azx_pcm_free(struct snd_pcm *pcm)
 
 #define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
 
-int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
-			  struct hda_pcm *cpcm)
+static int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
+				 struct hda_pcm *cpcm)
 {
 	struct azx *chip = bus->private_data;
 	struct snd_pcm *pcm;
@@ -1452,7 +1453,7 @@ static unsigned int azx_single_get_response(struct hda_bus *bus,
  */
 
 /* send a command */
-int azx_send_cmd(struct hda_bus *bus, unsigned int val)
+static int azx_send_cmd(struct hda_bus *bus, unsigned int val)
 {
 	struct azx *chip = bus->private_data;
 
@@ -1466,8 +1467,8 @@ int azx_send_cmd(struct hda_bus *bus, unsigned int val)
 }
 
 /* get a response */
-unsigned int azx_get_response(struct hda_bus *bus,
-			      unsigned int addr)
+static unsigned int azx_get_response(struct hda_bus *bus,
+				     unsigned int addr)
 {
 	struct azx *chip = bus->private_data;
 	if (chip->disabled)
@@ -1490,9 +1491,9 @@ azx_get_dsp_loader_dev(struct azx *chip)
 	return &chip->azx_dev[chip->playback_index_offset];
 }
 
-int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
-			 unsigned int byte_size,
-			 struct snd_dma_buffer *bufp)
+static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp)
 {
 	u32 *bdl;
 	struct azx *chip = bus->private_data;
@@ -1554,7 +1555,7 @@ int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
 	return err;
 }
 
-void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
+static void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
 {
 	struct azx *chip = bus->private_data;
 	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
@@ -1566,8 +1567,8 @@ void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
 	azx_dev->running = start;
 }
 
-void azx_load_dsp_cleanup(struct hda_bus *bus,
-			  struct snd_dma_buffer *dmab)
+static void azx_load_dsp_cleanup(struct hda_bus *bus,
+				 struct snd_dma_buffer *dmab)
 {
 	struct azx *chip = bus->private_data;
 	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
@@ -1826,6 +1827,7 @@ void azx_stop_chip(struct azx *chip)
 
 	chip->initialized = 0;
 }
+EXPORT_SYMBOL_GPL(azx_stop_chip);
 
 /*
  * interrupt handler
@@ -1953,5 +1955,222 @@ void azx_clear_irq_pending(struct azx *chip)
 }
 EXPORT_SYMBOL_GPL(azx_clear_irq_pending);
 
+/*
+ * Codec initerface
+ */
+
+/*
+ * Probe the given codec address
+ */
+static int probe_codec(struct azx *chip, int addr)
+{
+	unsigned int cmd = (addr << 28) | (AC_NODE_ROOT << 20) |
+		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
+	unsigned int res;
+
+	mutex_lock(&chip->bus->cmd_mutex);
+	chip->probing = 1;
+	azx_send_cmd(chip->bus, cmd);
+	res = azx_get_response(chip->bus, addr);
+	chip->probing = 0;
+	mutex_unlock(&chip->bus->cmd_mutex);
+	if (res == -1)
+		return -EIO;
+	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);
+	return 0;
+}
+
+static void azx_bus_reset(struct hda_bus *bus)
+{
+	struct azx *chip = bus->private_data;
+
+	bus->in_reset = 1;
+	azx_stop_chip(chip);
+	azx_init_chip(chip, 1);
+#ifdef CONFIG_PM
+	if (chip->initialized) {
+		struct azx_pcm *p;
+		list_for_each_entry(p, &chip->pcm_list, list)
+			snd_pcm_suspend_all(p->pcm);
+		snd_hda_suspend(chip->bus);
+		snd_hda_resume(chip->bus);
+	}
+#endif
+	bus->in_reset = 0;
+}
+
+#ifdef CONFIG_PM
+/* power-up/down the controller */
+static void azx_power_notify(struct hda_bus *bus, bool power_up)
+{
+	struct azx *chip = bus->private_data;
+
+	if (!(chip->driver_caps & AZX_DCAPS_PM_RUNTIME))
+		return;
+
+	if (power_up)
+		pm_runtime_get_sync(chip->card->dev);
+	else
+		pm_runtime_put_sync(chip->card->dev);
+}
+#endif
+
+static int get_jackpoll_interval(struct azx *chip)
+{
+	int i;
+	unsigned int j;
+
+	if (!chip->jackpoll_ms)
+		return 0;
+
+	i = chip->jackpoll_ms[chip->dev_index];
+	if (i == 0)
+		return 0;
+	if (i < 50 || i > 60000)
+		j = 0;
+	else
+		j = msecs_to_jiffies(i);
+	if (j == 0)
+		dev_warn(chip->card->dev,
+			 "jackpoll_ms value out of range: %d\n", i);
+	return j;
+}
+
+/* Codec initialization */
+int azx_codec_create(struct azx *chip, const char *model,
+		     unsigned int max_slots,
+		     int *power_save_to)
+{
+	struct hda_bus_template bus_temp;
+	int c, codecs, err;
+
+	memset(&bus_temp, 0, sizeof(bus_temp));
+	bus_temp.private_data = chip;
+	bus_temp.modelname = model;
+	bus_temp.pci = chip->pci;
+	bus_temp.ops.command = azx_send_cmd;
+	bus_temp.ops.get_response = azx_get_response;
+	bus_temp.ops.attach_pcm = azx_attach_pcm_stream;
+	bus_temp.ops.bus_reset = azx_bus_reset;
+#ifdef CONFIG_PM
+	bus_temp.power_save = power_save_to;
+	bus_temp.ops.pm_notify = azx_power_notify;
+#endif
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+	bus_temp.ops.load_dsp_prepare = azx_load_dsp_prepare;
+	bus_temp.ops.load_dsp_trigger = azx_load_dsp_trigger;
+	bus_temp.ops.load_dsp_cleanup = azx_load_dsp_cleanup;
+#endif
+
+	err = snd_hda_bus_new(chip->card, &bus_temp, &chip->bus);
+	if (err < 0)
+		return err;
+
+	if (chip->driver_caps & AZX_DCAPS_RIRB_DELAY) {
+		dev_dbg(chip->card->dev, "Enable delay in RIRB handling\n");
+		chip->bus->needs_damn_long_delay = 1;
+	}
+
+	codecs = 0;
+	if (!max_slots)
+		max_slots = AZX_DEFAULT_CODECS;
+
+	/* First try to probe all given codec slots */
+	for (c = 0; c < max_slots; c++) {
+		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
+			if (probe_codec(chip, c) < 0) {
+				/* Some BIOSen give you wrong codec addresses
+				 * that don't exist
+				 */
+				dev_warn(chip->card->dev,
+					 "Codec #%d probe error; disabling it...\n", c);
+				chip->codec_mask &= ~(1 << c);
+				/* More badly, accessing to a non-existing
+				 * codec often screws up the controller chip,
+				 * and disturbs the further communications.
+				 * Thus if an error occurs during probing,
+				 * better to reset the controller chip to
+				 * get back to the sanity state.
+				 */
+				azx_stop_chip(chip);
+				azx_init_chip(chip, 1);
+			}
+		}
+	}
+
+	/* AMD chipsets often cause the communication stalls upon certain
+	 * sequence like the pin-detection.  It seems that forcing the synced
+	 * access works around the stall.  Grrr...
+	 */
+	if (chip->driver_caps & AZX_DCAPS_SYNC_WRITE) {
+		dev_dbg(chip->card->dev, "Enable sync_write for stable communication\n");
+		chip->bus->sync_write = 1;
+		chip->bus->allow_bus_reset = 1;
+	}
+
+	/* Then create codec instances */
+	for (c = 0; c < max_slots; c++) {
+		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
+			struct hda_codec *codec;
+			err = snd_hda_codec_new(chip->bus, c, &codec);
+			if (err < 0)
+				continue;
+			codec->jackpoll_interval = get_jackpoll_interval(chip);
+			codec->beep_mode = chip->beep_mode;
+			codecs++;
+		}
+	}
+	if (!codecs) {
+		dev_err(chip->card->dev, "no codecs initialized\n");
+		return -ENXIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_codec_create);
+
+/* configure each codec instance */
+int azx_codec_configure(struct azx *chip)
+{
+	struct hda_codec *codec;
+	list_for_each_entry(codec, &chip->bus->codec_list, list) {
+		snd_hda_codec_configure(codec);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_codec_configure);
+
+/* mixer creation - all stuff is implemented in hda module */
+int azx_mixer_create(struct azx *chip)
+{
+	return snd_hda_build_controls(chip->bus);
+}
+EXPORT_SYMBOL_GPL(azx_mixer_create);
+
+
+/* initialize SD streams */
+int azx_init_stream(struct azx *chip)
+{
+	int i;
+
+	/* initialize each stream (aka device)
+	 * assign the starting bdl address to each stream (device)
+	 * and initialize
+	 */
+	for (i = 0; i < chip->num_streams; i++) {
+		struct azx_dev *azx_dev = &chip->azx_dev[i];
+		azx_dev->posbuf = (u32 __iomem *)(chip->posbuf.area + i * 8);
+		/* offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
+		azx_dev->sd_addr = chip->remap_addr + (0x20 * i + 0x80);
+		/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
+		azx_dev->sd_int_sta_mask = 1 << i;
+		/* stream tag: must be non-zero and unique */
+		azx_dev->index = i;
+		azx_dev->stream_tag = i + 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(azx_init_stream);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Common HDA driver funcitons");
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index 8eed8cb..16eabff 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -21,8 +21,6 @@
 #include "hda_priv.h"
 
 /* PCM setup */
-int azx_attach_pcm_stream(struct hda_bus *bus, struct hda_codec *codec,
-			  struct hda_pcm *cpcm);
 static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 {
 	return substream->runtime->private_data;
@@ -31,26 +29,10 @@ static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 /* Stream control. */
 void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev);
 
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
-			 unsigned int byte_size,
-			 struct snd_dma_buffer *bufp);
-void azx_load_dsp_trigger(struct hda_bus *bus, bool start);
-void azx_load_dsp_cleanup(struct hda_bus *bus,
-			  struct snd_dma_buffer *dmab);
-#endif
-
 /* Allocation functions. */
 int azx_alloc_stream_pages(struct azx *chip);
 void azx_free_stream_pages(struct azx *chip);
 
-/*
- * CORB / RIRB interface
- */
-int azx_send_cmd(struct hda_bus *bus, unsigned int val);
-unsigned int azx_get_response(struct hda_bus *bus,
-			      unsigned int addr);
-
 /* Low level azx interface */
 void azx_init_chip(struct azx *chip, int full_reset);
 void azx_stop_chip(struct azx *chip);
@@ -59,4 +41,12 @@ irqreturn_t azx_interrupt(int irq, void *dev_id);
 void azx_irq_pending_work(struct work_struct *work);
 void azx_clear_irq_pending(struct azx *chip);
 
+/* Codec interface */
+int azx_codec_create(struct azx *chip, const char *model,
+		     unsigned int max_slots,
+		     int *power_save_to);
+int azx_codec_configure(struct azx *chip);
+int azx_mixer_create(struct azx *chip);
+int azx_init_stream(struct azx *chip);
+
 #endif /* __SOUND_HDA_SHARED_H */
-- 
1.8.1.3.605.g02339dd
