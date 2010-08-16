From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Problem to init AD1938 on i.MX25
Date: Mon, 16 Aug 2010 10:47:38 +0200
Message-ID: <20100816084738.GK27749@pengutronix.de>
References: <4C68C3C5.5030701@googlemail.com>
	<20100816073040.GH27749@pengutronix.de>
	<4C68F94C.8090703@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CB02C10380C
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 10:47:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C68F94C.8090703@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sven Zeisberg <sven.zeisberg@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please do not top post.

On Mon, Aug 16, 2010 at 10:39:40AM +0200, Sven Zeisberg wrote:
>  Thank you, Sascha, for helping!
>
> You're probably right - there is actually no "i.MX25" path in the SPI  
> driver!

Yes, there is. See this block in the probe function:

	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
		spi_imx->intctrl = mx31_intctrl;
		spi_imx->config = mx31_config;
		spi_imx->trigger = mx31_trigger;
		spi_imx->rx_available = mx31_rx_available;
	} else  if (cpu_is_mx27() || cpu_is_mx21()) {
		spi_imx->intctrl = mx27_intctrl;
		spi_imx->config = mx27_config;
		spi_imx->trigger = mx27_trigger;
		spi_imx->rx_available = mx27_rx_available;
	} else if (cpu_is_mx1()) {
		spi_imx->intctrl = mx1_intctrl;
		spi_imx->config = mx1_config;
		spi_imx->trigger = mx1_trigger;
		spi_imx->rx_available = mx1_rx_available;
	} else
		BUG();

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
