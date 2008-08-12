From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Problems with alsa on ARM
Date: Tue, 12 Aug 2008 21:47:04 +0100
Message-ID: <200808122147.04092.gineera@aspect135.co.uk>
References: <200807162122.21989.gineera@aspect135.co.uk>
	<1216288584.31838.79.camel@localhost.localdomain>
	<s5hbq0w3k42.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EA6D244B9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 22:46:59 +0200 (CEST)
In-Reply-To: <s5hbq0w3k42.wl%tiwai@suse.de>
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
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 17 July 2008 11:01, you wrote:
> At Thu, 17 Jul 2008 10:56:24 +0100,
>
> Liam Girdwood wrote:
> > On Wed, 2008-07-16 at 21:22 +0100, Alan Horstmann wrote:
> > > Hi,
> > >
> > > I am trying to assist a collegue, we're working on ARM (AT91), and
> > > having probs with alsa stuff.
> > >
> > > Can anyone help interpret this strace from aplay -v -Dhw:0 ourfile.wav?
> > > I am comparing it to the same operation on a desktop PC.  After all
> > > sorts of pre-amble, it gets down to accessing snd devices:
> > >
> > > open("/dev/snd/controlC0", O_RDONLY)    = 3
> > > close(3)                                = 0
> > > open("/dev/snd/controlC0", O_RDWR)      = 3
> > > ioctl(3, USBDEVFS_CONTROL, 0xbecd36ac)  = 0
> > > ioctl(3, 0x40045532, 0xbecd36b4)        = 0
> > > open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
> > > close(3)                                = 0
> > > ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecd34f8) = 0
> > > fcntl(4, F_GETFL)                       = 0x802 (flags
> > > O_RDWR|O_NONBLOCK) ioctl(4, AGPIOC_INFO, 0xbecd36a4)       = 0
> > > ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbecd369c) = 0
> > > mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000) = -1 ENXIO (No
> > > such device or address)
> > > ioctl(4, 0xc0844123, 0xbecd3618)        = 0
> > > fcntl(4, F_GETFL)                       = 0x802 (flags
> > > O_RDWR|O_NONBLOCK) fcntl(4, F_SETFL, O_RDWR)               = 0
> > > ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbecd398c) = 0
> > >
> > > The first failure is from mmap2(..).  Exactly the same line (and
> > > values) is successful on PC, but I don't know what it is doing or why
> > > it might fail.
> > >
> > > There are no other negative returns at all, but after opening the wav
> > > file, the playback info is written out, and set_params begins:
> > >
> > > ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> > > ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> > > ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> > > ioctl(4, 0xc25c4110, 0xbecd3628)        = 0
> > > ioctl(4, 0xc25c4111, 0xbecd3628)        = 0
> > > ioctl(4, 0xc0844123, 0x1c210)           = 0
> > > ioctl(4, 0xc0684113, 0xbecd3528)        = 0
> > > ioctl(4, 0x4140, 0)                     = 0
> > > ioctl(4, 0xc0844123, 0x1c210)           = 0
> > > write(2, "aplay", 5aplay)                    = 5
> > > write(2, ": ", 2: )                       = 2
> > > write(2, "set_params", 10set_params)              = 10
> > > write(2, ":", 1:)                        = 1
> > > write(2, "1012", 41012)                     = 4
> > > write(2, ": ", 2: )                       = 2
> > > write(2, "unable to install sw params:", 28unable to install sw
> > > params:) = 28
> > >
> > > All seems to go OK with hw_params, but sw_params must return error (not
> > > seen) as the error check fails.  The values printed out show xfer_align
> > > = 3201120484 which looks suspicious to me.
> > >
> > > Any clues on either of these would be greatly appreciated.
> >
> > This sounds similar to a recent gcc optimisation bug with ALSA on ARM.
>
> I remember a similar problem due to toolchain, too.
>
> Note that the failure of mmap calls is OK.  The driver returns the
> error intentionally because no status/control record mmap is supported
> on ARM.

Liam, Takashi, thanks for your quick replies on this thread a while ago.  My 
collegue did finally nail this issue, which I will explain for anyone 
following this thread or in the archives.

We are currently using the Buildroot system which uses the uClibc libraries.  
Simply, uClibc does not support versioned symbols.  Therefore it is necessary 
to override the ALSA-lib default by adding
	--with-versioned=no
to the build.  Aplay, Alsamixer etc run without problems.

I think the gcc optimisation bug may be fixed on recent gcc versions; it 
didn't in the end turn out to be causing us any problems.

We also noticed that it would be easy to accidentally build kernel and libs 
with different settings of -mabi, which would also cause problems.

Regards

Alan
