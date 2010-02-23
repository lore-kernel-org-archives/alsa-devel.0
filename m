From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Tue, 23 Feb 2010 13:12:25 +0800
Message-ID: <4f3252891002222112x3e6fbadcsf827521cf7199ef3@mail.gmail.com>
References: <20100216233825.GB23623@sirena.org.uk>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
	<20100221193933.GA31800@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f204.google.com (mail-px0-f204.google.com
	[209.85.216.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 780282433C
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 06:12:26 +0100 (CET)
Received: by pxi42 with SMTP id 42so1642814pxi.5
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 21:12:25 -0800 (PST)
In-Reply-To: <20100221193933.GA31800@tango.0pointer.de>
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

> On Sun, 21.02.10 11:49, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > The most common onboard audio is HDA so this is not any exceptional cases
> >
> > Those HDA multi streaming  feature are most users wanted in desktop
> > enviornment, are pulseaudio really designed for deskop or just only for
> > notebook and mobile ?
> >
> > The front panel green/pink jack can be used by one application while the
> > rear panel audio jacks can be used to another application for surround or
> > mic for karaoke
>
> I am not entirely convinced that this is really a common case.
>
> But anyway, there is nothing in PA that would limit it to not use
> multiple parallel devices of a sound card at the same time, with the
> exception that ALSA currently has no enumeration API which could
> inform us which uses of the card are exclusive each other and which
> ones are not. PA currently tries to open the sound card in all
> combinations possible, assuming that EBUSY means it found an invalid
> combination.


if  ( snd_pcm_info_get_subdevices_count(pcm_info) > 1 ) mean you can open
the device more than one time since the device has more than 1 subdevice
