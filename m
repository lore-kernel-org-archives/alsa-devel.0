From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Thu, 25 Feb 2010 21:14:34 +0800
Message-ID: <4f3252891002250514p68a4bd2dp77b26d3a1cd276df@mail.gmail.com>
References: <20100216154015.GA612@tango.0pointer.de>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 690EE1039A7
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 14:14:36 +0100 (CET)
Received: by pwi9 with SMTP id 9so5014123pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 05:14:35 -0800 (PST)
In-Reply-To: <20100218181322.GB5606@tango.0pointer.de>
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

2010/2/19 Lennart Poettering <mznyfn@0pointer.de>

> On Thu, 18.02.10 14:15, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > VLC media player has a slider from 0% to 300% , so the user are easily to
> > know  100% is the point which there is no software gain and no software
> > autentation
> >
> > How did PA expose these software amplication in the UI so that ordinary
> user
> > can know that point ?
>
> Depends on the UI program. gnome-volume-control currently only puts a
> marker at the ALSA 0dB point, but not a second one where software amp
> starts.
>

For example , your program dbmeasure.c generate a full amplitude sine wave ,
the sine wave will be clipped for any software gain by pulseaudio , any
hardware att. by DAC cannot change the clipped sine wave
