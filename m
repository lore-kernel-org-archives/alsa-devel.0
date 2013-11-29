From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: Add support for the Analog
 Devices AXI-I2S core
Date: Fri, 29 Nov 2013 14:04:48 +0100
Message-ID: <529890F0.7090100@metafoo.de>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
 <1385665372-29477-2-git-send-email-lars@metafoo.de>
 <20131129115830.GT27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-236.synserver.de
 [212.40.185.236])
 by alsa0.perex.cz (Postfix) with ESMTP id C3E5F261700
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 16:18:25 +0100 (CET)
In-Reply-To: <20131129115830.GT27568@sirena.org.uk>
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

On 11/29/2013 12:58 PM, Mark Brown wrote:
> On Thu, Nov 28, 2013 at 08:02:50PM +0100, Lars-Peter Clausen wrote:
> 
> A few really minor things below.
> 
>> The patch also adds a simple ASoC PCM driver for the PL330 DMA controller using
>> the generic dmaengine PCM driver. This driver is only temporary can be removed
>> once we have all the infrastructure in place to query information like maximum
>> transfer size directly from the dmaengine driver.
> 
> It's not really a driver as such, it's just specifying some extra
> parameters - I'd expect you're going to need to keep the addresses at
> least.  It's probably more accurate to say that at the minute there's
> some assumptions in the driver about the DMA controller configuration
> that will be required which should be removable in future?

Sorry, I forgot to update that paragraph there used to be a separate PCM
driver, but it's now all handled by generic PCM driver since it is now able
to query the constraints from the DMA driver.

> 
>> +config SND_SOC_ADI
>> +	tristate "Audio support for Analog Devices reference designs"
>> +	depends on SND_SOC && (MICROBLAZE || ARCH_ZYNQ || COMPILE_TEST)
>> +	help
>> +	  Audio support for various reference designs by Analog Devices.
>> +
> 
> Given that this is a FPGA IP I'd also expect it to be available on
> SOCFPGA and probably other things.  For the Designware I2S controller we
> just don't have any platform dependency at all.

We only use it on ZYNQ and Microblaze though. And people have complained in
the past about symbols that are viable on their platform, but are not
relevant for their platform. And to use the core on a different FPGA
platform will most likely require changes to the core, unless the other FPGA
also has a PL330 DMA interface. So I'd prefer to only make it avaiable on
ZYNQ and Microblaze right now.

> 
> There's no need for the SND_SOC dependency, all the subdirectory
> Kconfigs are only included in an if SND_SOC block.
> 
>> +	frame_size = AXI_I2S_BITS_PER_FRAME / 2 - 1;
> 
> This isn't obvious - usually the frame size is the number of bits per
> frame.  Looking at the code I guess the hardware is more flexible than
> the driver allows at the minute?

The core allows to configure the bitclock cycles per word. Right now the
frame size is just hardcoded to 64. It's probably something that could be
made configurable by snd_soc_dai_set_bclk_ratio(). But we really don't need
that feature at the moment. But I'll add a comment explaining this. And
maybe rename the variable from framesize to wordsize.

Thanks for the quick review.

I'll wait for comments on the DT bindings and send out a v2 probably at the
end of next week.

- Lars
