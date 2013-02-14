From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Allocating DMA buffer for non-PCM
Date: Thu, 14 Feb 2013 19:01:44 +0100
Message-ID: <511D2688.3020002@ladisch.de>
References: <511D18F9.3040906@drcomp.erfurt.thur.de>
 <511D22F6.2060600@ladisch.de> <20130214175251.GD15334@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8C66D265184
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 19:02:49 +0100 (CET)
In-Reply-To: <20130214175251.GD15334@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Knoth wrote:
> On Thu, Feb 14, 2013 at 06:46:30PM +0100, Clemens Ladisch wrote:
>>> Would you say that the following is the proper way to allocate a DMA
>>> buffer used to hold level data?
>>>
>>> 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
>>> 			snd_dma_pci_data(hdspm->pci),
>>> 			MADIFX_LEVEL_BUFFER_SIZE, &hdspm->dmaLevelBuffer);
>>>
>>>     hdspm->level_buffer = snd_sgbuf_get_ptr(&(hdspm->dmaLevelBuffer), 0);
>>
>> I don't see the code asking for the address of the second page, so I
>> guess there isn't one.
>
> Exactly.

So MADIFX_LEVEL_BUFFER_SIZE is guaranteed to not exceed the page size
on all architectures?

> Just to be sure: Takashi has recommended to use
> (u32*)dmaLevelBuffer.area. Even in the case of SG buffers, is this
> virtual address continuous and safe for memset?

Yes, the SG buffer's pages are vmap()ed there.


Regards,
Clemens
