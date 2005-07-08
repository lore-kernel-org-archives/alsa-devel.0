From: Raymond <rayau@netvigator.com>
Subject: Re: alsa dma transfer
Date: Sat, 09 Jul 2005 00:24:38 +0800
Message-ID: <42CEA8C6.4060606@netvigator.com>
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
>>>Depends.  The emu10k1 doesn't align to 4k boundary but just
>>>split to different pages since emu10k1 has its own TLB.
>>>
>>

#define get_aligned_page(offset)	((offset) >> PAGE_SHIFT)
#define aligned_page_offset(page)	((page) << PAGE_SHIFT)


The au88x0 driver use Scatter-Gather

How to define set_ptb_entry(vortex,page,addr) for au88x0 ?

> 
> 
> snd_util_mem_*() are helper functions to manage the memory blocks
> _virtually_.  It doesn't allocate any memory block by itself but just
> allocates a metadata for the memory block.  That is, it doesn't matter
> whether the real memory block is stored as SG-buffer or not.  util_mem
> handles only virtually linear buffer.
> 
> 

Do the driver allocated all the memory block when the driver is loaded
or the soundfonts is loaded ? (kcalloc)

What is the purpose of allocating snd_dma_buffer in synth_alloc_pages()  ?

Is the use of set_silent_ptb()  hardware specific ?





-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
