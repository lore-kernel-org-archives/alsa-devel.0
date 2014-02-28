From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 07/19] ALSA: hda - Move the dsp loader to
	hda_shared
Date: Thu, 27 Feb 2014 22:35:50 -0800
Message-ID: <1393569362-27285-8-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f74.google.com (mail-pa0-f74.google.com
 [209.85.220.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A952650C2
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-pa0-f74.google.com with SMTP id fa1so34057pad.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
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

Moving the DSP loading functionality to hda_shared.c means that the
dsp lock doesn't need to be shared in hda_intel and hda_shared.  The
forthcoming platform driver doesn't need the DSP loading code, but
sharing it doesn't hurt.

Tested on Chromebook Pixel's ca0132 that uses the DSP loader.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c  | 128 -------------------------------------------
 sound/pci/hda/hda_shared.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_shared.h |  16 +++---
 3 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c9c541b..33dc7ae 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -688,15 +688,6 @@ static unsigned int azx_get_response(struct hda_bus *bus,
 static void azx_power_notify(struct hda_bus *bus, bool power_up);
 #endif
 
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
-				unsigned int byte_size,
-				struct snd_dma_buffer *bufp);
-static void azx_load_dsp_trigger(struct hda_bus *bus, bool start);
-static void azx_load_dsp_cleanup(struct hda_bus *bus,
-				 struct snd_dma_buffer *dmab);
-#endif
-
 /* enter link reset */
 static void azx_enter_link_reset(struct azx *chip)
 {
@@ -1292,125 +1283,6 @@ static void azx_stop_chip(struct azx *chip)
 	chip->initialized = 0;
 }
 
-#ifdef CONFIG_SND_HDA_DSP_LOADER
-/*
- * DSP loading code (e.g. for CA0132)
- */
-
-/* use the first stream for loading DSP */
-static struct azx_dev *
-azx_get_dsp_loader_dev(struct azx *chip)
-{
-	return &chip->azx_dev[chip->playback_index_offset];
-}
-
-static int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
-				unsigned int byte_size,
-				struct snd_dma_buffer *bufp)
-{
-	u32 *bdl;
-	struct azx *chip = bus->private_data;
-	struct azx_dev *azx_dev;
-	int err;
-
-	azx_dev = azx_get_dsp_loader_dev(chip);
-
-	dsp_lock(azx_dev);
-	spin_lock_irq(&chip->reg_lock);
-	if (azx_dev->running || azx_dev->locked) {
-		spin_unlock_irq(&chip->reg_lock);
-		err = -EBUSY;
-		goto unlock;
-	}
-	azx_dev->prepared = 0;
-	chip->saved_azx_dev = *azx_dev;
-	azx_dev->locked = 1;
-	spin_unlock_irq(&chip->reg_lock);
-
-	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
-				  chip->card->dev,
-				  byte_size, bufp);
-	if (err < 0)
-		goto err_alloc;
-
-	mark_pages_wc(chip, bufp, true);
-	azx_dev->bufsize = byte_size;
-	azx_dev->period_bytes = byte_size;
-	azx_dev->format_val = format;
-
-	azx_stream_reset(chip, azx_dev);
-
-	/* reset BDL address */
-	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
-
-	azx_dev->frags = 0;
-	bdl = (u32 *)azx_dev->bdl.area;
-	err = setup_bdle(chip, bufp, azx_dev, &bdl, 0, byte_size, 0);
-	if (err < 0)
-		goto error;
-
-	azx_setup_controller(chip, azx_dev);
-	dsp_unlock(azx_dev);
-	return azx_dev->stream_tag;
-
- error:
-	mark_pages_wc(chip, bufp, false);
-	snd_dma_free_pages(bufp);
- err_alloc:
-	spin_lock_irq(&chip->reg_lock);
-	if (azx_dev->opened)
-		*azx_dev = chip->saved_azx_dev;
-	azx_dev->locked = 0;
-	spin_unlock_irq(&chip->reg_lock);
- unlock:
-	dsp_unlock(azx_dev);
-	return err;
-}
-
-static void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
-{
-	struct azx *chip = bus->private_data;
-	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
-
-	if (start)
-		azx_stream_start(chip, azx_dev);
-	else
-		azx_stream_stop(chip, azx_dev);
-	azx_dev->running = start;
-}
-
-static void azx_load_dsp_cleanup(struct hda_bus *bus,
-				 struct snd_dma_buffer *dmab)
-{
-	struct azx *chip = bus->private_data;
-	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
-
-	if (!dmab->area || !azx_dev->locked)
-		return;
-
-	dsp_lock(azx_dev);
-	/* reset BDL address */
-	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
-	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
-	azx_sd_writel(chip, azx_dev, SD_CTL, 0);
-	azx_dev->bufsize = 0;
-	azx_dev->period_bytes = 0;
-	azx_dev->format_val = 0;
-
-	mark_pages_wc(chip, dmab, false);
-	snd_dma_free_pages(dmab);
-	dmab->area = NULL;
-
-	spin_lock_irq(&chip->reg_lock);
-	if (azx_dev->opened)
-		*azx_dev = chip->saved_azx_dev;
-	azx_dev->locked = 0;
-	spin_unlock_irq(&chip->reg_lock);
-	dsp_unlock(azx_dev);
-}
-#endif /* CONFIG_SND_HDA_DSP_LOADER */
-
 #ifdef CONFIG_PM
 /* power-up/down the controller */
 static void azx_power_notify(struct hda_bus *bus, bool power_up)
diff --git a/sound/pci/hda/hda_shared.c b/sound/pci/hda/hda_shared.c
index e921154..27377ca 100644
--- a/sound/pci/hda/hda_shared.c
+++ b/sound/pci/hda/hda_shared.c
@@ -38,6 +38,19 @@
 #define CREATE_TRACE_POINTS
 #include "hda_intel_trace.h"
 
+/* DSP lock helpers */
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
+#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
+#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
+#define dsp_is_locked(dev)	((dev)->locked)
+#else
+#define dsp_lock_init(dev)	do {} while (0)
+#define dsp_lock(dev)		do {} while (0)
+#define dsp_unlock(dev)		do {} while (0)
+#define dsp_is_locked(dev)	0
+#endif
+
 #ifdef CONFIG_X86
 void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool on)
 {
@@ -1101,6 +1114,125 @@ int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
 	return 1; /* OK, it's fine */
 }
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+/*
+ * DSP loading code (e.g. for CA0132)
+ */
+
+/* use the first stream for loading DSP */
+static struct azx_dev *
+azx_get_dsp_loader_dev(struct azx *chip)
+{
+	return &chip->azx_dev[chip->playback_index_offset];
+}
+
+int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
+			 unsigned int byte_size,
+			 struct snd_dma_buffer *bufp)
+{
+	u32 *bdl;
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev;
+	int err;
+
+	azx_dev = azx_get_dsp_loader_dev(chip);
+
+	dsp_lock(azx_dev);
+	spin_lock_irq(&chip->reg_lock);
+	if (azx_dev->running || azx_dev->locked) {
+		spin_unlock_irq(&chip->reg_lock);
+		err = -EBUSY;
+		goto unlock;
+	}
+	azx_dev->prepared = 0;
+	chip->saved_azx_dev = *azx_dev;
+	azx_dev->locked = 1;
+	spin_unlock_irq(&chip->reg_lock);
+
+	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
+				  chip->card->dev,
+				  byte_size, bufp);
+	if (err < 0)
+		goto err_alloc;
+
+	mark_pages_wc(chip, bufp, true);
+	azx_dev->bufsize = byte_size;
+	azx_dev->period_bytes = byte_size;
+	azx_dev->format_val = format;
+
+	azx_stream_reset(chip, azx_dev);
+
+	/* reset BDL address */
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+
+	azx_dev->frags = 0;
+	bdl = (u32 *)azx_dev->bdl.area;
+	err = setup_bdle(chip, bufp, azx_dev, &bdl, 0, byte_size, 0);
+	if (err < 0)
+		goto error;
+
+	azx_setup_controller(chip, azx_dev);
+	dsp_unlock(azx_dev);
+	return azx_dev->stream_tag;
+
+ error:
+	mark_pages_wc(chip, bufp, false);
+	snd_dma_free_pages(bufp);
+ err_alloc:
+	spin_lock_irq(&chip->reg_lock);
+	if (azx_dev->opened)
+		*azx_dev = chip->saved_azx_dev;
+	azx_dev->locked = 0;
+	spin_unlock_irq(&chip->reg_lock);
+ unlock:
+	dsp_unlock(azx_dev);
+	return err;
+}
+
+void azx_load_dsp_trigger(struct hda_bus *bus, bool start)
+{
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
+
+	if (start)
+		azx_stream_start(chip, azx_dev);
+	else
+		azx_stream_stop(chip, azx_dev);
+	azx_dev->running = start;
+}
+
+void azx_load_dsp_cleanup(struct hda_bus *bus,
+			  struct snd_dma_buffer *dmab)
+{
+	struct azx *chip = bus->private_data;
+	struct azx_dev *azx_dev = azx_get_dsp_loader_dev(chip);
+
+	if (!dmab->area || !azx_dev->locked)
+		return;
+
+	dsp_lock(azx_dev);
+	/* reset BDL address */
+	azx_sd_writel(chip, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(chip, azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(chip, azx_dev, SD_CTL, 0);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+
+	mark_pages_wc(chip, dmab, false);
+	snd_dma_free_pages(dmab);
+	dmab->area = NULL;
+
+	spin_lock_irq(&chip->reg_lock);
+	if (azx_dev->opened)
+		*azx_dev = chip->saved_azx_dev;
+	azx_dev->locked = 0;
+	spin_unlock_irq(&chip->reg_lock);
+	dsp_unlock(azx_dev);
+}
+#endif /* CONFIG_SND_HDA_DSP_LOADER */
+
 int azx_alloc_stream_pages(struct azx *chip)
 {
 	int i, err;
diff --git a/sound/pci/hda/hda_shared.h b/sound/pci/hda/hda_shared.h
index ff1eeae..0c0ba24 100644
--- a/sound/pci/hda/hda_shared.h
+++ b/sound/pci/hda/hda_shared.h
@@ -42,17 +42,13 @@ static inline struct azx_dev *get_azx_dev(struct snd_pcm_substream *substream)
 /* Stream control. */
 void azx_stream_stop(struct azx *chip, struct azx_dev *azx_dev);
 
-/* DSP lock helpers */
 #ifdef CONFIG_SND_HDA_DSP_LOADER
-#define dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
-#define dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
-#define dsp_unlock(dev)		mutex_unlock(&(dev)->dsp_mutex)
-#define dsp_is_locked(dev)	((dev)->locked)
-#else
-#define dsp_lock_init(dev)	do {} while (0)
-#define dsp_lock(dev)		do {} while (0)
-#define dsp_unlock(dev)		do {} while (0)
-#define dsp_is_locked(dev)	0
+int azx_load_dsp_prepare(struct hda_bus *bus, unsigned int format,
+			 unsigned int byte_size,
+			 struct snd_dma_buffer *bufp);
+void azx_load_dsp_trigger(struct hda_bus *bus, bool start);
+void azx_load_dsp_cleanup(struct hda_bus *bus,
+			  struct snd_dma_buffer *dmab);
 #endif
 
 /* Allocation functions. */
-- 
1.8.1.3.605.g02339dd
