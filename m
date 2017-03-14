From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 4/4] dts: bcm283x.dtsi: Add analog audio/headphone jack
 for bcm2835
Date: Tue, 14 Mar 2017 11:07:35 +0100
Message-ID: <952dc3e0-a01a-bb21-78bd-d3639251c84a@i2se.com>
References: <20170312063820.19313-1-mzoran@crowfest.net>
 <20170312063820.19313-4-mzoran@crowfest.net>
 <a5ae562f-6843-f137-6470-36c53cfd1799@i2se.com>
 <1489481279.656.1.camel@crowfest.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489481279.656.1.camel-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am 14.03.2017 um 09:47 schrieb Michael Zoran:
> On Tue, 2017-03-14 at 09:05 +0100, Stefan Wahren wrote:
>
>> AFAIK the Raspberry Pi 3 uses pin 40 and 41.
>>
> I did all my testing on the RPI 3, so I'm almost certain it's correct. 
> It matches with the schematic and it matches with what the downstream
> tree uses for the firmware based driver(dummy claiming of pins).

The reduced schematic that i have name the pins as AUD_PWM0 and
AUD_PWM1, which says nothing about the actual pins. Do you have a better
document?

In the firmware dt-blob.dts [1] the Raspberry Pi 3 uses pin 40 and 41.

[1] - https://github.com/raspberrypi/firmware/blob/master/extra/dt-blob.dts
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
