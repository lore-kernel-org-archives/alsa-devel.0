From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: SDP3430: Add support for EXTMUTE
	using TWL GPIO6
Date: Tue, 4 Aug 2009 09:58:15 +0300
Message-ID: <200908040958.15673.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E6946245B4
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 08:58:26 +0200 (CEST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
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
To: "ext Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 15 July 2009 04:04:08 ext Candelaria Villareal, Jorge wrote:
> Board sdp3430 has hardware support for EXTMUTE using TWL4030 GPIO6
> line, controlled by register INTBR_PMBR1. Machine driver takes care
> of enabling gpio line through i2c and codec driver manipulates the
> line during headset ramp up/down sequence.
>
> +#define TWL4030_INTBR_PMBR1	0x0D
> +#define EXTMUTE(value)		(value << 2)

This is confusing, should it be something like this?:
#define GPIO6_PWM0_MUX(value)		(value << 2)

> +	/* Set TWL4030 GPIO6 as EXTMUTE signal */
> +	twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> +							TWL4030_MODULE_INTBR);

I think you meant this:
twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
							TWL4030_INTBR_PMBR1);

Furthermore, since you are modifying pin muxing register, I think it is saf=
er =

to do something like this here to avoid changing other pin's function:

u8 pin_mux;

twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
							TWL4030_INTBR_PMBR1);
pin_mux &=3D ~GPIO6_PWM0_MUX(0x3);
pin_mux |=3D GPIO6_PWM0_MUX(0x2);
twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
							TWL4030_INTBR_PMBR1);


-- =

P=E9ter
