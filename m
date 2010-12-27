From: andi@lisas.de
Subject: [patch 6/6] sound azt3328: improve
	snd_azf3328_codec_setdmaa()
Date: Mon, 27 Dec 2010 21:17:35 +0100
Message-ID: <20101227201735.GG28432@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD0A246FF
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 21:17:35 +0100 (CET)
Content-Disposition: inline; filename=setdmaa
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

ChangeLog:
- add some WARN_ONCE
- add multi-I/O helper (and use helper struct)
- fix off-by-1 DMA length bug
- better variable naming

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: linux-2.6/sound/pci/azt3328.c
===================================================================
--- linux-2.6.orig/sound/pci/azt3328.c	2010-12-27 14:29:21.132851001 -0500
+++ linux-2.6/sound/pci/azt3328.c	2010-12-27 14:29:23.202851001 -0500
@@ -175,6 +175,7 @@
 
 #include <asm/io.h>
 #include <linux/init.h>
+#include <linux/bug.h> /* WARN_ONCE */
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -421,6 +422,21 @@ snd_azf3328_codec_outl(const struct snd_
 	outl(value, codec->io_base + reg);
 }
 
+static inline void
+snd_azf3328_codec_outl_multi(const struct snd_azf3328_codec_data *codec,
+			     unsigned reg, const void *buffer, int count
+)
+{
+	unsigned long addr = codec->io_base + reg;
+	if (count) {
+		const u32 *buf = buffer;
+		do {
+			outl(*buf++, addr);
+			addr += 4;
+		} while (--count);
+	}
+}
+
 static inline u32
 snd_azf3328_codec_inl(const struct snd_azf3328_codec_data *codec, unsigned reg)
 {
@@ -1124,34 +1140,54 @@ snd_azf3328_ctrl_codec_activity(struct s
 static void
 snd_azf3328_codec_setdmaa(struct snd_azf3328_codec_data *codec,
 				unsigned long addr,
-				unsigned int count,
-				unsigned int size
+				unsigned int period_bytes,
+				unsigned int buffer_bytes
 )
 {
 	snd_azf3328_dbgcallenter();
+	WARN_ONCE(period_bytes & 1, "odd period length!?\n");
+	WARN_ONCE(buffer_bytes != 2 * period_bytes,
+		 "missed our input expectations! %u vs. %u\n",
+		 buffer_bytes, period_bytes);
 	if (!codec->running) {
 		/* AZF3328 uses a two buffer pointer DMA transfer approach */
 
-		unsigned long flags, addr_area2;
+		unsigned long flags;
 
 		/* width 32bit (prevent overflow): */
-		u32 count_areas, lengths;
-
-		count_areas = size/2;
-		addr_area2 = addr+count_areas;
-		snd_azf3328_dbgcodec("setdma: buffers %08lx[%u] / %08lx[%u]\n",
-				addr, count_areas, addr_area2, count_areas);
+		u32 area_length;
+		struct codec_setup_io {
+			u32 dma_start_1;
+			u32 dma_start_2;
+			u32 dma_lengths;
+		} __attribute__((packed)) setup_io;
+
+		area_length = buffer_bytes/2;
+
+		setup_io.dma_start_1 = addr;
+		setup_io.dma_start_2 = addr+area_length;
+
+		snd_azf3328_dbgcodec(
+			"setdma: buffers %08x[%u] / %08x[%u], %u, %u\n",
+				setup_io.dma_start_1, area_length,
+				setup_io.dma_start_2, area_length,
+				period_bytes, buffer_bytes);
+
+		/* Hmm, are we really supposed to decrement this by 1??
+		   Most definitely certainly not: configuring full length does
+		   work properly (i.e. likely better), and BTW we
+		   violated possibly differing frame sizes with this...
 
-		count_areas--; /* max. index */
+		area_length--; |* max. index *|
+		*/
 
 		/* build combined I/O buffer length word */
-		lengths = (count_areas << 16) | (count_areas);
+		setup_io.dma_lengths = (area_length << 16) | (area_length);
+
 		spin_lock_irqsave(codec->lock, flags);
-		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_START_1, addr);
-		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_START_2,
-								addr_area2);
-		snd_azf3328_codec_outl(codec, IDX_IO_CODEC_DMA_LENGTHS,
-								lengths);
+		snd_azf3328_codec_outl_multi(
+			codec, IDX_IO_CODEC_DMA_START_1, &setup_io, 3
+		);
 		spin_unlock_irqrestore(codec->lock, flags);
 	}
 	snd_azf3328_dbgcallleave();

-- 
