From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 5/5] ALSA: hda - add the DSP loader code
Date: Wed,  1 Apr 2015 17:01:02 +0530
Message-ID: <1427887862-29054-6-git-send-email-vinod.koul@intel.com>
References: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7D82652AE
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:35:42 +0200 (CEST)
In-Reply-To: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

This will be used by SKL controller

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |   15 ++++++++
 sound/hda/hdac_stream.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index df4033fc864d..9aeede3c8ea1 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -153,6 +153,13 @@ struct hdac_bus_ops {
 	u16 (*reg_readw)(u16 __iomem *addr);
 	void (*reg_writeb)(u8 value, u8 __iomem *addr);
 	u8 (*reg_readb)(u8 __iomem *addr);
+
+	/* Allocation ops */
+	int (*dma_alloc_pages)(struct hdac_bus *bus,
+			       int type,
+			       size_t size,
+			       struct snd_dma_buffer *buf);
+	void (*dma_free_pages)(struct hdac_bus *bus, struct snd_dma_buffer *buf);
 };
 
 #define HDA_UNSOL_QUEUE_SIZE	64
@@ -330,6 +337,14 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 			  unsigned int streams);
 void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
 				      unsigned int streams);
+/*DSP loader functions */
+int snd_hdac_load_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp);
+
+void snd_hdac_load_dsp_trigger(struct hdac_stream *azx_dev, bool start);
+void snd_hdac_load_dsp_cleanup(struct hdac_stream *azx_dev,
+				 struct snd_dma_buffer *dmab);
 
 /*
  * helpers to read the stream position
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 541648c84bd7..394fd15de420 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -471,3 +471,95 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_stream_sync);
+
+int snd_hdac_load_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
+				unsigned int byte_size,
+				struct snd_dma_buffer *bufp)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+	u32 *bdl;
+	int err;
+
+	dsp_lock(azx_dev);
+	spin_lock_irq(&bus->reg_lock);
+	if (azx_dev->running || azx_dev->locked) {
+		spin_unlock_irq(&bus->reg_lock);
+		err = -EBUSY;
+		goto unlock;
+	}
+	azx_dev->locked = 1;
+	spin_unlock_irq(&bus->reg_lock);
+
+	err = bus->ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV_SG,
+					 byte_size, bufp);
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
+	azx_sd_writel(bus, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(bus, azx_dev, SD_BDLPU, 0);
+
+	azx_dev->frags = 0;
+	bdl = (u32 *)azx_dev->bdl.area;
+	err = setup_bdle(bus, bufp, azx_dev, &bdl, 0, byte_size, 0);
+	if (err < 0)
+		goto error;
+
+	snd_hdac_stream_setup(azx_dev);
+	dsp_unlock(azx_dev);
+	return azx_dev->stream_tag;
+
+ error:
+	bus->ops->dma_free_pages(bus, bufp);
+ err_alloc:
+	spin_lock_irq(&bus->reg_lock);
+	azx_dev->locked = 0;
+	spin_unlock_irq(&bus->reg_lock);
+ unlock:
+	dsp_unlock(azx_dev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_load_dsp_prepare);
+
+void snd_hdac_load_dsp_trigger(struct hdac_stream *azx_dev, bool start)
+{
+	if (start)
+		snd_hdac_stream_start(azx_dev, true);
+	else
+		snd_hdac_stream_stop(azx_dev);
+	azx_dev->running = start;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_load_dsp_trigger);
+
+void snd_hdac_load_dsp_cleanup(struct hdac_stream *azx_dev,
+				 struct snd_dma_buffer *dmab)
+{
+	struct hdac_bus *bus = azx_dev->bus;
+
+	if (!dmab->area || !azx_dev->locked)
+		return;
+
+	dsp_lock(azx_dev);
+	/* reset BDL address */
+	azx_sd_writel(bus, azx_dev, SD_BDLPL, 0);
+	azx_sd_writel(bus, azx_dev, SD_BDLPU, 0);
+	azx_sd_writel(bus, azx_dev, SD_CTL, 0);
+	azx_dev->bufsize = 0;
+	azx_dev->period_bytes = 0;
+	azx_dev->format_val = 0;
+
+	bus->ops->dma_free_pages(bus, dmab);
+	dmab->area = NULL;
+
+	spin_lock_irq(&bus->reg_lock);
+	azx_dev->locked = 0;
+	spin_unlock_irq(&bus->reg_lock);
+	dsp_unlock(azx_dev);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_load_dsp_cleanup);
-- 
1.7.9.5
