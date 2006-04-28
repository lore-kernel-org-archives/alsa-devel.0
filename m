From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: Re: bad page when freeing preallocated pages
Date: Fri, 28 Apr 2006 14:42:05 +0200
Message-ID: <44520D9D.6000700@norway.atmel.com>
References: <444F2FA6.7010305@atmel.com>	<s5hslo049f5.wl%tiwai@suse.de>	<4450622C.80802@norway.atmel.com>	<s5hr73jxpu6.wl%tiwai@suse.de>	<4450A4AF.1000501@norway.atmel.com> <s5hlktrxohr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlktrxohr.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 27 Apr 2006 13:02:07 +0200,
> Hans-Christian Egtvedt wrote:
>> Takashi Iwai wrote:
>>> At Thu, 27 Apr 2006 08:18:20 +0200,
>>> Hans-Christian Egtvedt wrote:
>>>> Takashi Iwai wrote:
>>>>> At Wed, 26 Apr 2006 10:30:30 +0200,
>>>>> Hans-Christian Egtvedt wrote:

<snipp>

> Removing snd_pcm_lib_preallocate_pages_for_all() might be a tentative
> option.  Instead of snd_pcm_lib_malloc_pages() and *_free_pages(),
> call dma_alloc_coherent() and dma_free_coherent() in hw_params and
> hw_free PCM callbacks.  Return -ENOMEM if the alloc fails.
> 
> One thing to care in this case is that hw_params callback can be
> called multiple times at each open.  You should check the buffer size
> at each time, and re-allocate if a buffer was already allocated but
> the size changed.

Thank you, using this workaround solved my problem for now.

I have rewritten my _hw_params callback (pretty much what the library does):
+#if AT73C213_WORKAROUND_FOR_PREALLOC
+	int pg;
+	size_t size = params_buffer_bytes(hw_params);
+	struct snd_pcm_runtime *runtime;
+	struct snd_dma_buffer *dmab = NULL;
+
+	substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV;
+	snd_assert(substream != NULL, return -EINVAL);
+	runtime = substream->runtime;
+	snd_assert(runtime != NULL, return -EINVAL);
+
+	/* check if buffer is already allocated */
+	if (runtime->dma_buffer_p) {
+		size_t size_previouse;
+		int pg_previouse;
+
+		/* new buffer is smaler than previouse allocated buffer */
+		if (runtime->dma_buffer_p->bytes >= size) {
+			runtime->dma_bytes = size;
+			return 0; /* don't change buffer size */
+		}
+
+		size_previouse = runtime->dma_buffer_p->bytes;
+		pg_previouse = get_order(size_previouse);
+
+		dma_free_coherent(runtime->dma_buffer_p->dev.dev,
+				PAGE_SIZE << pg_previouse,
+			       	runtime->dma_buffer_p->area,
+				runtime->dma_buffer_p->addr);
+
+		kfree(runtime->dma_buffer_p);
+	}
+
+	dmab = kzalloc(sizeof(*dmab), GFP_KERNEL);
+	if (!dmab)
+		return -ENOMEM;
+	dmab->dev = substream->dma_buffer.dev;
+
+	pg = get_order(size);
+
+	dmab->area = dma_alloc_coherent(
+			substream->dma_buffer.dev.dev,
+		       	PAGE_SIZE << pg,
+		       	(dma_addr_t *)&dmab->addr,
+		       	GFP_KERNEL);
+
+	if (!dmab->area) {
+		kfree(dmab);
+		return -ENOMEM;
+	}
+
+	dmab->bytes = size;
+	snd_pcm_set_runtime_buffer(substream, dmab);
+	runtime->dma_bytes = size;
+	return 1;
+#else
 	return snd_pcm_lib_malloc_pages(substream,
 					params_buffer_bytes(hw_params));
+#endif


And hw_free callback:
+#if AT73C213_WORKAROUND_FOR_PREALLOC
+	int pg;
+	struct snd_pcm_runtime *runtime;
+	struct snd_dma_buffer *dmab = NULL;
+
+	snd_assert(substream != NULL, return -EINVAL);
+	runtime = substream->runtime;
+	snd_assert(runtime != NULL, return -EINVAL);
+	dmab = runtime->dma_buffer_p;
+
+	if (!dmab->area)
+		return 0;
+
+	pg = get_order(dmab->bytes);
+	dma_free_coherent(dmab->dev.dev, PAGE_SIZE << pg, dmab->area, dmab->addr);
+	kfree(runtime->dma_buffer_p);
+	snd_pcm_set_runtime_buffer(substream, NULL);
+	return 0;
+#else
 	return snd_pcm_lib_free_pages(substream);
+#endif


> Another possile buggy point is the mmap support in pcm_native.c.
> It uses virt_to_page() in nopage vma op, and it's known that this
> doesn't work on some architectures.  Try to not to set
> SNDRV_PCM_INFO_MMAP bit in snd_pcm_hardware.info bitflags to avoid
> mmap.

I've already tried this setting, and it didn't effect the result.

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
