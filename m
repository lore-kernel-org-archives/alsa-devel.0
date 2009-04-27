From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 15:24:37 +0100
Message-ID: <20090427142437.GF20591@sirena.org.uk>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
	<9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DB7E24584
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 16:24:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 10:16:16AM -0400, Jon Smirl wrote:
> On Mon, Apr 27, 2009 at 10:05 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > It's a fairly hefty change for -rc4. ?From the sounds of it you just
> > need to add the constraint?

> it is also broken because of the additional requirement of needing to
> estimate the current position of the DMA transfer. The changes in
> pcm_lib.c have made it non-functional.  When I went into fix those
> problems I found a couple more issues.  It's ok for i2s to be broken
> in this release, Grant and I both know it is broken and won't ship
> anything based on it.

Well, if you don't see any need to fix it then I guess that's OK.  We
should probably disable the Kconfig option for the release in case
people try to use the driver, though.

> The pcm_lib.c changes may have broken other embedded drivers too.  And

I see no reason to suspect that embedded drivers will be any more or
less affected than any other ALSA driver?
