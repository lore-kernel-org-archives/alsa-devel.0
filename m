From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: Add ADAU1977 driver
Date: Tue, 04 Feb 2014 12:16:38 +0100
Message-ID: <52F0CC16.50302@metafoo.de>
References: <1391439428-3198-1-git-send-email-lars@metafoo.de>
 <1391439428-3198-2-git-send-email-lars@metafoo.de>
 <20140203184026.GL22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-089.synserver.de
 [212.40.185.89])
 by alsa0.perex.cz (Postfix) with ESMTP id C875026172D
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 12:16:34 +0100 (CET)
In-Reply-To: <20140203184026.GL22609@sirena.org.uk>
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

On 02/03/2014 07:40 PM, Mark Brown wrote:
>>   sound/soc/codecs/adau1977-i2c.c        |  58 ++
>>   sound/soc/codecs/adau1977-spi.c        |  73 +++
>
> This isn't the general style, if we want to do that we should be
> converting all the other drivers.
>

I think we want to change it. Cause as it is right now we always get issues 
when the SPI core is build-in, but the I2C core is built as a module. Using 
the scheme used in this driver the core module for the driver does not 
depend on either framework, but provides a library to the bus specific 
modules. E.g. if SPI is built-in and the SPI driver for the ADAU1977 is 
built-in the core will also be built-in, but it is still possible to build 
I2C as a module and also build the ADAU1977 I2C driver as a module. And I 
know there is SND_SOC_I2C_AND_SPI, but in my opinion it's a hack to work 
around the issue. E.g. if you have a board driver and the board driver 
selects the CODEC driver, the board driver also has to depend on 
SND_SOC_I2C_AND_SPI to avoid any issues (None of the board drivers do this 
right now).

>> +config SND_SOC_ADAU1977
>> +	tristate
>> +
>> +config SND_SOC_ADAU1977_I2C
>> +	tristate
>> +	select SND_SOC_ADAU1977
>> +
>> +config SND_SOC_ADAU1977_SPI
>> +	tristate
>> +	select SND_SOC_ADAU1977
>> +
>
> Please make these user visible if OF is in use.

Was there a resolution on how to best do this? Make them always visible, or 
only when CONFIG_OF is selected?

- Lars
