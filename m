From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: problem with snd_soc_dai_set_fmt()
Date: Fri, 30 Apr 2010 09:58:45 +0100
Message-ID: <20100430085845.GC28241@rakim.wolfsonmicro.main>
References: <4BD9F889.4010106@freescale.com>
	<20100429221808.GB23958@opensource.wolfsonmicro.com>
	<r2m1b68c6791004291828p77188d3frcb7ef516823e0477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDF8524347
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 10:58:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <r2m1b68c6791004291828p77188d3frcb7ef516823e0477@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 10:28:57AM +0900, jassi brar wrote:
> On Fri, Apr 30, 2010 at 7:18 AM, Mark Brown

> > something a bit more distinctive than -EINVAL. =A0If we want to support
> > very generic machine drivers that genuinely don't know what hardware is
> > able to do I think we'd be be better off doing something like adding
> > capability masks to the drivers so these functions can validate what
> > they're being asked to do, at which point we know the actual format so
> > returning 0 isn't an issue.

...

> Though I am ok with the status quo -- snd_soc_dai_ops members being
> truly optional and machine driver writers knowing both the DAIs and calli=
ng
> only appropriate functions, but if we are to move to more generic machine
> drivers how about hiding such members of snd_soc_dai_ops from machine
> drivers and let the machine drivers specify the exact requirement to ASoC
> via some generic enough data structure. Part of that configuration can be
> done by ASoC while the platform specific stuff passed onto DAI drivers.

Yes, the capability information I suggested above would be required to
implement such a thing.  It does need to be very much optional, though,
to allow room for more complex systems.
