From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: SNDRV_PCM_INFO_MMAP - what do I need for it?
Date: Wed, 16 Jan 2008 11:45:46 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0801161138100.13487@shell2.speakeasy.net>
References: <478E2025.8010509@freescale.com> <s5hy7apr7s0.wl%tiwai@suse.de>
	<478E5598.9060306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail4.sea5.speakeasy.net (mail4.sea5.speakeasy.net
	[69.17.117.6]) by alsa0.perex.cz (Postfix) with ESMTP id 614EB24561
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 20:45:49 +0100 (CET)
In-Reply-To: <478E5598.9060306@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Jan 2008, Timur Tabi wrote:
> Takashi Iwai wrote:
> > At Wed, 16 Jan 2008 09:17:57 -0600,
> > Timur Tabi wrote:
> >> 	.info   		= SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_MMAP |
> >> SNDRV_PCM_INFO_MMAP_VALID,
> >>
> >> what does ALSA do differently?  Do I need to define any new functions?  From an
> >> application perspective, what is different?
> >
> > It means that the driver supports mmap access to the PCM buffer.
> >
> > In some cases, you need to implement a proper mmap callback.  For
> > example, when the coheret (dma) pages are allocated via
> > dma_alloc_coherent and used for the PCM buffer, you need mmap callback
> > for ARM, at least because the default mmap handler in the PCM core
> > doesn't work for ARM.  In this case, prepare your own mmap callback
> > and pass it to pcm ops.  It should call simply dma_mmap_coherent()
> > appropriately.
>
> The default mmap handler in the PCM core is snd_pcm_default_mmap()?
>
> How can I know whether this function works?  Can I just add those two flags to
> my .info line, and then .... ?  Is there an ALSA mmap test utility?

You can use the -M option with arecord and aplay too see if mmap works.
You need to actually hear/record sound to know, just getting no errors
isn't enough.

The default mmap hander will work if you used ALSA to allocate the DMA
buffer.  If you didn't, for example the cx88-alsa and bt87x drivers use
vmalloc(), then you need to write your own mmap handler.  The handler I
wrote for the previously mentioned drivers wasn't complex.
