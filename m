From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux
	request
Date: Tue, 18 Aug 2009 07:56:49 +0300
Message-ID: <200908180756.49905.peter.ujfalusi@nokia.com>
References: <2256F256009DAA4CBE661E9F41EAC84B6E0D0103@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C39E24488
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 06:57:02 +0200 (CEST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B6E0D0103@dlee01.ent.ti.com>
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

On Monday 17 August 2009 21:48:27 ext Candelaria Villareal, Jorge wrote:
>   /* Set TWL4030 GPIO6 as EXTMUTE signal */
> - twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> -       TWL4030_MODULE_INTBR);
> + twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, &pin_mux,
         ^
I'm sure you wanted to have twl4030_i2c_read_u8 here.

> +      TWL4030_INTBR_PMBR1);
> + pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x3);
> + pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x2);

Using 0x03 and 0x02 looks better than 0x3/0x2...

> + twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
> +      TWL4030_INTBR_PMBR1);
>
>   ret = platform_device_add(sdp3430_snd_device);
>   if (ret)
