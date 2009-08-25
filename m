From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: SDP3430: Fix TWL GPIO6 pin mux
	request
Date: Tue, 25 Aug 2009 10:07:07 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B72A1D832@dlee01.ent.ti.com>
References: <2256F256009DAA4CBE661E9F41EAC84B72A1D4E3@dlee01.ent.ti.com>
	<200908251254.56895.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 77E16244F4
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 17:07:15 +0200 (CEST)
In-Reply-To: <200908251254.56895.peter.ujfalusi@nokia.com>
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

> On Tuesday 25 August 2009 03:04:50 ext Candelaria Villareal, 
> Jorge wrote:
> > Fix the write to PMBR1 register through I2C. Also, the 
> constant which
> > holds the value to write is now called TWL4030_GPIO6_PWM0_MUTE. This
> > name is based on TRM to avoid confusion.
> >
> > Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>
> 
> >   /* Set TWL4030 GPIO6 as EXTMUTE signal */
> > - twl4030_i2c_write_u8(TWL4030_MODULE_INTBR, EXTMUTE(0x02),
> > -       TWL4030_MODULE_INTBR);
> > + twl4030_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
> > +      TWL4030_INTBR_PMBR1);
> > + pin_mux &= ~TWL4030_GPIO6_PWM0_MUTE(0x3);
> > + pin_mux |= TWL4030_GPIO6_PWM0_MUTE(0x2);
> 
> I still think that using 0x03/0x02 instead of 0x3/0x2 looks better,
> but otherwise I see no problem with the patch.

I had forgot about doing this change. Mark found an issue with my patch,
so I will be resending again with the 0x03/0x02, since it does help code
look cleaner.

> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> 
