From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] pxa2xx-i2s: Proper initialization
Date: Fri, 8 May 2009 11:29:53 +0100
Message-ID: <20090508102953.GB5654@sirena.org.uk>
References: <4A037483.6030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A01C24917
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 12:30:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A037483.6030602@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 01:53:39AM +0200, Karl Beldan wrote:

> Reset FIFO logic and registers, and make sure REC and RPL functions and
> FIFO service are disabled.

>  static int __init pxa2xx_i2s_init(void)
>  {
>  	clk_i2s = ERR_PTR(-ENOENT);
> +
> +	/*
> +	 * PXA Developer's Manual:
> +	 * If SACR0[ENB] is toggled in the middle of a normal operation,
> +	 * the SACR0[RST] bit must also be set and cleared to reset all
> +	 * I2S controller registers.
> +	 */
> +	SACR0 = SACR0_RST;
> +	SACR0 = 0;
> +	SACR1 = SACR1_DRPL | SACR1_DREC;
> +	SAIMR &= ~(SAIMR_RFS | SAIMR_TFS);

I'd expect this to happen when the driver is probed rather than when the
module is initialised.  Otherwise we'll end up writing to the hardware
if run on systems where it's not present - for example if a kernel has
both PXA2xx and PXA3xx support built in.
