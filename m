From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: How the dma interrupt handlers have been
	registered in ALSA?
Date: Wed, 30 May 2007 18:06:12 +0530
Message-ID: <61445c750705300536w5e531751g185b0d1c367e6258@mail.gmail.com>
References: <61445c750705280911r325521efoaa925aa74ce85c38@mail.gmail.com>
	<s5hsl9fzik5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id F2AF224470
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 14:36:15 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so909324nzf
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2007 05:36:14 -0700 (PDT)
In-Reply-To: <s5hsl9fzik5.wl%tiwai@suse.de>
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

On 5/29/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 28 May 2007 21:41:59 +0530,
> Pharaoh . wrote:
> >
> > Hi
> >
> > I am referring omap-alsa-dma.c and the related codec files. We usually
> > register the IRQ handler by calling
> > request_irq() function but in this mentioned files the IRQ handler etc is
> > defined but it is not registered anywhere i.e. request_irq is not used
> > anywhere. Is there any other way of registering irq handlers? The irq
> > handlers address is passed to
> > omap_request_dma, but there also it is not registered. I am missing the
> > entire thing?
>
> There is nothing but request_irq().  So, it implies that your code
> flow isn't somehow correct.  Missing probe hooks?
>
>
> Takashi
>


Apologies if this sounds novice, but after referring the omap specific
alsa drivers, I wasn't able to locate any request_irq function getting
called, I have traced the omap_request_dma function but it also
doesn't explicaitly call request_irq, but in the file
arch/arm/plat-omap/dma.c there is call arch_initcall(omap_init_dma),
which calls request_irq. As per my humble knowledge this is part of
board specific init and is done at boot time, so does this mean that
it is done only once at boot time and any driver specific callback is
called from this function? Can anyone throw more light on this, or
answer my basic question why there is no request_irq in any of the
omap specific files? I am using 2.6.19 kernel.
