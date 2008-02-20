From: Grzegorz Chwesewicz <grzegorz.chwesewicz@chilan.com>
Subject: Re: snd-hda-intel AD1981 - the microphone doesn't work
Date: Wed, 20 Feb 2008 21:45:25 +0100
Message-ID: <200802202145.25365.grzegorz.chwesewicz@chilan.com>
References: <47B1D340.4070907@gmail.com>
	<200802191512.50604.grzegorz.chwesewicz@chilan.com>
	<s5hve4lt38k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.chilan.com (mail.chilan.com [82.160.213.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 59C85103874
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 21:46:15 +0100 (CET)
In-Reply-To: <s5hve4lt38k.wl%tiwai@suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, chilek@chilan.com
List-Id: alsa-devel@alsa-project.org

> > Thursday 14 of February 2008 13:14:18 Takashi Iwai napisa=B3(a):
> > > And, does a similar problem like Grzegorz's case occur on your laptop?
> > > Some HP laptops (so far, AMD SB450-based) occasionally cause a hang-up
> > > during recording from the mic when HD is accessed.  This is far more
> > > nasty problem, and it's interesting to know whether this happens on
> > > other chipset.
> >
> > 	Hi Takashi. I've experimented a little with power saving in HD Intel
> > Audio. I've noticed that using power saving with timeout set to 10 sec.
> > solves my problem partially. When arecord stops recording I can turn it
> > off, wait 10 seconds, and recording works back again. This is obvious,
> > because power saving simply powers off and on device. I was wondering
> > that maybe we can implement ioctl or something that will dump "state"
> > (informations that will help in debuging) of device, when recording is
> > not working, and "state" just after power on to compare what causes
> > breakage ? Can you give me some tips about what informations are userful
> > in debuging ?
>
> Well, the question is what "state".  Interesting thing is that it's
> specific to ATI SB, and seems irrelevant with codec chip.  So, the
> codec information is likely useless.  But, I don't think the broken
> situation is reflected on PCI reg space.
>
> BTW, Andi Kleen also has a similar problem on his machine and he used
> noirqdebug boot option.  But, in his case, the irq line of HD audio
> device isn't shared with others.

Hi Andi. Do you have similiar problem, and did you resolve it ?

Links to threads are below:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2449
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/005817.h=
tml
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-February/006042.h=
tml

-- =

Greetings
Grzegorz Chwesewicz, Chilan =

mailto:grzegorz.chwesewicz@chilan.com
