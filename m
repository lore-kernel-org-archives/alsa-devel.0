From: Raymond <rayau@netvigator.com>
Subject: Re: alsa dma transfer
Date: Tue, 05 Jul 2005 23:58:28 +0800
Message-ID: <42CAAE24.9000503@netvigator.com>
References: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com>	<s5hd5q57bv5.wl%tiwai@suse.de>	<42C29512.7020205@netvigator.com>	<s5hvf3x5lj2.wl%tiwai@suse.de>	<42CA7C89.90005@netvigator.com> <s5hzmt1e6r9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hzmt1e6r9.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 05 Jul 2005 20:26:49 +0800,
> Raymond wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Wed, 29 Jun 2005 20:33:22 +0800,
>>>Raymond wrote:
>>>
>>>
>>>
>>>>The device hw:0 allow sending 16 mono PCM samples ( change pitch by SRC 
>>>>and panning by hardware mixer, no reverb and chrous effect) to AC97 codec
>>>>
>>>>How to ensure each sound font samples loaded in memory aligned at 4K
>>>>boundary ?
>>>
>>>
>>>Depends.  The emu10k1 doesn't align to 4k boundary but just
>>>split to different pages since emu10k1 has its own TLB.
>>>
>>
>>In au88x0.c
>>
>>	chip->max_mem_size=(16*1024*1024);
>>	chip->memhdr = snd_util_memhdr_new(chip->max_mem_size);
>>	if (chip->memhdr == NULL) {
>>		printk(KERN_ERR "snd_util_memhdr_new error\n");
>>	}
>>	chip->mem_size=chip->max_mem_size;
>>         printk(KERN_INFO "%d Bytes wavetable\n",chip->max_mem_size);
>>
>>What is the reason/advantage of using util_mem.c ?
>>
>>It is correct to use snd_util_mem_alloc() to allocate memory for sample 
>>in snd_vortex_sample_new() ?
> 
> 
> snd_util_mem_*() are helper functions to manage the memory blocks
> _virtually_.  It doesn't allocate any memory block by itself but just
> allocates a metadata for the memory block.  That is, it doesn't matter
> whether the real memory block is stored as SG-buffer or not.  util_mem
> handles only virtually linear buffer.
> 
> 
> 
>>Why get seg fault in __snd_util_memblk_new() ?
> 
> 
> Wrong code ;)  Invalid handler pointer is passed?
> 
> 

It's quite difficult to trace those callback functions.

Since WT on the au8820/au8830 chip and not on the other chip on the
sound card.

Is it feasible to replace most of the callback functions by direct call
if the code is with in module au88x0

   if ((err = snd_device_new(card, SNDRV_DEV_SEQUENCER, wt, &ops)) < 0) {
         return err;
     }

instead of a separate module au88x0-synth

snd_seq_device_new(card,1,"au88x0-synth",sizeof(snd_vortex_synth_arg_t),
&wt)




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
