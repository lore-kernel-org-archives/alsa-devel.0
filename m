From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC:
	Blackfin	AD1836/AD1938 machine drivers: require SPI master
Date: Tue, 6 Oct 2009 10:50:18 +0100
Message-ID: <20091006095018.GB27168@sirena.org.uk>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
	<1254808311-3594-2-git-send-email-vapier@gentoo.org>
	<20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 58EDB103820
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 11:50:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
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

On Tue, Oct 06, 2009 at 05:41:40AM -0400, Mike Frysinger wrote:

> there is no dependency on a specific spi bus master implementation.
> just like the i2c framework, such a dependency would be against the
> whole purpose of having a generic framework in the first place.
> fortunately, this is one piece of the Blackfin ASoC drivers done
> correctly.  in other words, they should work just fine if hooked up to
> a GPIO SPI bus or a SPORT SPI bus or a Blackfin on-chip SPI bus or
> ......

These are board-specific drivers to hook things up on a given system
(presumably various eval boards), they're the non-generic part of the
system that says how the generic DAI and CODEC drivers have been hooked
up.
