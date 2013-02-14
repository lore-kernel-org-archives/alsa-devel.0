From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Allocating DMA buffer for non-PCM
Date: Thu, 14 Feb 2013 18:26:53 +0100
Message-ID: <511D1E5D.30709@drcomp.erfurt.thur.de>
References: <511D18F9.3040906@drcomp.erfurt.thur.de>
 <s5hy5eqstrb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id E2077265353
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 18:26:54 +0100 (CET)
In-Reply-To: <s5hy5eqstrb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/14/2013 06:14 PM, Takashi Iwai wrote:

>> 	/* allocate level buffer */
>> 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
>> 			snd_dma_pci_data(hdspm->pci),
>> 			MADIFX_LEVEL_BUFFER_SIZE, &hdspm->dmaLevelBuffer);
>> 	if (err < 0) {
>>     /* error */ [..]
>>     }
>>
>>     hdspm->level_buffer = snd_sgbuf_get_ptr(&(hdspm->dmaLevelBuffer), 0);
> 
> hdspm->level_buffer = (u32*)hdspm.dmaLevelBuffer.area;

Looks good, TNX.

>> This used to work on my development machine (kernel 3.6.x), but now a
>> kernel 3.2.0 user reports a NULL pointer dereference of
>> hdspm->level_buffer, so apparently, snd_sgbuf_get_ptr() returned NULL
>> for him.
> What's level_buffer?

The card does hardware metering and stores RMS/peak values in a DMA
buffer. I want to later pass this to userspace to show signal levels,
either via memcpy()ing the DMA buffer or maybe via mmap(). But since I
no longer have access to such a card, work on this is on halt atm.

> Is a SG-buffer for the audio stream?

The audio buffers use

	     snd_pcm_lib_preallocate_pages_for_all(pcm,
						   SNDRV_DMA_TYPE_DEV_SG,
						   snd_dma_pci_data(hdspm->pci),


so they're SG, yes.

>> How could this possibly happen?
> A wrong usage :)

I thought so, that's why I was asking. ;)



Cheers and thanks again
