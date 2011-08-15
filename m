From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: USB Audio questions
Date: Mon, 15 Aug 2011 16:48:31 -0500
Message-ID: <1313444911.3162.19.camel@plb-Dell>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
	<1313432124-22591-2-git-send-email-lars@metafoo.de>
	<4e498227.854fdf0a.0dd4.6281SMTPIN_ADDED@mx.google.com>
	<CACTFLAPU_ErpoQgTVoaOsXd2LM-sjeJq0E6wVN9C1RmYMvb02w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ZbztE7hoKhbAmxZi8/CI"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F8F424396
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 23:48:45 +0200 (CEST)
In-Reply-To: <CACTFLAPU_ErpoQgTVoaOsXd2LM-sjeJq0E6wVN9C1RmYMvb02w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, List <alsa-devel@alsa-project.org>, ALSA@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-ZbztE7hoKhbAmxZi8/CI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Daniel,

> > - Is there any good reason why the max number of packets per urb defaults to
> > 8? This end-ups being the root cause for the large number of interrupts. My
> > headset supports up to 192 bytes/packet, that means 1536 bytes/urb and 125
> > interrupts/s. Using more packets/urb results in a linear decrease of the
> > interrupt rate.
> 
> You cannot use more than 8 subframes per ISO urb, that's what how USB
> is designed. What exactly did you do in you test? Did you increase
> MAX_URBS?

Can you point to a section of the spec where this restriction is
mentioned? Playback works fine with a larger buffer size and less urbs.
If indeed there was such a restriction, then why make does the module
take a parameter to change the max packet number of urb in card.c?

module_param(nrpacks, int, 0644);
MODULE_PARM_DESC(nrpacks, "Max. number of packets per URB.");

To make this work, I increased MAX_PACKS, MAX_QUEUE. See attached
(ugly!) patch. 

> Just to be sure - you're talking about the driver in sound/usb/caiaq,
> right? After a short comparison, I'd say both the caiaq driver and the
> generic driver do more or less the same in regard to the .pointer
> value, as for the output stream, they both increase their internal
> counter when the packet is prepared, shortly before it is submitted to
> the host controller. Increasing the number of URBs. Admittedly, this
> approach is questionable, as a larger number of prepared output
> buffers will actually cause the client believe that more data has
> already been written already. You could try moving the hwptr_done
> increase statement into the retire callback (which is the first place
> we get to know about packets that have been sent to the device)?

To really have a good video synchronization i'd need the ability to
query the number of audio bytes/samples transmitted whenever the video
renderer queries the pipeline clock. That makes A/V sync completely
independent of the sampling rate and the buffer sizes (just like for
HDAudio and most I2S outputs). This information on bytes transmitted is
probably available at a lower level (DMA, etc). If the audio time only
evolves in steps of 8ms, this is a deal-breaker for me. Having a delay
information in terms of ~1ms steps would be enough.

> > - Is there any reason why the driver relies on vmalloc and memcpy? It seems
> > like using physically-contiguous memory would be more efficient, as done in
> > the CAIQ driver? I hacked something to use prealloc_pages/malloc_pages and
> > things seem to work fine.
> 
> Can you show a patch?

Included in the same patch below. I only modified the allocation. It's
ugly as can be, since I don't really prealloc anything. Looks similar to
what is done in your CAIQ code, except that I am a much worse part-time
programmer...
-Pierre


--=-ZbztE7hoKhbAmxZi8/CI
Content-Disposition: attachment; filename="usb-plb.patch"
Content-Type: text/x-patch; name="usb-plb.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 150cb7e..09fb994 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -107,6 +107,7 @@ int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
 #endif
 	return 0;
 }
+EXPORT_SYMBOL(snd_pcm_lib_preallocate_free);
 
 /**
  * snd_pcm_lib_preallocate_free_for_all - release all pre-allocated buffers on the pcm
diff --git a/sound/usb/card.h b/sound/usb/card.h
index ae4251d..18dfa38 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -1,11 +1,13 @@
 #ifndef __USBAUDIO_CARD_H
 #define __USBAUDIO_CARD_H
 
-#define MAX_PACKS	20
+//#define MAX_PACKS	20
+#define MAX_PACKS	40
 #define MAX_PACKS_HS	(MAX_PACKS * 8)	/* in high speed mode */
 #define MAX_URBS	8
 #define SYNC_URBS	4	/* always four urbs for sync */
-#define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
+//#define MAX_QUEUE	24	/* try not to exceed this queue length, in ms */
+#define MAX_QUEUE	48	/* try not to exceed this queue length, in ms */
 
 struct audioformat {
 	struct list_head list;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b8dcbf4..5ca7999 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -328,11 +328,41 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
 	struct audioformat *fmt;
 	unsigned int channels, rate, format;
 	int ret, changed;
-
+#define PLB
+#ifndef PLB
 	ret = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
-	if (ret < 0)
-		return ret;
+#else
+	{
+#define MAX_PREALLOC_SIZE	(32 * 1024 * 1024)
+#define USB_PREALLOC_SIZE	(128 * 1024)
+		int size;
+
+		size = USB_PREALLOC_SIZE;
+		if (size > MAX_PREALLOC_SIZE)
+			size = MAX_PREALLOC_SIZE;
+
+		ret = snd_pcm_lib_preallocate_pages(substream, 
+						SNDRV_DMA_TYPE_CONTINUOUS,
+						snd_dma_continuous_data(GFP_KERNEL),
+						size, MAX_PREALLOC_SIZE);
+		if (ret < 0) {
+			printk(KERN_ERR "plb: could not preallocate data");
+			return ret;
+		} else {
+			printk(KERN_ERR "plb: success preallocate data");
+		}
+		
+		ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
+		
+		if (ret < 0) {
+			printk(KERN_ERR "plb: could not malloc data");
+			return ret;
+		} else {
+			printk(KERN_ERR "plb: success malloc data");
+		}
+	}
+#endif
 
 	format = params_format(hw_params);
 	rate = params_rate(hw_params);
@@ -391,7 +421,30 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock(&subs->stream->chip->shutdown_mutex);
 	snd_usb_release_substream_urbs(subs, 0);
 	mutex_unlock(&subs->stream->chip->shutdown_mutex);
+#ifndef PLB
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
+#else
+	{ 
+		int ret;
+
+		ret = snd_pcm_lib_free_pages(substream);
+		
+		if (ret < 0) {
+			printk(KERN_ERR "plb: could not free data");
+			return ret;
+		} else {
+			printk(KERN_ERR "plb: success free data");
+		}
+
+		ret = snd_pcm_lib_preallocate_free(substream);
+		if (ret < 0) {
+			printk(KERN_ERR "plb: could not free preallocated data");
+			return ret;
+		} else {
+			printk(KERN_ERR "plb: success free prealloc data");
+		}
+	}
+#endif
 }
 
 /*
@@ -424,8 +477,11 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 
 static struct snd_pcm_hardware snd_usb_hardware =
 {
-	.info =			SNDRV_PCM_INFO_MMAP |
-				SNDRV_PCM_INFO_MMAP_VALID |
+	.info =	
+#ifndef PLB		
+	SNDRV_PCM_INFO_MMAP |
+	SNDRV_PCM_INFO_MMAP_VALID |
+#endif
 				SNDRV_PCM_INFO_BATCH |
 				SNDRV_PCM_INFO_INTERLEAVED |
 				SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -853,8 +909,10 @@ static struct snd_pcm_ops snd_usb_playback_ops = {
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_playback_trigger,
 	.pointer =	snd_usb_pcm_pointer,
+#ifndef PLB
 	.page =		snd_pcm_lib_get_vmalloc_page,
 	.mmap =		snd_pcm_lib_mmap_vmalloc,
+#endif
 };
 
 static struct snd_pcm_ops snd_usb_capture_ops = {
@@ -866,8 +924,10 @@ static struct snd_pcm_ops snd_usb_capture_ops = {
 	.prepare =	snd_usb_pcm_prepare,
 	.trigger =	snd_usb_substream_capture_trigger,
 	.pointer =	snd_usb_pcm_pointer,
+#ifndef PLB
 	.page =		snd_pcm_lib_get_vmalloc_page,
 	.mmap =		snd_pcm_lib_mmap_vmalloc,
+#endif
 };
 
 void snd_usb_set_pcm_ops(struct snd_pcm *pcm, int stream)
diff --git a/sound/usb/urb.c b/sound/usb/urb.c
index e184349..a091f57 100644
--- a/sound/usb/urb.c
+++ b/sound/usb/urb.c
@@ -251,7 +251,8 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 		packs_per_ms = 1;
 
 	if (is_playback) {
-		urb_packs = max(chip->nrpacks, 1);
+		//urb_packs = max(chip->nrpacks, 1);
+		urb_packs = 32; //max(chip->nrpacks, 1);
 		urb_packs = min(urb_packs, (unsigned int)MAX_PACKS);
 	} else
 		urb_packs = 1;
@@ -270,6 +271,9 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 			minsize -= minsize >> 3;
 		minsize = max(minsize, 1u);
 		total_packs = (period_bytes + minsize - 1) / minsize;
+
+		printk(KERN_ERR "plb: urb_packs %d period_bytes %d minsize %d, total_packs %d \n", urb_packs, period_bytes, minsize, total_packs);
+
 		/* we need at least two URBs for queueing */
 		if (total_packs < 2) {
 			total_packs = 2;
@@ -284,6 +288,7 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 		total_packs = MAX_URBS * urb_packs;
 	}
 	subs->nurbs = (total_packs + urb_packs - 1) / urb_packs;
+	printk(KERN_ERR "plb: total_packs %d nurbs %d \n", total_packs, subs->nurbs);
 	if (subs->nurbs > MAX_URBS) {
 		/* too much... */
 		subs->nurbs = MAX_URBS;
@@ -305,6 +310,9 @@ int snd_usb_init_substream_urbs(struct snd_usb_substream *subs,
 		u->buffer_size = maxsize * u->packets;
 		if (subs->fmt_type == UAC_FORMAT_TYPE_II)
 			u->packets++; /* for transfer delimiter */
+
+		printk(KERN_ERR "plb: urb %d packets %d buffer_size %d \n", i, u->packets, u->buffer_size);
+
 		u->urb = usb_alloc_urb(u->packets, GFP_KERNEL);
 		if (!u->urb)
 			goto out_of_memory;

--=-ZbztE7hoKhbAmxZi8/CI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-ZbztE7hoKhbAmxZi8/CI--
