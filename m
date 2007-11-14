From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Query regarding
	snd_pcm_lib_preallocate_pages_for_all()
Date: Wed, 14 Nov 2007 17:43:21 +0530
Message-ID: <61445c750711140413m74c1a136q42044275d9c8a293@mail.gmail.com>
References: <61445c750711131042qed654b8s17454534fdaa68e7@mail.gmail.com>
	<s5hd4udfdla.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by alsa0.perex.cz (Postfix) with ESMTP id A758D2437B
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 13:13:49 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so2680592pyb
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 04:13:48 -0800 (PST)
In-Reply-To: <s5hd4udfdla.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Nov 14, 2007 1:44 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 14 Nov 2007 00:12:07 +0530,
> Pharaoh . wrote:
> >
> > Hi,
> >
> > I am trying to use snd_pcm_lib_preallocate_pages_for_all() on an arm
> based
> > platform for preallocating the DMA buffer.
> > I am using it as
> >
> > snd_pcm_lib_preallocate_pages_for_all(pcm,
> >             SNDRV_DMA_TYPE_DEV,
> >             NULL,
> >             64 * 1024, 64 * 1024);
> >
> > since I dont know what should be passed as the 3'rd param. I tried
> passing
> > my device pointer i.e. card->dev after
> > correctly populating it but I get an error as 'DMA coherent mask in not
> set'
> > and buffer is not allocated.
>
> For ARM, avoid the present buffer-preallocation and mmap functions in
> ALSA core.  Instead you can allocate the buffers directly via normal
> dma_alloc_coherent() in your driver.  And, mmap it via
> dma_mmap_coherent() by defining the own mmap callback for PCM ops.
>
> See other arm/* drivers for rerecence.
>
>
> Takashi
>

Yes, I am using my own buffer preallocation scheme now. I allocate a 128K
buffer using dma_alloc_coherent in probe and free it only in remove i.e. at
rmmod time.

I dont think keeping a huge buffer like this till driver removal is a good
idea but when I allocate/deallocate it in hw_params/hw_free respectively, it
is causing fragmentation and sometimes the allocation fails. Do you think
anything better can
be done?

-pharaoh.
