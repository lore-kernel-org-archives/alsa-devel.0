From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: SDP3430: Add support for EXTMUTE
	using TWL GPIO6
Date: Fri, 7 Aug 2009 08:52:16 +0300
Message-ID: <200908070852.16561.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
	<200908040958.15673.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 47FBC24334
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 07:52:25 +0200 (CEST)
In-Reply-To: <200908040958.15673.peter.ujfalusi@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "ext Candelaria Villareal,
	Jorge" <x0107209@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 04 August 2009 09:58:15 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On Wednesday 15 July 2009 04:04:08 ext Candelaria Villareal, Jorge wrote:
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

If you intend to change this, than GPIO6_PWM0_MUX sounds weird as well, in =
this =

way it should be GPIO6_PWM0_EXTMUTE_MUX, which not so nice...
TWL4030_GPIO6_MUX() seams much better...

-- =

P=E9ter
