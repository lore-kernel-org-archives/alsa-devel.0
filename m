From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 16:01:32 -0500
Message-ID: <500F0D2C.9010600@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com> <500F0B2D.9070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 670C8265D6F
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 23:01:35 +0200 (CEST)
In-Reply-To: <500F0B2D.9070303@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:

> Sure, the code I have at the moment does it that way, but the idea is to
> have little to no platform specific code. And also, if anything in the
> system needs to know when and how to drive the reset line, it should be
> the driver, right?

Maybe.  We do have a lot of similar code in the boot loader, but of course
that means that it's a static configuration.

>> I have no problem using the CS4270
>> on my board, and I don't need this feature.
> 
> Because you care for that either in the bootloader or the platform code
> I believe?

I don't have any platform code that initializes the codec.

Of course, that doesn't mean that you shouldn't need any.  I'm not
fundamentally opposed to your patch, I just don't have any context to go by.

Also, I have a gut feeling that if someone else needs to do the same
thing, then this code:

devm_gpio_request_one(&i2c_client->dev, reset_gpio,
	reset_gpio_flags & OF_GPIO_ACTIVE_LOW ?
	GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
	"cs4270 reset")

won't work for him, because it's not generic enough.

>> I don't see where you test whether the reset-gpio property is present.  It
>> won't be present in my device tree.
> 
> The idea is that reset_gpio will be < 0 in that case, and so
> devm_gpio_request_one() fails. So your platform should be ok and no
> further checks are necessary.

Well, I would prefer that you check for the property before making any
calls that use it.

Also, I just noticed a typo here:

	/* See if we way to bring the codec out of reset */

-- 
Timur Tabi
Linux kernel developer at Freescale
