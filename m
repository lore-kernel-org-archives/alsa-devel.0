From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3.1]ASoC: ad193x: add spi_hw_read,
 fix sysclk and register definition
Date: Fri, 12 Aug 2011 10:30:17 +0900
Message-ID: <1313112617.19990.41.camel@finisterre.wolfsonmicro.main>
References: <CAHG8p1AJ66K8yjiEz3HXv64JB0C4OrCPbCFV+Gu5jQkvB5cibA@mail.gmail.com>
	<1313054602.16663.10.camel@finisterre.wolfsonmicro.main>
	<CAHG8p1A_QovuTgTdkAKzzMpQXzUzpnSqSSrCom=Dx9UPpPts7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32E701039A6
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 04:50:18 +0200 (CEST)
In-Reply-To: <CAHG8p1A_QovuTgTdkAKzzMpQXzUzpnSqSSrCom=Dx9UPpPts7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-08-11 at 17:52 +0800, Scott Jiang wrote:
> 2011/8/11 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Thu, 2011-08-11 at 17:04 +0800, Scott Jiang wrote:

> >> -     reg = (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
> >> +     reg = (reg & (~AD193X_DAC_WORD_LEN_MASK))
> >> +             | (word_len << AD193X_DAC_WORD_LEN_SHFT);
> >>       snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
> >>
> >>       reg = snd_soc_read(codec, AD193X_ADC_CTRL1);

> > This needs some documentation as it's not clear what it's supposed to
> > do.

> the word_len value forgot to shift, I think it's clear.

This is an unrelated change and should be split out - the major reason
it's confusing is that it's got nothing to do with the rest of the
change.

> >> +#if defined(CONFIG_SPI_MASTER)
> >> +     /* asoc cache layer can't support this kind of spi registers now */
> >> +     codec->cache_bypass = 1;
> >> +#endif

> > That's not what cache_bypass is for. Just mark the registers as
> > volatile, or remove the cache entirely.

> volatile usually used on the read-only registers, so I think removing
> cache is better.

No, not at all. All volatile means is that a register can't be cached.
For example, many interrupt status registers are write to clear so
they're volatile because the device can change them but we still need to
write to clear them.
