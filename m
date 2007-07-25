From: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Subject: Re: dmix and sounds less than 64kb
Date: Wed, 25 Jul 2007 13:27:28 -0700
Message-ID: <61e8390b0707251327n559bb7e1nae86323ddc4b195e@mail.gmail.com>
References: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
	<s5hir8tvrvt.wl%tiwai@suse.de>
	<61e8390b0707091240i657f82ev306ac851759c791f@mail.gmail.com>
	<Pine.LNX.4.61.0707100954280.7300@tm8103.perex-int.cz>
	<61e8390b0707100104v9e66c8fu1321c287d1b8ed5e@mail.gmail.com>
	<Pine.LNX.4.61.0707101008440.7300@tm8103.perex-int.cz>
	<61e8390b0707191259y5f77fb46jabed4184491ea5a4@mail.gmail.com>
	<s5hfy3dyhur.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id F27FB24336
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 22:27:41 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so365674wag
	for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2007 13:27:40 -0700 (PDT)
In-Reply-To: <s5hfy3dyhur.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

I dumped appl_ptr and slave_appl_ptr being sent to mix_areas - and the
numbers flow around the ring buffer in a steady circle. Here are graphs of
the data:

http://www.caustik.com/alsa/scat-appl_ptr.gif
http://www.caustik.com/alsa/scat-slave_appl_ptr.gif

So it looks like those values are moving like they should. However, I do not
know where to print the hardware pointer value. Where is that variable?

Btw - I noticed that the kernel in core audio will manipulate some buffer
pointers based on when the buffer is almost drained - is that relevant?

caustik

On 7/24/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Thu, 19 Jul 2007 12:59:32 -0700,
> Aaron "Caustik" Robinson wrote:
> >
> > We have found that the problem exists because, at certain points in
> time,
> > the hardware pointer and application pointer overlap. Basically the
> hardware
> > is reading from the period buffer which is currently being written to.
> How
> > might this be platform specific? Is there any debugging technique you
> think
> > may help find the root cause?
>
> It sounds unlikely a platform-specific problem but rather a problem of
> the driver implementation.
>
> Note that the hw_ptr and appl_ptr tracked in pcm struct are within 0
> and (runtime->boundary_size - 1).  It's not within 0 and
> (buffer_size-1).  So, basically it shouldn't overlap unless it goes
> across the boundary close to long (32bit or more).
>
>
> Takashi
>
> >
> > On 7/10/07, Jaroslav Kysela <perex@suse.cz> wrote:
> > >
> > > On Tue, 10 Jul 2007, Aaron "Caustik" Robinson wrote:
> > >
> > > > This is on an embedded ARM device, with a custom driver. That's
> > > > interesting. I never thought about the cache angle. Is there any
> sort of
> > > > hack I can put to check if that is the problem?
> > >
> > > The cache flush method is quite CPU specific, you have to check
> datasheet.
> > > But it's only guess and the problem might be somewhere else. I would
> > > compare samples DMA ring buffer in the user space and kernel space
> again.
> > > Also, put a debug lines to dmix plugin to detect where are samples
> written
> > > (to which pointer/area in the DMA ring buffer). dmix assumes that
> playback
> > > is running forever and tries to mix data in actual ring buffer
> position.
> > >
> > >                                                 Jaroslav
> > >
> > > -----
> > > Jaroslav Kysela <perex@suse.cz>
> > > Linux Kernel Sound Maintainer
> > > ALSA Project, SUSE Labs
> > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
