From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] new ad1836 codec driver based on asoc
Date: Thu, 13 Aug 2009 10:08:02 +0100
Message-ID: <20090813090801.GA31504@sirena.org.uk>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<20090812134645.GC11898@rakim.wolfsonmicro.main>
	<3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 16E9D2433C
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 11:08:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570908122041m29a1843agd0f9fd0e415181c3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 11:41:13AM +0800, Barry Song wrote:
> On Wed, Aug 12, 2009 at 9:46 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > Just "ad1836" - the fact that it's controlled via SPI is clear from the
> > fact that this is a struct spi_driver.

> I agree the spi structure implies the meaning of spi.  But files in
> arch/blackfin/mach... are using names like "xxx-spi" for almost all
> spi devices. How about keeping the coherence?

Oh dear.  Looks like you've essentially got a choice between being
consistent with the rest of the world and being consistent with what the
blackfin stuff is doing.

> > The power control will be handled by DAPM but your driver still needs to
> > restore things like the volume settings - when the driver is powered off
> > the register settings will be forgotten.

> My test shows registers setting doesn't lose after dac/adc shutdown :-)

Probably your board is maintaining power to the chip even during
suspend.
