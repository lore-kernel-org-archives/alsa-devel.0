From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 1/3] ASoC: bcm2835: move to use the clock framework
Date: Sat, 13 Feb 2016 09:51:21 +0100
Message-ID: <A3C029B5-816E-4EC3-823D-6755ECD4773B@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org> <1452602149-5875-2-git-send-email-kernel@martin.sperl.org> <87vb6dfjbu.fsf@eliezer.anholt.net> <56B88520.5060606@martin.sperl.org> <87bn7l3085.fsf@eliezer.anholt.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87bn7l3085.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


> On 13.02.2016, at 01:47, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org> wrote:
> 
> Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> writes:
>> 
>> Problem is that we need the VC4 bus-address (0x7e203000),
>> which is the actual <reg> value from the device tree without any
>> mapping.
>> 
>> Not the ARM MMU visible address mappings that mem->start provides
>> (typically 0x20203000 or 0x3f203000 for bcm2836)
>> 
>> Nor the mapped address (base) available in the kernel (typically
>> 0xdc......).
> 
> Now that I've noticed the BCM2835_VCMMU_SHIFT removal, this makes sense,
> but when you put unrelated changes like this together you end up slowing
> down the review process on your patches.  Please separate it out into a
> separate commit.

OK - I agree: I really should have separated those, but as the
driver was broken for both reasons and the MMU_SHIFT was the earliest
fix I forgot about it when I got the final version for submission.

Anyway: Mark has already applied this patch on January 15th into for-next:
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/sound/soc/bcm/bcm2835-i2s.c?h=for-next&id=517e7a1537ae4663268be5d0c0ec62c563b9fc99
so it should go into the next release...

So unless Mark wants to revert it and have two separate patches
instead, I guess we need to leave it like it is.

Martin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
