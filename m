From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Date: Thu, 5 Jul 2018 17:13:21 +0100
Message-ID: <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705150857.GA6227@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 05/07/18 16:08, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 12:37:00PM +0100, Srinivas Kandagatla wrote:
> 
>> SLIMbus supports upto 16 bytes in value management messages,
>> so add support to raw read/writes upto 16 bytes.
> That's not what raw access is.  It's unmediated access to existing
> registers, not some other thing with completely different register sizes
> which you can't see through the register map.  The intended use is for
> things like fast firmware downloads.  If it's not part of the register
> map we shouldn't be going through regmap to get to it.

Thanks for explaining this in detail.

I think I got it wrong by looking at _regmap_bus_read() implementation 
which calls _regmap_raw_read(), this made me think that read/writes 
callbacks imply raw read/writes. Looks like that is not the case.

These bus read/write callbacks are just simple multiple register 
read/writes.

All am trying to do is support paged registers, which seems to be only 
possible via read/write support at bus level.

Does reg_read/reg_write become redundant if we implement read/write 
callbacks at bus regmap level?

> 
>> Also useful for paged register access on SLIMbus interfaced codecs.
> That needs a bunch more explanation...  in what way does raw access
> relate to paged register maps?
Yes, this is nothing to do with raw access! I got it wrong!
WCD9335 codec has paged registers which is what I need!

I will fix the patch and commit message removing the raw related parts 
and resend.

Does that sound okay?

thanks,
srini
