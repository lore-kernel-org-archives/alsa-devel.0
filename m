From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [RFC 06/11] ALSA: hda - moved alloc/free stream pages
	function to controller library
Date: Sun, 12 Apr 2015 18:06:13 +0530
Message-ID: <1428842178-7105-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C478B260591
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 15:06:00 +0200 (CEST)
In-Reply-To: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Moved azx_alloc_stream_pages and azx_free_stream_pages
to controller library.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h     |  3 +++
 sound/hda/hdac_controller.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 4eebc31..5fc6d81 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -294,6 +294,9 @@ void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
 				    void (*ack)(struct hdac_bus *,
 						struct hdac_stream *));
 
+int snd_hdac_bus_alloc_stream_pages(struct hdac_bus *bus);
+void snd_hdac_bus_free_stream_pages(struct hdac_bus *bus);
+
 /*
  * HD-audio stream
  */
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 23aec0e..4d4e0d6 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -401,3 +401,47 @@ void snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_handle_stream_irq);
+
+int snd_hdac_bus_alloc_stream_pages(struct hdac_bus *bus)
+{
+	struct hdac_stream *hstream;
+	int num_streams = 0;
+	int err;
+
+	list_for_each_entry(hstream, &bus->stream_list, list) {
+		dsp_lock_init(&hstream);
+		/* allocate memory for the BDL for each stream */
+		err = bus->ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+						 BDL_SIZE,
+						 &hstream->bdl);
+		num_streams++;
+		if (err < 0)
+			return -ENOMEM;
+	}
+	/* allocate memory for the position buffer */
+	err = bus->ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+					 num_streams * 8, &bus->posbuf);
+	if (err < 0)
+		return -ENOMEM;
+
+	/* single page (at least 4096 bytes) must suffice for both ringbuffes */
+	return bus->ops->dma_alloc_pages(bus, SNDRV_DMA_TYPE_DEV,
+						PAGE_SIZE, &bus->rb);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_alloc_stream_pages);
+
+void snd_hdac_bus_free_stream_pages(struct hdac_bus *bus)
+{
+	struct hdac_stream *hstream;
+
+	list_for_each_entry(hstream, &bus->stream_list, list) {
+		if (hstream->bdl.area)
+				bus->ops->dma_free_pages(
+					bus, &hstream->bdl);
+	}
+	if (bus->rb.area)
+		bus->ops->dma_free_pages(bus, &bus->rb);
+	if (bus->posbuf.area)
+		bus->ops->dma_free_pages(bus, &bus->posbuf);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_free_stream_pages);
-- 
1.9.0
