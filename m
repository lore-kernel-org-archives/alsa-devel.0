From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: SDP3430: Add support for EXTMUTE
 using TWL GPIO6
Date: Fri, 7 Aug 2009 10:33:09 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B6DDDA396@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
	<200908040958.15673.peter.ujfalusi@nokia.com>
	<200908070852.16561.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CF79B1038AB
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 17:33:20 +0200 (CEST)
In-Reply-To: <200908070852.16561.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

 

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] 
> Sent: Friday, August 07, 2009 12:52 AM
> To: alsa-devel@alsa-project.org
> Cc: Candelaria Villareal, Jorge; broonie@opensource.wolfsonmicro.com
> Subject: Re: [alsa-devel] [PATCH] ASoC: SDP3430: Add support 
> for EXTMUTE using TWL GPIO6
> 
> On Tuesday 04 August 2009 09:58:15 Ujfalusi Peter 
> (Nokia-D/Tampere) wrote:
> > On Wednesday 15 July 2009 04:04:08 ext Candelaria 
> Villareal, Jorge wrote:
> > > Board sdp3430 has hardware support for EXTMUTE using TWL4030 GPIO6
> > > line, controlled by register INTBR_PMBR1. Machine driver 
> takes care
> > > of enabling gpio line through i2c and codec driver manipulates the
> > > line during headset ramp up/down sequence.
> > >
> > > +#define TWL4030_INTBR_PMBR1	0x0D
> > > +#define EXTMUTE(value)		(value << 2)
> >
> > This is confusing, should it be something like this?:
> > #define GPIO6_PWM0_MUX(value)		(value << 2)
> 
> If you intend to change this, than GPIO6_PWM0_MUX sounds 
> weird as well, in this 
> way it should be GPIO6_PWM0_EXTMUTE_MUX, which not so nice...
> TWL4030_GPIO6_MUX() seams much better...
> 

How about naming the field as it is named in TRM, GPIO6_PWM0_MUTE.

That way, if there is any confusion TWL4030 TRM should be able to
clear any doubts. Also, it states clearly whicho mode correspond to
each value.
