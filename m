From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXT_MUTE gpio to reduce
 pop-noise effect
Date: Fri, 26 Jun 2009 17:02:38 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B4AA15AAF@dlee01.ent.ti.com>
References: <1245896733-3973-1-git-send-email-x0107209@ti.com>
	<200906251103.38818.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 555EB244BE
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Jun 2009 00:02:48 +0200 (CEST)
In-Reply-To: <200906251103.38818.peter.ujfalusi@nokia.com>
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

> In order to use the TWL GPIO6 for extmute, the 
> PMBR1:GPIO6_PWM0_MUTE should be 
> set to 0x2 initially in TWL, but this is not the job of the 
> codec driver (it 
> is platform specific how this pin is used).

You mention this is platform specific, but shouldn't twl4030
registers be accesed only by twl4030 drivers? 

What if codec driver sets the register only when instructed by
the machine driver. Something like:

if (setup->hs_extmute && !(setup->set_hs_extmute))
	twl4030_i2c_write_u8(TWL4030_MODULE_INTBR,
			0x02 << 2, TWL4030_REG_PMBR1);

But it still looks like it should'nt be in the codec driver. Any
idea on how to do this?
