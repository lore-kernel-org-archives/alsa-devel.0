From: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
Subject: Re: [PATCHv3] ASoC: Add support for BCM2835
Date: Mon, 18 Nov 2013 15:25:26 +0100
Message-ID: <528A2356.4040501@koalo.de>
References: <5289F9DF.8060406@koalo.de> <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131118141637.GI30853-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Thank you!

>> diff --git a/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
>> new file mode 100644
>> index 0000000..7bf1d04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
>> @@ -0,0 +1,22 @@
>> +* Broadcom BCM2835 SoC I2S/PCM module
>> +
>> +Required properties:
>> +- compatible: "brcm,bcm2835-i2s"
>> +- reg: Register location and size
>> +       <PCM base address, size
>> +        PCM clock base address, size>;
> 
> []
> 
> Are the clocks actually a sub-block, or are they actually a separate
> unit that just happens to feed this one?

Sorry, but I don't get your point. It is a clock module that is
dedicated to the PCM module.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
