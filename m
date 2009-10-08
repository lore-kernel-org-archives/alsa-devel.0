From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] ASoC: Blackfin
 AD1836/AD1938 machine drivers: require SPI master
Date: Thu, 8 Oct 2009 11:01:36 +0100
Message-ID: <20091008100135.GA9053@rakim.wolfsonmicro.main>
References: <20091006095018.GB27168@sirena.org.uk>
	<8bd0f97a0910060300m7fa80daas63afd272ba85fb16@mail.gmail.com>
	<20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
	<8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
	<20091006220725.GA32267@opensource.wolfsonmicro.com>
	<8bd0f97a0910070132x2c6a1a38w373cf929d4645ef6@mail.gmail.com>
	<20091007101927.GC3169@rakim.wolfsonmicro.main>
	<8bd0f97a0910071727x72fe950x804f295ba25d514c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED82510392D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 12:01:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910071727x72fe950x804f295ba25d514c@mail.gmail.com>
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

On Wed, Oct 07, 2009 at 08:27:56PM -0400, Mike Frysinger wrote:

> i dont think the soc-cache could be used currently by the ad1836 as it
> doesnt use a 7/9 split with the address/data.  it uses like 6/10 (4
> addr bits, one bit for read/write, one bit is always 0, and 10 data
> bits).  guessing the write bit can be considered part of the addr as
> the read always comes from the cache, but that still gives us 5/10
> split.  maybe a new 6/10 set of funcs should be added ...

That's the idea - add new functions for any new register formats.

> snd_soc_7_9_write() looks like it does a little more bit work than it
> needs to ?  if data is declared as a u16, then you have:
> u16 data = (reg << 9) | (value & 0x01ff);
> this is what the ad1836 driver does now for its data split.

Probably.  I'd need to check but I believe that's there to handle
endianness variations in the host, though a cpu_to_ in what you have
above ought to be able to take care of that.  The code was cut'n'pasted
from what was in the drivers already.

> in the mean time, rather than adding #ifdef to the codec driver, we
> could create a local header like "bus-stubs.h" that stubs all the
> relevant functions to an error value.  then all codec drivers that
> dont use soc-cache can use that instead and the only change needed is
> to add:
> #include "bus-stubs.h"

I'm not sure I feel up to doing that locally in ASoC rather than in the
relevant subsystems.
