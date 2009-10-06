From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
 AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 11:39:52 +0100
Message-ID: <20091006103952.GC10118@rakim.wolfsonmicro.main>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1CFA2433E
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 12:39:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 06, 2009 at 06:00:23AM -0400, Mike Frysinger wrote:
> On Tue, Oct 6, 2009 at 05:50, Mark Brown wrote:

> > These are board-specific drivers to hook things up on a given system
> > (presumably various eval boards), they're the non-generic part of the
> > system that says how the generic DAI and CODEC drivers have been hooked
> > up.

> except the Blackfin machine drivers are written in such a way that
> they arent specific to a board.  they'll work on any system with a
> SPORT and a SPI/I2C bus.

That's not 100% clear - some of the drivers say they're specific to
particular designs (either in the help text or by having board-specific
GPIO setup).  It's certainly the intention of the API that the board
hookups be fixed at run time rather than at compile time, and that
things like using multiple CPU DAIs should be possible.

The other option here is to make the CODEC drivers build without their
control buses, which keeps the people doing random configurations happy.
