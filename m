From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: [PATCH] 3/3 Implement generic device DMA mapping support
Date: Sun, 29 Feb 2004 22:43:21 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229224321.E17862@flint.arm.linux.org.uk>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <20040229224214.D17862@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040229224214.D17862@flint.arm.linux.org.uk>; from rmk+alsa@arm.linux.org.uk on Sun, Feb 29, 2004 at 10:42:14PM +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is the first shot at this - I've tested it on ARM, covering both
ISA ALSA devices on a PCI machine, and driver model devices on a non-
PCI, non-ISA machine.  However, it needs more testing.  Can people
on alsa-devel please test these patches.

Convert remaining PCI-using functions to use the driver model functions.

diff -urpN orig/sound/core/memalloc.c linux/sound/core/memalloc.c
--- orig/sound/core/memalloc.c	Sun Feb 29 19:37:15 2004
+++ linux/sound/core/memalloc.c	Sun Feb 29 19:39:29 2004
@@ -146,11 +146,6 @@ static int compare_device(const struct s
 	case SNDRV_DMA_TYPE_ISA:
 #endif
 		return a->dev.flags == b->dev.flags;
-#ifdef CONFIG_PCI
-	case SNDRV_DMA_TYPE_PCI:
-	case SNDRV_DMA_TYPE_PCI_SG:
-		return a->dev.pci == b->dev.pci;
-#endif
 #ifdef CONFIG_SBUS
 	case SNDRV_DMA_TYPE_SBUS:
 		return a->dev.sbus == b->dev.sbus;
@@ -192,14 +187,6 @@ int snd_dma_alloc_pages(const struct snd
 		dmab->area = snd_malloc_isa_pages(size, &dmab->addr);
 		break;
 #endif
-#ifdef CONFIG_PCI
-	case SNDRV_DMA_TYPE_PCI:
-		dmab->area = snd_malloc_pci_pages(dev->dev.pci, size, &dmab->addr);
-		break;
-	case SNDRV_DMA_TYPE_PCI_SG:
-		snd_malloc_sgbuf_pages(&dev->dev.pci->dev, size, dmab);
-		break;
-#endif
 #ifdef CONFIG_SBUS
 	case SNDRV_DMA_TYPE_SBUS:
 		dmab->area = snd_malloc_sbus_pages(dev->dev.sbus, size, &dmab->addr);
@@ -242,14 +229,6 @@ void snd_dma_free_pages(const struct snd
 		snd_free_isa_pages(dmab->bytes, dmab->area, dmab->addr);
 		break;
 #endif
-#ifdef CONFIG_PCI
-	case SNDRV_DMA_TYPE_PCI:
-		snd_free_pci_pages(dev->dev.pci, dmab->bytes, dmab->area, dmab->addr);
-		break;
-	case SNDRV_DMA_TYPE_PCI_SG:
-		snd_free_sgbuf_pages(dmab);
-		break;
-#endif
 #ifdef CONFIG_SBUS
 	case SNDRV_DMA_TYPE_SBUS:
 		snd_free_sbus_pages(dev->dev.sbus, dmab->bytes, dmab->area, dmab->addr);
@@ -946,17 +925,6 @@ static int snd_mem_proc_read(char *page,
 		case SNDRV_DMA_TYPE_CONTINUOUS:
 			len += sprintf(page + len, "CONT [%x]", mem->dev.dev.flags);
 			break;
-#ifdef CONFIG_PCI
-		case SNDRV_DMA_TYPE_PCI:
-		case SNDRV_DMA_TYPE_PCI_SG:
-			if (mem->dev.dev.pci) {
-				len += sprintf(page + len, "%s [%04x:%04x]",
-					       mem->dev.type == SNDRV_DMA_TYPE_PCI ? "PCI" : "PCI-SG",
-					       mem->dev.dev.pci->vendor,
-					       mem->dev.dev.pci->device);
-			}
-			break;
-#endif
 #ifdef CONFIG_ISA
 		case SNDRV_DMA_TYPE_ISA:
 			len += sprintf(page + len, "ISA [%x]", mem->dev.dev.flags);
diff -urpN orig/sound/core/pcm_memory.c linux/sound/core/pcm_memory.c
--- orig/sound/core/pcm_memory.c	Sun Feb 29 19:38:37 2004
+++ linux/sound/core/pcm_memory.c	Sun Feb 29 19:33:33 2004
@@ -538,10 +538,8 @@ int snd_pcm_lib_preallocate_pci_pages(st
 				      snd_pcm_substream_t *substream,
 				      size_t size, size_t max)
 {
-	substream->dma_device.type = SNDRV_DMA_TYPE_PCI;
-	substream->dma_device.dev.pci = pci;
-	setup_pcm_id(substream);
-	return snd_pcm_lib_preallocate_pages1(substream, size, max);
+	return snd_pcm_lib_preallocate_dev_pages(pci ? &pci->dev : NULL,
+						 substream, size, max);
 }
 
 /*
@@ -562,14 +560,8 @@ int snd_pcm_lib_preallocate_pci_pages_fo
 					      snd_pcm_t *pcm,
 					      size_t size, size_t max)
 {
-	snd_pcm_substream_t *substream;
-	int stream, err;
-
-	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
-			if ((err = snd_pcm_lib_preallocate_pci_pages(pci, substream, size, max)) < 0)
-				return err;
-	return 0;
+	return snd_pcm_lib_preallocate_dev_pages_for_all(pci ? &pci->dev : NULL,
+							 pcm, size, max);
 }
 
 #endif /* CONFIG_PCI */
@@ -644,10 +636,8 @@ int snd_pcm_lib_preallocate_sg_pages(str
 				     snd_pcm_substream_t *substream,
 				     size_t size, size_t max)
 {
-	substream->dma_device.type = SNDRV_DMA_TYPE_PCI_SG;
-	substream->dma_device.dev.pci = pci;
-	setup_pcm_id(substream);
-	return snd_pcm_lib_preallocate_pages1(substream, size, max);
+	return snd_pcm_lib_preallocate_dev_sg_pages(pci ? &pci->dev : NULL,
+						    substream, size, max);
 }
 
 /*
@@ -668,14 +658,8 @@ int snd_pcm_lib_preallocate_sg_pages_for
 					     snd_pcm_t *pcm,
 					     size_t size, size_t max)
 {
-	snd_pcm_substream_t *substream;
-	int stream, err;
-
-	for (stream = 0; stream < 2; stream++)
-		for (substream = pcm->streams[stream].substream; substream; substream = substream->next)
-			if ((err = snd_pcm_lib_preallocate_sg_pages(pci, substream, size, max)) < 0)
-				return err;
-	return 0;
+	return snd_pcm_lib_preallocate_dev_sg_pages_for_all(pci ? &pci->dev : NULL,
+							    pcm, size, max);
 }
 
 #endif /* CONFIG_PCI */
diff -urpN orig/include/sound/memalloc.h linux/include/sound/memalloc.h
--- orig/include/sound/memalloc.h	Sun Feb 29 19:37:12 2004
+++ linux/include/sound/memalloc.h	Sun Feb 29 19:41:01 2004
@@ -38,7 +38,6 @@ struct snd_dma_device {
 	int type;			/* SNDRV_MEM_TYPE_XXX */
 	union {
 		struct device *dev;	/* generic device */
-		struct pci_dev *pci;	/* for PCI and PCI-SG types */
 		unsigned int flags;	/* GFP_XXX for continous and ISA types */
 #ifdef CONFIG_SBUS
 		struct sbus_dev *sbus;	/* for SBUS type */
@@ -53,9 +52,7 @@ struct snd_dma_device {
 #define SNDRV_DMA_TYPE_UNKNOWN		0	/* not defined */
 #define SNDRV_DMA_TYPE_CONTINUOUS	1	/* continuous no-DMA memory */
 #define SNDRV_DMA_TYPE_ISA		2	/* ISA continuous */
-#define SNDRV_DMA_TYPE_PCI		3	/* PCI continuous */
 #define SNDRV_DMA_TYPE_SBUS		4	/* SBUS continuous */
-#define SNDRV_DMA_TYPE_PCI_SG		5	/* PCI SG-buffer */
 #define SNDRV_DMA_TYPE_DEV		6	/* generic device continuous */
 #define SNDRV_DMA_TYPE_DEV_SG		7	/* generic device SG-buffer */
 
@@ -66,8 +63,8 @@ struct snd_dma_device {
 static inline void snd_dma_device_pci(struct snd_dma_device *dev, struct pci_dev *pci, unsigned int id)
 {
 	memset(dev, 0, sizeof(*dev));
-	dev->type = SNDRV_DMA_TYPE_PCI;
-	dev->dev.pci = pci;
+	dev->type = SNDRV_DMA_TYPE_DEV;
+	dev->dev.dev = &pci->dev;
 	dev->id = id;
 }
 #endif


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
