From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
 AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 12:52:17 +0100
Message-ID: <20091006115216.GA12993@rakim.wolfsonmicro.main>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12C07243FF
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 13:52:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
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

On Tue, Oct 06, 2009 at 07:32:30AM -0400, Mike Frysinger wrote:

> back to the original issue.  the AD1836/AD1938 have their registers
> programed via SPI, but they dont care what SPI bus they're connected
> to.  that is specified in the board resources.  because of the way the
> Kconfig options are handled (machine drivers select codecs), the
> SPI_MASTER dependency cannot be added to the codec Kconfigs in
> codecs/Kconfig.  so even though the SPI dependency is only in the
> codec and not the machine driver, the machine driver needs to declare
> the SPI_MASTER dependency to prevent incorrect config selections and
> link failures.

Or, like I say, the drivers for the CODEC should be changed to allow
build with no control bus.  This is a general problem for all the ASoC
drivers and I'm still not sure which way to go.  Depending on just SPI
support fixes the random build case but doesn't help end users get the
driver working so it doesn't seem so useful.  If we're only going to be
able to fix the random build case then it seems more useful to do so by
having the CODEC driver able to build without the control bus, that way
individual machine drivers don't need to worry about it.
