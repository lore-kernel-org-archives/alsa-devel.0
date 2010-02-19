From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Fri, 19 Feb 2010 18:57:36 +0800
Message-ID: <4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f189.google.com (mail-px0-f189.google.com
	[209.85.216.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 74278103933
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 11:57:39 +0100 (CET)
Received: by pxi27 with SMTP id 27so3961069pxi.2
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 02:57:37 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
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

2010/2/19 Jaroslav Kysela <perex@perex.cz>

> On Thu, 18 Feb 2010, Lennart Poettering wrote:
>
> >> For the Mic Boost +20dB case , how PA handle this +20dB switch in the
> "Flat
> >> Volume" model if you did not expost the Mic Boost switch to the user in
> the
> >> mixer control ?
> >>
> >> +20dB is quite significant in with the Capture Volume control
> >
> > We currently don't cover boost switches, simply because tehre is no dB
> > data queriable for them.
> >
> > I'd really prefer if those boost switches would be turned into binary
> > volume elements which carry normal dB information like any other
> > volume element. After all they are just a volume element, with only
> > two steps.
>
> I like this idea.
>
>                                Jaroslav
>
>
PA assume every sound card can only record from one capture source at the
same time (like those AC97 card )

However HDA support multi streaming capture , the capture device 0 may have
more than one subdevice "Capture sources"  depend on the codec and  device
2  has 2 subdevice for capturing "Input sources" on some codec

Is HDA_SUBDEV_NID_FLAG or any API for the application to find the correct
mixer control for these kind of capturing subdevices  ? ( simple mixer api
is not able to know the subdevice number )
