From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC:
	Blackfin	AD1836/AD1938 machine drivers: require SPI master
Date: Sat, 10 Oct 2009 12:11:17 +0100
Message-ID: <20091010111116.GA17855@sirena.org.uk>
References: <20091006103952.GC10118@rakim.wolfsonmicro.main>
	<8bd0f97a0910060432o67e9d00bu84c0139701709e63@mail.gmail.com>
	<20091006115216.GA12993@rakim.wolfsonmicro.main>
	<8bd0f97a0910061409x254b5574wdb0125db0548678@mail.gmail.com>
	<20091006220725.GA32267@opensource.wolfsonmicro.com>
	<8bd0f97a0910070132x2c6a1a38w373cf929d4645ef6@mail.gmail.com>
	<20091007101927.GC3169@rakim.wolfsonmicro.main>
	<8bd0f97a0910071727x72fe950x804f295ba25d514c@mail.gmail.com>
	<20091008100135.GA9053@rakim.wolfsonmicro.main>
	<3c17e3570910092047n39db1ac9vfe76b9304897a794@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3c17e3570910092047n39db1ac9vfe76b9304897a794-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 10, 2009 at 11:47:10AM +0800, Barry Song wrote:
> On Thu, Oct 8, 2009 at 6:01 PM, Mark Brown

> > That's the idea - add new functions for any new register formats.

> we do those based on the idea that it is a waste all codecs need to
> use almost same ways to handle register access. If we use soc-cache to

Not just that, the goal is to make it easier to make changes to the way
register accesses are managed by avoiding the need to go through each
and every single driver and update it.  The most obvious thing is
adding support for powering off the CODEC rather than just bringing it
down to standby.

> handle register access issues and run as abstract layer for all
> codecs, why not rename it to soc-reg or soc-bus? It seems cache is
> only a little part of the responsibility of  this module.

soc-reg (or probably register) would do equally well, like I say longer
term the goal is to support doing interesting things with the cache.  I
don't know that it's worth renaming at this point.

> It's better that functions like xx_7_9_read xx_7_9_write xx_8_8_read
> xx_8_8_write should not become API because we never know what will be
> the format for codecs. We should have a xx_n_m_read/xx_n_m_write or
> just a xx_read/xx_write, with n and m as parameters?

They're not APIs, they're only visible within the file.  Drivers using
the cache only see the one function they use to initialise the cache
with everything else in there hidden from them.  They're not specified
as part of the interface for the read and write functions because they'd
be a lot of noise for callers - they don't generally change at runtime
and are something that should really be abstracted away from the generic
code anyway.

> A codec using snd_soc_7_9_spi_write/snd_soc_8_16_read_i2c should
> select SPI and I2C in fact. Otherwise, why does it use these functions

The CODECs can't do this since they are selected themselves and Kconfig
ignores all dependencies from things that are selected.  In any case, a
given board is only going to need one or the other of the control
interfaces so the CODEC driver needs to leave this up to the machine
drivers anyway.  

The register cache code is the wrong level to be making decisions about
things like this, the CODEC drivers and the register cache code are
themselves not usable without a machine driver - this is utility code
which should just do whatever it is asked by its users rather than
forcing decisons on them.

> as codec->hw_read()/codec->hw_write()  but not enable SPI and I2C? It
> seems that defining snd_soc_7_9_spi_write and so on as NULL when SPI
> is not selected is really useless, just let us pass the compiling to
> get a module which can't work at all!

It's no use from the point of view of getting a working driver, yes, but
then to get something useful you really need the machine driver to
ensure that the correct controller driver is being built - simple
support for the bus is not enough, we also need the controller.  As
discussed earlier in this thread for some of the Blackfin machines it's
not even possible to do that since we can't tell which controller driver
needs to be used since the machine driver can be used with many boards.

Another thing to bear in mind here is that there are people who do
things like build the kernel with random .configs and we want to avoid
breaking their builds due to poor luck in the configuration they
generate while still getting the build coverage that results.  We also
need to be able to support compilation with either I2C or SPI but not
both in order to avoid forcing boards to include support for a bus that
may not be used anywhere on the board at all.  That means that both
buses need to be individually optional at the CODEC level.
