From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Thu, 31 Jan 2013 11:33:03 +0100
Message-ID: <510A485F.9060100@ivitera.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510670CC.2090904@ivitera.com> <5107188F.3060001@gmail.com>
 <510798CC.3080006@ivitera.com> <51081FA7.70907@gmail.com>
 <5108F541.3010300@ivitera.com> <5109BADB.30403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 493B826171C
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 11:33:02 +0100 (CET)
In-Reply-To: <5109BADB.30403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 31.1.2013 01:29, Jonas Petersen wrote:
> Am 30.01.2013 11:26, schrieb Pavel Hofman:
>> On 29.1.2013 20:14, Jonas Petersen wrote:
>>
> 
> Pavel, I applied your patch (including the correction in the other
> post). It did not work out of the box. I had to do a lot of debugging
> and changes to it to make it compile and then more of that fun to make
> it not crash alsa. 

Sorry, I did not test any compilation/running. The changes were rather
simple though. Thanks for sorting out.
> 
> When it finally compiled and was running, I had an ak4114 file in proc.
> 
> Unfortunately it's full of 0x00's:
> 
> /proc/asound/Audiophile192/ak4114:
> 
> 0x00 = 0x00
> 0x02 = 0x00
> [...]
> 0x1e = 0x00
> 0x1f = 0x00
> 
> (32 lines total)
> 
> There is also no change in the spdif capture behaviour.

OK, it looks we have a problem in communication with the chip. IMO the
4wire_start and 4wire_finish code is incorrect. As chip-select it takes
VT1724_REVO_CS1, but for ak4114 it should be VT1724_REVO_CS3 (as defined
in revo.h)

IMO the two methods should be:
static unsigned int ap192_4wire_start(struct snd_ice1712 *ice)
{
	unsigned int tmp;

	snd_ice1712_save_gpio_status(ice);
	tmp = snd_ice1712_gpio_read(ice);
	tmp |= VT1724_REVO_CCLK; /* high at init */
	tmp |= VT1724_REVO_CS0;
	tmp &= ~VT1724_REVO_CS3;
	snd_ice1712_gpio_write(ice, tmp);
	udelay(1);
	return tmp;
}

static void ap192_4wire_finish(struct snd_ice1712 *ice, unsigned int tmp)
{
	tmp |= VT1724_REVO_CS0;
	tmp |= VT1724_REVO_CS3;
	snd_ice1712_gpio_write(ice, tmp);
	udelay(1);
	snd_ice1712_restore_gpio_status(ice);
}

Provided that VT1724_REVO_CS0 is chip-select for AK4358 DAC and
VT1724_REVO_CS3 chip-select for AK4114. The AK5385 ADC has no control.


IMO the ak4xxx config section should use VT1724_REVO_CS3 instead of
VT1724_REVO_CS1 too:

static struct snd_ak4xxx_private akm_ap192_priv = {
	.caddr = 2,
	.cif = 0,
	.data_mask = VT1724_REVO_CDOUT,
	.clk_mask = VT1724_REVO_CCLK,
	.cs_mask = VT1724_REVO_CS0 | VT1724_REVO_CS3,
	.cs_addr = VT1724_REVO_CS3,
	.cs_none = VT1724_REVO_CS0 | VT1724_REVO_CS3,
	.add_flags = VT1724_REVO_CCLK, /* high at init */
	.mask_flags = 0,
};

If I am not mistaken VT1724_REVO_CS1 is not used on ap192 at all. Is
that correct?

Sorry for not using proper patches but I cannot test the result anyway.


Thanks,

Pavel.
