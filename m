From: Sebastien Jan <sjan-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2] mfd: arizona: Add DT binding for irq-gpios property
Date: Thu, 5 Nov 2015 07:08:01 +0100
Message-ID: <563AF241.5030404@baylibre.com>
References: <1446559806-3315-1-git-send-email-sjan@baylibre.com>
 <20151103150450.GP20228@sirena.org.uk> <20151103165247.GC2549@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151103165247.GC2549@ck-lbox>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 03/11/2015 17:52, Charles Keepax wrote:
> On Tue, Nov 03, 2015 at 03:04:50PM +0000, Mark Brown wrote:
>> On Tue, Nov 03, 2015 at 03:10:06PM +0100, Sebastien Jan wrote:
>>
>>> +  - irq-gpios : GPIO specifier for the GPIO connected to /IRQ
>> The platform data this is providing is essentially a workaround for the
>> lack of an irq_to_gpio() function and the use of it is a workaround for
>> the lack of level triggered IRQ emulation in genirq...  do we really
>> want this in the ABI (especially as a generic thing)?
> Personally I would rather not add this to the DT unless we really
> had to.
>
> Also are you sure this is necessary on your system? Specifically
> you only need this entry if the CODEC is connected to an IRQ line
> that only supports edge triggered IRQs.

Mark, Charles, thanks for pointing me to this information.

I don't have this specific constraint on my system and could finally 
also have it working using the regular interrupts / interrup-parent 
properties.

So this new binding is not required for my case. I suppose we can forget 
about it.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
