From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Allocating DMA buffer for non-PCM
Date: Thu, 14 Feb 2013 19:46:39 +0100
Message-ID: <511D310F.8020207@drcomp.erfurt.thur.de>
References: <511D18F9.3040906@drcomp.erfurt.thur.de>
 <511D22F6.2060600@ladisch.de> <20130214175251.GD15334@ltw.loris.tv>
 <511D2688.3020002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 45CA1265359
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 19:46:41 +0100 (CET)
In-Reply-To: <511D2688.3020002@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/14/2013 07:01 PM, Clemens Ladisch wrote:

>> On Thu, Feb 14, 2013 at 06:46:30PM +0100, Clemens Ladisch wrote:
>>>> Would you say that the following is the proper way to allocate a DMA
>>>> buffer used to hold level data?
>>>>
>>>> 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
>>>> 			snd_dma_pci_data(hdspm->pci),
>>>> 			MADIFX_LEVEL_BUFFER_SIZE, &hdspm->dmaLevelBuffer);
>>>>
>>>>     hdspm->level_buffer = snd_sgbuf_get_ptr(&(hdspm->dmaLevelBuffer), 0);
>>>
>>> I don't see the code asking for the address of the second page, so I
>>> guess there isn't one.
>>
>> Exactly.
> 
> So MADIFX_LEVEL_BUFFER_SIZE is guaranteed to not exceed the page size
> on all architectures?

Absolutely not, it's known to be multiples of the page size, but the
purpose of hdspm->level_buffer is to hold the continuous virtual
address, so apparently, I was using the wrong getter function in the
first place (I was actually looking for .area).

The code for accessing the other pages was omitted for the sake of
simplicity, but since you've asked, here it is:

   	/* Fill level page table */
	for (i = 0; i < MADIFX_NUM_LEVEL_PAGES; i++) {
		levelPageTable[i] = snd_sgbuf_get_addr(&(hdspm->dmaLevelBuffer),
				i * MADIFX_HARDWARE_PAGE_SIZE);

	}

	/* Write level page table to device */
	lpti = (MADIFX == hdspm->io_type) ? MADIFX_LPTI_HMFX :
		MADIFX_LPTI_MFXT;

	for (i = 0; i < MADIFX_NUM_LEVEL_PAGES; i++) {
		madifx_write(hdspm, MADIFX_PAGE_ADDRESS_LIST + (4 * (lpti + i)),
				levelPageTable[i]);
	}



Cheers
