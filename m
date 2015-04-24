From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/21] ALSA: hda - Add DSP loader to core
	library code
Date: Fri, 24 Apr 2015 14:38:35 +0200
Message-ID: <1429879133-32293-4-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D268260599
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 56D42ABBC
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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

Copied from the legacy driver code, no transition done yet.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h |  46 ++++++++++++++++++++
 sound/hda/Kconfig       |   3 ++
 sound/hda/hdac_stream.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/Kconfig   |   3 --
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 9349ccf15a36..69f27bc49eb4 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -187,6 +187,11 @@ struct hdac_io_ops {
 	u16 (*reg_readw)(u16 __iomem *addr);
 	void (*reg_writeb)(u8 value, u8 __iomem *addr);
 	u8 (*reg_readb)(u8 __iomem *addr);
+	/* Allocation ops */
+	int (*dma_alloc_pages)(struct hdac_bus *bus, int type, size_t size,
+			       struct snd_dma_buffer *buf);
+	void (*dma_free_pages)(struct hdac_bus *bus,
+			       struct snd_dma_buffer *buf);
 };
 
 #define HDA_UNSOL_QUEUE_SIZE	64
@@ -374,6 +379,7 @@ struct hdac_stream {
 	bool opened:1;
 	bool running:1;
 	bool no_period_wakeup:1;
+	bool locked:1;
 
 	/* timestamp */
 	unsigned long start_wallclk;	/* start + minimum wallclk */
@@ -383,6 +389,10 @@ struct hdac_stream {
 	int delay_negative_threshold;
 
 	struct list_head list;
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+	/* DSP access mutex */
+	struct mutex dsp_mutex;
+#endif
 };
 
 void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
@@ -440,6 +450,42 @@ void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 			       (snd_hdac_stream_readb(dev, reg) & \
 				~(mask)) | (val))
 
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+/* DSP lock helpers */
+#define snd_hdac_dsp_lock_init(dev)	mutex_init(&(dev)->dsp_mutex)
+#define snd_hdac_dsp_lock(dev)		mutex_lock(&(dev)->dsp_mutex)
+#define snd_hdac_dsp_unlock(dev)	mutex_unlock(&(dev)->dsp_mutex)
+#define snd_hdac_stream_is_locked(dev)	((dev)->locked)
+/* DSP loader helpers */
+int snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
+			 unsigned int byte_size, struct snd_dma_buffer *bufp);
+void snd_hdac_dsp_trigger(struct hdac_stream *azx_dev, bool start);
+void snd_hdac_dsp_cleanup(struct hdac_stream *azx_dev,
+			  struct snd_dma_buffer *dmab);
+#else /* CONFIG_SND_HDA_DSP_LOADER */
+#define snd_hdac_dsp_lock_init(dev)	do {} while (0)
+#define snd_hdac_dsp_lock(dev)		do {} while (0)
+#define snd_hdac_dsp_unlock(dev)	do {} while (0)
+#define snd_hdac_stream_is_locked(dev)	0
+
+static inline int
+snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
+		     unsigned int byte_size, struct snd_dma_buffer *bufp)
+{
+	return 0;
+}
+
+static inline void snd_hdac_dsp_trigger(struct hdac_stream *azx_dev, bool start)
+{
+}
+
+static inline void snd_hdac_dsp_cleanup(struct hdac_stream *azx_dev,
+					struct snd_dma_buffer *dmab)
+{
+}
+#endif /* CONFIG_SND_HDA_DSP_LOADER */
+
+
 /*
  * generic array helpers
  */
diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 001c6588a5ff..7a17fca4f627 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -1,3 +1,6 @@
 config SND_HDA_CORE
 	tristate
 	select REGMAP
+
+config SND_HDA_DSP_LOADER
+	bool
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index b513a15c777f..7f6b845d90eb 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -33,6 +33,7 @@ void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
 	azx_dev->index = idx;
 	azx_dev->direction = direction;
 	azx_dev->stream_tag = tag;
+	snd_hdac_dsp_lock_init(azx_dev);
 	list_add_tail(&azx_dev->list, &bus->stream_list);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_init);
@@ -534,3 +535,115 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_sync);
+
+#ifdef CONFIG_SND_HDA_DSP_LOADER
+/**
+ * snd_hdac_dsp_prepare - prepare for DSP loading
+ * @azx_dev: HD-audio core stream used for DSP loading
+ * @format: HD-audio stream format
+ * @byte_size: data chunk byte size
+ * @bufp: allocated buffer
+ *
+ * Allocate the buffer for the given size and set up the given stream for
+ * DSP loading.  Returns the stream tag (>= 0), or a negative error code.
+ */
+int snd_hdac_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
+			 unsigned int byte_size, struct snd_dma_buffer *bufp)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	u32 *bdl;
+	int err;
+
+	snd_hdac_dsp_lock(azx_dev);
+	spin_lock_irq(&bus->reg_lock);
+	if (azx_dev->running || azx_dev->locked) {
+		spin_unlock_irq(&bus->reg_lock);
+		err = -EBUSY;
+		goto unlock;
+	}
+	azx_dev->locked = true;
+	spin_unlock_irq(&bus->reg_lock);
+
+	err = bus->io_ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV_SG,
+					   byte_size, bufp);
+	if (err < 0)
+		goto err_alloc;
+
+	azx_dev->bufsize = byte_size;
+	azx_dev->period_bytes = byte_size;
+	azx_dev->format_val = format;
+
+	snd_hdac_stream_reset(azx_dev);
+
+	/* reset BDL address */
+	snd_hdac_stream_writel(azx_dev, SD_BDLPL, 0);
+	snd_hdac_stream_writel(azx_dev, SD_BDLPU, 0);
+
+	azx_dev->frags = 0;
+	bdl = (u32 *)azx_dev->bdl.area;
+	err = setup_bdle(bus, bufp, azx_dev, &bdl, 0, byte_size, 0);
+	if (err < 0)
+		goto error;
+
+	snd_hdac_stream_setup(azx_dev);
+	snd_hdac_dsp_unlock(azx_dev);
+	return azx_dev->stream_tag;
+
+ error:
+	bus->io_ops->dma_free_pages(bus, bufp);
+ err_alloc:
+	spin_lock_irq(&bus->reg_lock);
+	azx_dev->locked = false;
+	spin_unlock_irq(&bus->reg_lock);
+ unlock:
+	snd_hdac_dsp_unlock(azx_dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_dsp_prepare);
+
+/**
+ * snd_hdac_dsp_trigger - start / stop DSP loading
+ * @azx_dev: HD-audio core stream used for DSP loading
+ * @start: trigger start or stop
+ */
+void snd_hdac_dsp_trigger(struct hdac_stream *azx_dev, bool start)
+{
+	if (start)
+		snd_hdac_stream_start(azx_dev, true);
+	else
+		snd_hdac_stream_stop(azx_dev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_dsp_trigger);
+
+/**
+ * snd_hdac_dsp_cleanup - clean up the stream from DSP loading to normal
+ * @azx_dev: HD-audio core stream used for DSP loading
+ * @dmab: buffer used by DSP loading
+ */
+void snd_hdac_dsp_cleanup(struct hdac_stream *azx_dev,
+			  struct snd_dma_buffer *dmab)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	if (!dmab->area || !azx_dev->locked)
+		return;
+
+	snd_hdac_dsp_lock(azx_dev);
+	/* reset BDL address */
+	snd_hdac_stream_writel(azx_dev, SD_BDLPL, 0);
+	snd_hdac_stream_writel(azx_dev, SD_BDLPU, 0);
+	snd_hdac_stream_writel(azx_dev, SD_CTL, 0);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+
+	bus->io_ops->dma_free_pages(bus, dmab);
+	dmab->area = NULL;
+
+	spin_lock_irq(&bus->reg_lock);
+	azx_dev->locked = false;
+	spin_unlock_irq(&bus->reg_lock);
+	snd_hdac_dsp_unlock(azx_dev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_dsp_cleanup);
+#endif /* CONFIG_SND_HDA_DSP_LOADER */
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index a5ed1c181784..47aa7b8b7519 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -38,9 +38,6 @@ config SND_HDA_TEGRA
 
 if SND_HDA
 
-config SND_HDA_DSP_LOADER
-	bool
-
 config SND_HDA_PREALLOC_SIZE
 	int "Pre-allocated buffer size for HD-audio driver"
 	range 0 32768
-- 
2.3.5
