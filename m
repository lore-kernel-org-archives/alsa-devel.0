From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Allocating DMA buffer for non-PCM
Date: Thu, 14 Feb 2013 18:52:51 +0100
Message-ID: <20130214175251.GD15334@ltw.loris.tv>
References: <511D18F9.3040906@drcomp.erfurt.thur.de>
 <511D22F6.2060600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 15B0A265363
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 18:52:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <511D22F6.2060600@ladisch.de>
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

On Thu, Feb 14, 2013 at 06:46:30PM +0100, Clemens Ladisch wrote:

> > Would you say that the following is the proper way to allocate a DMA
> > buffer used to hold level data?
> >
> > 	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG,
> > 			snd_dma_pci_data(hdspm->pci),
> > 			MADIFX_LEVEL_BUFFER_SIZE, &hdspm->dmaLevelBuffer);
> >
> >     hdspm->level_buffer = snd_sgbuf_get_ptr(&(hdspm->dmaLevelBuffer), 0);
> I don't see the code asking for the address of the second page, so I
> guess there isn't one.

Exactly.

Just to be sure: Takashi has recommended to use
(u32*)dmaLevelBuffer.area. Even in the case of SG buffers, is this
virtual address continuous and safe for memset?


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
