From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: imx-ssi in master mode?
Date: Fri, 27 Aug 2010 13:54:16 +0200
Message-ID: <20100827115416.GD1473@pengutronix.de>
References: <4C768708.50903@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9944A245AE
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 13:54:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C768708.50903@googlemail.com>
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

On Thu, Aug 26, 2010 at 05:23:53PM +0200, Sven Zeisberg wrote:
>   Hi
> 
> I found that the i.MX25 can not transfer multichannels frames through 
> SSI when it is set up as slave.
> (when the i.MX25 SSI is set up as slave, the SSI is set to "normal" mode 
> in which only one word per frame is transfered)
> 
> Now I'm wondering if anybody has successfully used a codec with the 
> i.MX25 SSI set up as Master. When we do this here, we can see that the 
> i.MX25 is generating the bit clock but no frame sync.

Master mode is currently not supported by the i.MX driver. You'd have to
implement the clk_get_rate functions for the ssi clocks first before
implementing the missing pieces in the driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
