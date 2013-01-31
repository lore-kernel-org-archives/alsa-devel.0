From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 23:25:10 +0100
Message-ID: <510AEF46.1080608@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
 <510A485F.9060100@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 75378262632
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 23:25:12 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id jf20so1555645bkc.7
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 14:25:12 -0800 (PST)
In-Reply-To: <510A485F.9060100@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 31.01.2013 11:33, schrieb Pavel Hofman:
> OK, it looks we have a problem in communication with the chip. IMO the
> 4wire_start and 4wire_finish code is incorrect. As chip-select it takes
> VT1724_REVO_CS1, but for ak4114 it should be VT1724_REVO_CS3 (as defined
> in revo.h)
>
> IMO the two methods should be:
> static unsigned int ap192_4wire_start(struct snd_ice1712 *ice)
> {
> 	unsigned int tmp;
>
> 	snd_ice1712_save_gpio_status(ice);
> 	tmp = snd_ice1712_gpio_read(ice);
> 	tmp |= VT1724_REVO_CCLK; /* high at init */
> 	tmp |= VT1724_REVO_CS0;
> 	tmp &= ~VT1724_REVO_CS3;
> 	snd_ice1712_gpio_write(ice, tmp);
> 	udelay(1);
> 	return tmp;
> }


Btw. is it really intended that CS0 is set and CS3 is unset in 
4wire_start? (In 4wire_finish CS0 is set again.)


> static void ap192_4wire_finish(struct snd_ice1712 *ice, unsigned int tmp)
> {
> 	tmp |= VT1724_REVO_CS0;
> 	tmp |= VT1724_REVO_CS3;
> 	snd_ice1712_gpio_write(ice, tmp);
> 	udelay(1);
> 	snd_ice1712_restore_gpio_status(ice);
> }
>
> Provided that VT1724_REVO_CS0 is chip-select for AK4358 DAC and
> VT1724_REVO_CS3 chip-select for AK4114. The AK5385 ADC has no control.

CS0 (0x10) is GPIO4 and CS3 (0x80) is GPIO7, right?

Physically GPIO7 goes to CSN (pin 35) of the AK4114, as I confirmed before.

GPIO4 goes to CSN (pin 21) of the AK4358. I just did a physical check to 
confirm that also!

So I guess (hope) that would confirm that "VT1724_REVO_CS0 is 
chip-select for AK4358 DAC and
VT1724_REVO_CS3 chip-select for AK4114"

One question: What do you mean by "The AK5385 ADC has no control."? Is 
that by nature of the chip?


> IMO the ak4xxx config section should use VT1724_REVO_CS3 instead of
> VT1724_REVO_CS1 too:
>
> static struct snd_ak4xxx_private akm_ap192_priv = {
> 	.caddr = 2,
> 	.cif = 0,
> 	.data_mask = VT1724_REVO_CDOUT,
> 	.clk_mask = VT1724_REVO_CCLK,
> 	.cs_mask = VT1724_REVO_CS0 | VT1724_REVO_CS3,
> 	.cs_addr = VT1724_REVO_CS3,
> 	.cs_none = VT1724_REVO_CS0 | VT1724_REVO_CS3,
> 	.add_flags = VT1724_REVO_CCLK, /* high at init */
> 	.mask_flags = 0,
> };
>
> If I am not mistaken VT1724_REVO_CS1 is not used on ap192 at all. Is
> that correct?

That woud be GPIO5, right? I'm not sure. If this is the case, wouldn't 
that pin not be tied to some level (high or low)?


> Sorry for not using proper patches but I cannot test the result anyway.

No problem. I tested, but still no succes.. :(

I noticed one more thing:

VT1724_REVO_CDIN (GPIO2) goes to CDTO and
VT1724_REVO_CDOUT (GPIO3) goes to CDTI of the AK4114. "IN" is "O" and 
"OUT" is "I". Ist that correct? I tried to swap them once but that 
didn't help either.

- Jonas
