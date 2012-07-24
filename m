From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 22:53:01 +0200
Message-ID: <500F0B2D.9070303@gmail.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id B1CD0265D6F
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:53:02 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so3417055wib.2
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 13:53:04 -0700 (PDT)
In-Reply-To: <500F07F9.8000408@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 24.07.2012 22:39, Timur Tabi wrote:
> Daniel Mack wrote:
>> Yes, I'm aware of this, I just wonder how does your DT note looks like?
> 
> Take a look at arch/powerpc/boot/dts/mpc8610_hpcd.dts

Interesting, I didn't know that works without enabling the specific
string inside the driver. And that makes me wonder why many of the
Wolfson codec have them (like wm8580). I might lack something here,
maybe Mark can explain?

>> And are you ok with the 2nd patch?
> 
> Isn't that something that should be done in platform code?  It seems very
> platform-specific for a codec driver.  

Sure, the code I have at the moment does it that way, but the idea is to
have little to no platform specific code. And also, if anything in the
system needs to know when and how to drive the reset line, it should be
the driver, right?

> I have no problem using the CS4270
> on my board, and I don't need this feature.

Because you care for that either in the bootloader or the platform code
I believe?

> 
>> +	/* See if we way to bring the codec out of reset */
>> +	if (np) {
>> +		enum of_gpio_flags reset_gpio_flags;
> 
> Blank line after variable declarations
> 
>> +		int reset_gpio = of_get_named_gpio_flags(np, "reset-gpio", 0,
>> +							 &reset_gpio_flags);
> 
> Can you make this line shorter by using shorter variable names or something?

Right, fixed.

>> +		if (devm_gpio_request_one(&i2c_client->dev, reset_gpio,
>> +				     reset_gpio_flags & OF_GPIO_ACTIVE_LOW ?
>> +					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
>> +				     "cs4270 reset") < 0) {
>> +			reset_gpio = -EINVAL;
>> +		}
> 
> I don't see where you test whether the reset-gpio property is present.  It
> won't be present in my device tree.

The idea is that reset_gpio will be < 0 in that case, and so
devm_gpio_request_one() fails. So your platform should be ok and no
further checks are necessary.


Thanks for the review,
Daniel
