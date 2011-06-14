From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: Subject= @Daniel Mack: Send you a FTU
Date: Tue, 14 Jun 2011 11:39:40 +0200
Message-ID: <20110614093940.GW17989@ltw.loris.tv>
References: <BANLkTinVHE6+pZnOG+zRuC_HSdJmoswf1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 82EB52415C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 11:39:49 +0200 (CEST)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id D32CF50002C
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 11:39:45 +0200 (CEST)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 57qQUz7f7pBw for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 11:39:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinVHE6+pZnOG+zRuC_HSdJmoswf1Q@mail.gmail.com>
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

On Tue, Jun 14, 2011 at 10:17:05AM +0100, Aur=E9lien Leblond wrote:

Hi!

> >Quite frankly, I'm not fully aware about known issues with these
> >devices that need attention. Could you summarize which problems are
> >left to look at?
> =

> There are still the issue of samples dropping.
> =

> Tto reproduce it:
> - Open Audacity and set it up to be using Jack.
> - Click Generate -> Tone -> Ok.
> =

> "Normally" you should hear very regular pops...

JFTR: In the past, audacity wasn't exactly the most reliable piece of
audio software available. It was actually known to be broken in
different ways every time a new version was available.

I've seen so many bug reports against audacity (as a member of the
Debian Multimedia Package Maintainers) and spent some hours hacking
patches that I arrived at the conclusion that audacity is best for
visualizing waveforms. I guess it was never intended to actually output
them. ;)


Long story short: just because audacity behaves abnormally doesn't mean
the card itself is broken.

Or more frankly: audacity isn't reliable enough to be used as a test
tool. Use plain jackd and maybe ardour to record a track via digital
loopback. Maybe even remove jackd from the test setup.

I wonder if you're just seeing ordinary xruns caused by wrong jackd
settings.


Cheers

-- =

mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
