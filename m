From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2 v2] ALSA: ASoC: Add reset-gpio DT
 property to cs4270 driver
Date: Wed, 25 Jul 2012 15:22:29 +0200
Message-ID: <500FF315.50806@gmail.com>
References: <500F8E48.9000007@gmail.com>
 <1343199809-11936-1-git-send-email-zonque@gmail.com>
 <20120725131816.GN3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id ABC2A2652D5
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 15:22:31 +0200 (CEST)
Received: by weyx10 with SMTP id x10so471105wey.38
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 06:22:33 -0700 (PDT)
In-Reply-To: <20120725131816.GN3099@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 25.07.2012 15:18, Mark Brown wrote:
> On Wed, Jul 25, 2012 at 09:03:29AM +0200, Daniel Mack wrote:
>> In the process of moving over from static board files to the device
>> tree, reset pins of peripheral reset pins should be handled by their
>> corresponding drivers.
>>
>> Add a reset-gpio DT property to the cs4270 driver, and de-assert it
>> before probing the chip. The logic could be augmented some day to
>> re-assert it when codec is put to suspend.
> 
> I'm missing 1/2...  Please also don't bury patches in the middle of
> previous threads.
> 
>> +		enum of_gpio_flags flags;
>> +		int gpio = of_get_named_gpio_flags(np, "reset-gpio", 0, &flags);
>> +
>> +		if (gpio_is_valid(gpio))
>> +			devm_gpio_request_one(&i2c_client->dev, gpio,
>> +				     flags & OF_GPIO_ACTIVE_LOW ?
>> +					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
>> +				     "cs4270 reset");
> 
> This ignores the return code and won't work well with probe deferral, if
> we manage to get a GPIO from the DT then we should fail if we're unable
> request it.  Passing back the return code should get you deferral
> support for free in 3.6 and onwards.
> 

Ok, will resent both patches.
