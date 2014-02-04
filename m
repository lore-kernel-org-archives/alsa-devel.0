From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: Add ADAU1977 driver
Date: Tue, 04 Feb 2014 14:31:19 +0100
Message-ID: <52F0EBA7.7000501@metafoo.de>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
 <1391439428-3198-2-git-send-email-lars@metafoo.de>
 <20140203184026.GL22609@sirena.org.uk> <52F0CC16.50302@metafoo.de>
 <20140204121224.GW22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-089.synserver.de
 [212.40.185.89])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D252619EA
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 14:31:15 +0100 (CET)
In-Reply-To: <20140204121224.GW22609@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/04/2014 01:12 PM, Mark Brown wrote:
> On Tue, Feb 04, 2014 at 12:16:38PM +0100, Lars-Peter Clausen wrote:
>> On 02/03/2014 07:40 PM, Mark Brown wrote:
>
>>>>   sound/soc/codecs/adau1977-i2c.c        |  58 ++
>>>>   sound/soc/codecs/adau1977-spi.c        |  73 +++
>
>>> This isn't the general style, if we want to do that we should be
>>> converting all the other drivers.
>
>> I think we want to change it. Cause as it is right now we always get
>> issues when the SPI core is build-in, but the I2C core is built as a
>> module. Using the scheme used in this driver the core module for the
>> driver does not depend on either framework, but provides a library
>> to the bus specific modules. E.g. if SPI is built-in and the SPI
>> driver for the ADAU1977 is built-in the core will also be built-in,
>> but it is still possible to build I2C as a module and also build the
>> ADAU1977 I2C driver as a module. And I know there is
>> SND_SOC_I2C_AND_SPI, but in my opinion it's a hack to work around
>> the issue. E.g. if you have a board driver and the board driver
>> selects the CODEC driver, the board driver also has to depend on
>> SND_SOC_I2C_AND_SPI to avoid any issues (None of the board drivers
>> do this right now).
>
> I'm having a hard time seeing that as a meaningful issue to be honest -
> only I2C has the modular option and I'm never terribly convinced about
> the realism of scenarios that trigger this.  In any case the main thing
> is that we shouldn't be silently putting something like this into driver
> submissions, we should be actively making the change to all drivers.

I think this is the cleaner approach rather than the #ifdef mess we 
currently find in drivers with more than one interface. And there is the 
thing that you can actually build a config that results in a build error 
which triggers the occasional randconfig build failures for ASoC. Once the 
last three drivers that still soc-io have been converted to regmap I think 
we should move the selection of REGMAP_I2C and REGMAP_SPI to the individual 
drivers rather letting the core select them unconditionally. Using this new 
scheme will make it easier to avoid the situation where you end up selection 
REGMAP_I2C or REGMAP_SPI even though I2S or SPI_MASTER is not selected. I 
don't have a problem with updating the other drivers to use the new scheme, 
but it's not like we have to update them all at once in one atomic step. And 
you have to start somewhere.
