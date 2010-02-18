From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Thu, 18 Feb 2010 14:15:23 +0800
Message-ID: <4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 301881038BE
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 07:15:25 +0100 (CET)
Received: by pwi9 with SMTP id 9so1159236pwi.38
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 22:15:24 -0800 (PST)
In-Reply-To: <20100218023742.GC23637@tango.0pointer.de>
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

2010/2/18 Lennart Poettering <mznyfn@0pointer.de>

> On Thu, 18.02.10 09:48, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > From the viewpoint of user, they only care how easy to find the point
> which
> > is no software gain or software auttentation  since software gain lead to
> > clipping
>
> We decided to expose software amplification in the UI, since it is
> actually a much requested feature, and I have used myself a couple of
> times.
>
> The primary use case is when you play a DVD (which very often has
> audio normalized to a very low volume) on weak speakers, such as
> laptop speakers.
>
> Lennart
>
>
VLC media player has a slider from 0% to 300% , so the user are easily to
know  100% is the point which there is no software gain and no software
autentation

How did PA expose these software amplication in the UI so that ordinary user
can know that point ?

For the Mic Boost +20dB case , how PA handle this +20dB switch in the "Flat
Volume" model if you did not expost the Mic Boost switch to the user in the
mixer control ?

+20dB is quite significant in with the Capture Volume control
