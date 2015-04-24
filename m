From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/21] ALSA: hda - moved alloc/free stream
	pages function to controller library
Date: Fri, 24 Apr 2015 14:38:36 +0200
Message-ID: <1429879133-32293-5-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 33BCD2605AA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5D867AC58
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

From: Jeeja KP <jeeja.kp@intel.com>

Moved azx_alloc_stream_pages and azx_free_stream_pages
to controller library.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h     |  3 +++
 sound/hda/hdac_controller.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
 sound/hda/hdac_stream.c     |  2 --
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 69f27bc49eb4..59d21848a472 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -314,6 +314,9 @@ void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
 				    void (*ack)(struct hdac_bus *,
 						struct hdac_stream *));
 
+int snd_hdac_bus_alloc_stream_pages(struct hdac_bus *bus);
+void snd_hdac_bus_free_stream_pages(struct hdac_bus *bus);
+
 /*
  * macros for easy use
  */
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index c0069d0b7875..b5a17cb510a0 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -447,3 +447,61 @@ void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_handle_stream_irq);
+
+/**
+ * snd_hdac_bus_alloc_stream_pages - allocate BDL and other buffers
+ * @bus: HD-audio core bus
+ *
+ * Call this after assigning the all streams.
+ * Returns zero for success, or a negative error code.
+ */
+int snd_hdac_bus_alloc_stream_pages(struct hdac_bus *bus)
+{
+	struct hdac_stream *s;
+	int num_streams = 0;
+	int err;
+
+	list_for_each_entry(s, &bus->stream_list, list) {
+		/* allocate memory for the BDL for each stream */
+		err = bus->io_ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+						   BDL_SIZE, &s->bdl);
+		num_streams++;
+		if (err < 0)
+			return -ENOMEM;
+	}
+
+	if (WARN_ON(!num_streams))
+		return -EINVAL;
+	/* allocate memory for the position buffer */
+	err = bus->io_ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+					   num_streams * 8, &bus->posbuf);
+	if (err < 0)
+		return -ENOMEM;
+	list_for_each_entry(s, &bus->stream_list, list)
+		s->posbuf = (__le32 *)(bus->posbuf.area + s->index * 8);
+
+	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
+	return bus->io_ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+					    PAGE_SIZE, &bus->rb);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_alloc_stream_pages);
+
+/**
+ * snd_hdac_bus_free_stream_pages - release BDL and other buffers
+ * @bus: HD-audio core bus
+ */
+void snd_hdac_bus_free_stream_pages(struct hdac_bus *bus)
+{
+	struct hdac_stream *s;
+
+	list_for_each_entry(s, &bus->stream_list, list) {
+		if (s->bdl.area)
+			bus->io_ops->dma_free_pages(bus, &s->bdl);
+	}
+
+	if (bus->rb.area)
+		bus->io_ops->dma_free_pages(bus, &bus->rb);
+	if (bus->posbuf.area)
+		bus->io_ops->dma_free_pages(bus, &bus->posbuf);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_free_stream_pages);
diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index 7f6b845d90eb..8bd67a824b5e 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -24,8 +24,6 @@ void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
 			  int idx, int direction, int tag)
 {
 	azx_dev->bus = bus;
-	if (bus->posbuf.area)
-		azx_dev->posbuf = (__le32 *)(bus->posbuf.area + idx * 8);
 	/* offset: SDI0=0x80, SDI1=0xa0, ... SDO3=0x160 */
 	azx_dev->sd_addr = bus->remap_addr + (0x20 * idx + 0x80);
 	/* int mask: SDI0=0x01, SDI1=0x02, ... SDO3=0x80 */
-- 
2.3.5
