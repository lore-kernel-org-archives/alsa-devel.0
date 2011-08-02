From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH RESEND] ASoC: sgtl5000: fix cache handling
Date: Tue, 2 Aug 2011 21:11:44 +0100
Message-ID: <4E385A00.6060809@ti.com>
References: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D62DE1038D9
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 22:11:48 +0200 (CEST)
In-Reply-To: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng-B29396 <B29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 02/08/11 18:42, Wolfram Sang wrote:
> Cache handling in this driver is broken. The chip has 16-bit registers, yet the
> register numbers also increase by 2 per register, i.e.  there are only
> even-numbered registers. The cache in this driver, though, simply increments
> register numbers, so it does need some mapping as seen in
> sgtl5000_restore_regs(), note the '>> 1':
> 
> 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
>                         cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
> 
> That, of course, won't work with snd_soc_update_bits(). (Thus, we won't even
> notice the missing register 0x1c in the default regs which shifted all follwing
> registers to wrong values.) Noticed on the MX28EVK where enabling the regulators
> simply locked up the chip.
> 
> Refactor the routines and use a properly sized default_regs array which matches
> the register layout of the underlying chip, i.e. create a truly flat cache.
> This also saves some code which should make up for the bigger array a little.
> When soc-core will somewhen have another cache type which handles a step size,
> this conversion will also ease the transition.

This would probably be the preferred solution. I guess we can wait a little longer for this fix.

> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Tested-by: Dong Aisheng <b29396@freescale.com>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Zeng Zhaoming <b32542@freescale.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
