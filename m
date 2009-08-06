From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: SDP3430: Add support for EXTMUTE
	using TWL GPIO6
Date: Thu, 6 Aug 2009 10:20:06 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B6DDD9926@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
	<200908040958.15673.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 11FC024574
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 17:20:14 +0200 (CEST)
In-Reply-To: <200908040958.15673.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> On Wednesday 15 July 2009 04:04:08 ext Candelaria Villareal, 
> Jorge wrote:
> > Board sdp3430 has hardware support for EXTMUTE using TWL4030 GPIO6
> > line, controlled by register INTBR_PMBR1. Machine driver takes care
> > of enabling gpio line through i2c and codec driver manipulates the
> > line during headset ramp up/down sequence.
> >
> > +#define TWL4030_INTBR_PMBR1	0x0D
> > +#define EXTMUTE(value)		(value << 2)
> 
> This is confusing, should it be something like this?:
> #define GPIO6_PWM0_MUX(value)		(value << 2)
> 
> > +	/* Set TWL4030 GPIO6 as EXTMUTE signal */
> > +	twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> > +							
> TWL4030_MODULE_INTBR);
> 
> I think you meant this:
> twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> 							
> TWL4030_INTBR_PMBR1);

You are right, I don't know how I missed that. I will change that.

> 
> Furthermore, since you are modifying pin muxing register, I 
> think it is safer 
> to do something like this here to avoid changing other pin's function:
> 
> u8 pin_mux;
> 
> twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
> 							
> TWL4030_INTBR_PMBR1);
> pin_mux &= ~GPIO6_PWM0_MUX(0x3);
> pin_mux |= GPIO6_PWM0_MUX(0x2);
> twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
> 							
> TWL4030_INTBR_PMBR1);

Since this patch is already on branch "for-2.6.32", should I submit a new patch for this changes?  Ir should I first revert and submit the modified patch?
