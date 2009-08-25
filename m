From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux
	request
Date: Tue, 25 Aug 2009 12:54:56 +0300
Message-ID: <200908251254.56895.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B72A1D4E3@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CDA32441E
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 11:55:14 +0200 (CEST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B72A1D4E3@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 25 August 2009 03:04:50 ext Candelaria Villareal, Jorge wrote:
> Fix the write to PMBR1 register through I2C. Also, the constant which
> holds the value to write is now called TWL4030_GPIO6_PWM0_MUTE. This
> name is based on TRM to avoid confusion.
>
> Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>

>   /* Set TWL4030 GPIO6 as EXTMUTE signal */
> - twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> -       TWL4030_MODULE_INTBR);
> + twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
> +      TWL4030_INTBR_PMBR1);
> + pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x3);
> + pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x2);

I still think that using 0x03/0x02 instead of 0x3/0x2 looks better,
but otherwise I see no problem with the patch.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
