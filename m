From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Date: Thu, 5 Jul 2018 18:39:14 +0100
Message-ID: <2d2ea16e-c8b4-53b9-259e-d75e6ead4362@linaro.org>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
 <20180705173059.GF6227@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705173059.GF6227@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 05/07/18 18:30, Mark Brown wrote:
> On Thu, Jul 05, 2018 at 06:20:50PM +0100, Srinivas Kandagatla wrote:
> 
>> Access to codec registers is done in 2 steps.
> 
>> 1> Write page number in page register.
>> 2> access register within the page.
> 
>> This seems to exactly what struct regmap_range_cfg gives.
> 
>> Adding ranges to regmap_config along with read/write bus callbacks works for
>> me.
> 
> OK, great - that's what I was expecting.
> 
Thanks, I will respin the patch removing reference to raw in commit log 
and patch.

Are reg_read/reg_write callbacks in bus regmap redundant to read/write 
callbacks?

By the looks of it, it seems redundant, reg_read/reg_write will never be 
used if bus regmap has read/write callbacks. Just wanted reconfirm 
before replacing them with just read/write callbacks.

thanks,
srini
