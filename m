From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC
	codec:	SSM2602: assign last substream to the master when
	shutting down
Date: Wed, 3 Jun 2009 15:53:16 +0100
Message-ID: <20090603145316.GA7315@rakim.wolfsonmicro.main>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95E07103872
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 16:53:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:37:54AM -0400, Mike Frysinger wrote:
> On Wed, Jun 3, 2009 at 06:52, Mark Brown wrote:

> > However, given that this fix has missed two kernel releases due to the
> > very slow rate of responses to review comments I've applied it so users
> > get the benefit of the bug fix.

> not sure what you're referring to

This looks like a respin of a fix which was originally submitted back in
2.6.29 era or so.  IIRC there's been two or three versions, each of
which needed fixes.

> >=A0Things would go more smoothly if you
> > could get new versions of patches submitted faster after the original
> > review.

> the previous Blackfin kernel maintainer changed jobs so we've been
> transitioning.  reality is, this doesnt happen over nite.

I appreciate that Brian leaving won't have helped here but this was an
issue before then, it feels like there's some sort of general process
issue going on.  I'm not sure what it is - IIRC there tends to be about
one set of Blackfin patches per kernel release.

It's not specifically causing me problems, it's more of a concern from
the point of view of getting stuff to users.
