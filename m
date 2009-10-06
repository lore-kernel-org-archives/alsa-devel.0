From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC:
	Blackfin	AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 23:07:25 +0100
Message-ID: <20091006220725.GA32267@opensource.wolfsonmicro.com>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
	<8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C626B1037FC
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 00:07:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
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

On Tue, Oct 06, 2009 at 05:09:42PM -0400, Mike Frysinger wrote:

> i dont see how abstracting away the bus such that codec drivers are
> allowed to build without proper bus support is useful.  the
> AD1836/AD1938 only work with the SPI bus, so if support for that is
> disabled, having the driver compiled and installed is pointless.

Both approaches allow drivers to be built which can't actually be used
since neither guarantees that there will be a driver for the SPI
controller.  Either way all we're doing is making sure that the kernel
will build, the user can still build things so that the audio driver
won't do anything useful.
