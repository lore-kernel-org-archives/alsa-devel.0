From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 0/3] ASoC: Move pcm writecombine dma buffer allocation
 to core
Date: Fri, 29 Jun 2012 21:19:29 +0530
Message-ID: <4FEDCE89.8020804@nvidia.com>
References: <1340965398-20872-1-git-send-email-ldewangan@nvidia.com>	<s5h7guqxqnd.wl%tiwai@suse.de>	<4FEDC3F8.8000501@nvidia.com> <s5hd34iw3al.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd34iw3al.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "lrg@ti.com" <lrg@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lars@metafoo.de" <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, "perex@perex.cz" <perex@perex.cz>, "clemens@ladisch.de" <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Friday 29 June 2012 08:52 PM, Takashi Iwai wrote:
> At Fri, 29 Jun 2012 20:34:24 +0530,
> Laxman Dewangan wrote:
>> Hi Takashi,
>> Thanks for sample code. It helps lot.
>>
>> int snd_pcm_lib_malloc_pages(struct snd_pcm_substream *substream, size_t
>> size)
>> {
>>           struct snd_pcm_runtime *runtime;
>>           struct snd_dma_buffer *dmab = NULL;
>>
>>           if (PCM_RUNTIME_CHECK(substream))
>>                   return -EINVAL;
>>
>>           if (snd_BUG_ON(substream->dma_buffer.dev.type ==
>>                          SNDRV_DMA_TYPE_UNKNOWN))
>>                   return -EINVAL;
>>
>>           runtime = substream->runtime;
>>
>>           if (runtime->dma_buffer_p) {
>> ---------------Kernel crash at this point ----------
>>
>> So I used the snd_dma_alloc_pages() from the driver to allocate WC memory.
> snd_pcm_lib_malloc_pages() should be called only from hw_params.
> Prior to that, you need to set up the dam_buffer type by calling
> snd_pcm_lib_preallocate_pages() or
> snd_pcm_lib_preallocate_pages_for_all() at the time to create a PCM
> instance.  The size can be 0 if not necessary to allocate there but
> later on demand.

It worked well. Cool implementation.

I will send the patch of memalloc and for Tegra actually using this feature.

Thanks for suggestion and help.


Laxman
