From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: hw_params function and OSS emulation
Date: Thu, 23 Aug 2007 15:17:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708231512130.30669@shell2.speakeasy.net>
References: <46CB2BB4.9060808@freescale.com> <s5hbqd0j5c6.wl%tiwai@suse.de>
	<46CC480F.7090604@freescale.com> <s5h3aybipj1.wl%tiwai@suse.de>
	<46CC4FF3.6090607@freescale.com> <s5hy7g3h948.wl%tiwai@suse.de>
	<46CC5ADC.4020605@freescale.com> <s5hsl6bh89y.wl%tiwai@suse.de>
	<46CDC5AB.6080602@freescale.com> <s5htzqq5ev4.wl%tiwai@suse.de>
	<46CDD55C.5040301@freescale.com> <s5hzm0inkgt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id C15ED10382D
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 00:17:35 +0200 (CEST)
In-Reply-To: <s5hzm0inkgt.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Aug 2007, Takashi Iwai wrote:
> At Thu, 23 Aug 2007 13:43:40 -0500,
> Timur Tabi wrote:
> >
> > Takashi Iwai wrote:
> >
> > > Err, usually, application = user-space application.  Do you mean
> > > really this?
> >
> > Yes.  The application allocates a buffer, locks it down, and passes it to the
> > kernel.  Since the buffer was allocated in user space, it is virtual
> > contiguous but not physically contiguous, hence the need for a list of
> > physical addresses.  To the hardware, the buffer appears as a collection of
> > scattered buffers.  Hence, scatter/gather.
>
> Hm, then it must be a really special application.  I've never seen
> linux audio apps doing such things...

v4l2 suppoorts both kinds of memory mapped dma.  Normally, the dma buffer
is allocated by the kernel and the user space application is given an
address to memory map.  This way DMA-able memory can be allocated.  For
some device, e.g. zr36060, it might even need to be physically contiguous.

The other kind is called "user pointer" and in this case user space
allocates the memory and passes a pointer to the kernel.  It's defined in
the API, but I think few (any?) driver actually support it. One could use
this to place the dma buffer in a shared memory segment or some other
reason the application wants the buffer at a certain address.
