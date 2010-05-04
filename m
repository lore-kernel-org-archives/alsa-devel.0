From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 4 May 2010 10:31:58 +0800
Message-ID: <l2m4f3252891005031931nc318e116k3534259a8f3d5f6f@mail.gmail.com>
References: <alpine.DEB.1.10.1002012239220.3125@ecabase.localdomain>
	<4f3252891002081459q29f02414hf168a596ab641995@mail.gmail.com>
	<alpine.DEB.1.10.1002092242540.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
	<alpine.DEB.1.10.1002211155420.3327@ecabase.localdomain>
	<20100221202144.GG31800@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B41624403
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 04:38:45 +0200 (CEST)
Received: by pxi13 with SMTP id 13so1352202pxi.38
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 19:38:44 -0700 (PDT)
In-Reply-To: <20100221202144.GG31800@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/22 Lennart Poettering <mznyfn@0pointer.de>

> On Sun, 21.02.10 12:06, Kai Vehmanen (kvehmanen@eca.cx) wrote:
>
> >
> > Hi,
> >
> > On Thu, 11 Feb 2010, Jaroslav Kysela wrote:
> >
> > >> However, PA ignores the sound card's interrupts and is woken up by its
> > >> own timer.
> > >
> > > PA can drive the wake-ups using avail_min sw parameter. If this value
> is
> > > high enough, no userspace wake up is called, only interrupt is
> processed
> > > and internal ring buffer pointers in the driver are updated.
> >
> > but that's unfortunately not enough. AFAIK glitch-free aims, among other
> > things, to minimize power usage for battery powered devices, and to do
> > that, you need to minimize hardware interrupts [1]. And for that,
> > avail_min won't help.
> >
> > [1] this is exactly the same thing that is driving Linux tickless
> >      development:
> >      http://www.lesswatts.org/projects/tickless/
> >
> > PS I do agree that avail_min is a very useful, and often overlooked
> >     feature, of ALSA. But in this specific case it won't help...
>
> We try our best to minimize wakeups by setting the minimal number of
> periods in PA. Unfortunately that still means one gets 2 or 1 irqs per
> buffer iteration.
>
> However even if we get those two wakeups, using avail_min allows us to
> minimize the number of processes that are woken up on that
> IRQ. i.e. if the CPU is woken up, it is still better when this only
> means some IRQ in the kernel is processed, then passing it into
> userspace.
>
> Lennart
>
>
Has any one try the patch posted in
http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/6671

>> Rewinding the ring buffer completely causes audible issues with DMAs.
Previous solution didn't work with tsched=0, and used tsched_watermark
for guardband, which isn't linked to hardware and could become really high
if underflows occurred.

Why PA alway rewind the buffer when the stream connects ?

When you rewind the application pointer to hardware pointer  ?
