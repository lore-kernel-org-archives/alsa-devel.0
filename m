From: Markus Korber <korbse@gmx.at>
Subject: Re: Audio DMA buffer layout
Date: Thu, 10 May 2007 12:52:20 +0200
Message-ID: <6z8xbxj6hn.fsf@odpc25.int.ondemand.co.at>
References: <6zbqgvsfj0.fsf@odpc25.int.ondemand.co.at>
	<s5hvef25eai.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 0B7A224365
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 12:52:22 +0200 (CEST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Markus Korber <korbse@gmx.at>
List-Id: alsa-devel@alsa-project.org

Thus spake Takashi Iwai:

First of all, thanks for your answer.  However, 

> At Tue, 08 May 2007 13:47:47 +0200,
> Markus Korber wrote:
>>
>>
>>      IRQ1 +----------------+
>>           | page_3 (right) |\
>>           +----------------+ > double buffer 1
>>           | page_2 (left)  |/
>>      IRQ0 +----------------+
>>           | page_1 (right) |\
>>           +----------------+ > double buffer 0
>>           | page_0 (left)  |/
>>           +----------------+
>
> If I understand correctly, the samples for a channel (e.g. left) is
> practically split to two regions, page 0 and page 2 in the above?

Correct.

> If yes, this h/w design is hard to implement mmap mode
> straightforwardly because the alsa-lib (and apps) assume "linear"
> buffers.  For normal read/write without mmap, this shouldn't be that
> hard as you guess, though.

Are there any drawbacks if I use the R/W mode without mmap, regarding
applications (mplayer), dmix, etc.?

Furthermore, in mmap mode, I think I could use an intermediate buffer
(with the layout as above), where I copy the data from the (linear)
mmap'd buffer to, could I?  Maybe using helpers from struct
pcm-indirect.h?  But this is not very beautiful.

> A workaround would be to use SG-buffer (if possible).  The constraint
> is thta both double buffers above have to be aligned in PAGE_SIZE
> (depending on architecture, 4KB mostly).

It's a custom chip with an ARM core and an AMBA-AHB bus.  PAGE_SIZE
alignment wouldn't be a problem, although then buffer_size would be
fixed to multiples of PAGE_SIZE, i guess?

I'm not quite sure how to implement this:

chip_pcm_new
        - snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
                snd_dma_continuous_data(GFP_KERNEL), PAGE_SIZE, PAGE_SIZE)

chip_hw_params
        - snd_pcm_lib_malloc_pages(substream,
                                   params_buffer_bytes(hw_params))
        - map sg-pages with snd_pcm_sgbuf_get_addr()
        
        Why/How?

I mean, my hardware DMA layout is fixed (apart from the double buffer
page sizes, which should be a multiple of PAGE_SIZE).  
So do I have to call snd_pcm_lib_malloc_pages() and/or do I need to call
dma_map_sg() with a scatterlist?  Or how do I tell ALSA about my DMA
layout?  And how is the application informed about this?

> For implementing a SG buffer, you can use either mmap or page pcm_ops.
> The mmap is to do the whole mmap operation, so you can do all what
> you'd like.

My understanding is, that the application mmap's my allocated buffer
(currently allocated with dma_alloc_writecombine) and the ALSA library
tells it, where it is allowed to put its data.  (ALSA gets this info
through the pointer() callback and calls to snd_pcm_period_elapsed.)
Thus, this mmap() callback is only called once in normal mmap mode.

Now, if I would use a SG approach, how would I handle this mmap
operation in my callback?  I guess, I have to provide similar
functionality as in dma_mmap() but with 2 different base addresses?

> The page is a callback used by the default ALSA mmap handler and you
> can return the page pointer corresponding to the given buffer offset.

This approach looks easier to me.  Am I right, that here I would just
call snd_pcm_sgbuf_ops_page() from my page() callback handler?  What
else do I need to do in this case to let the application know which
buffer it should fill?

Regards,
Markus Korber
