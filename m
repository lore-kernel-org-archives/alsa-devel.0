From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
 AD1836/AD1938 machine drivers: require SPI master
Date: Wed, 7 Oct 2009 11:19:27 +0100
Message-ID: <20091007101927.GC3169@rakim.wolfsonmicro.main>
References: <20091006093325.GA10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060241k1155d38cmafe623501106d598@mail.gmail.com>
	<20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
	<8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
	<20091006220725.GA32267@opensource.wolfsonmicro.com>
	<8bd0f97a0910070132x2c6a1a38w373cf929d4645ef6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB3E010389F
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 12:19:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910070132x2c6a1a38w373cf929d4645ef6@mail.gmail.com>
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

On Wed, Oct 07, 2009 at 04:32:06AM -0400, Mike Frysinger wrote:

> hmm, that's certainly true.  if we look at it as "screwed either way",
> then going to a generic bus indirection sounds like it'd only add
> runtime overhead for no real gain ?

I was mostly thinking ifdefs here - we'll always need some bus-specific
stuff in the drivers to register them.  It's not pretty but it meets the
needs of people doing randconfig builds.

We already have as much bus indirection as ASoC needs, and there is
actually already some bus access code sharing there as of 2.6.32 (in
soc-cache.c) but it's optional and always will be since we need to cater
for devices that are parts of MFDs which have device specific register
acceses.

> in the face of this proposed effort being a ways off, doesnt it make
> sense to still merge the original proposed patch ?

The ifdefery isn't technically hard to do and given your use case where
you don't know which controller is in use it looks like the only way to
go for this.
