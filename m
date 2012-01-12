From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
Date: Thu, 12 Jan 2012 22:28:02 +0000
Message-ID: <20120112222759.GA23716@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6BF7243B0
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 23:28:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>, Fabio Estevam <festevam@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 12, 2012 at 10:13:24PM +0100, Julia Lawall wrote:
> There is a duplicated test in the function sgtl5000_restore_regs in the  
> file sound/soc/codecs/sgtl5000.c:

>                /* this regs depends on the others */
>                 if (reg == SGTL5000_CHIP_ANA_POWER ||
>                         reg == SGTL5000_CHIP_CLK_CTRL ||
>                         reg == SGTL5000_CHIP_LINREG_CTRL ||
>                         reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
>                         reg == SGTL5000_CHIP_CLK_CTRL)
>                         continue;

> I don't know if some constant other than SGTL5000_CHIP_CLK_CTRL should be 
> tested, or if the second test should just be deleted.

Adding the people who've been working on the driver.  Generally this is
a good idea when reporting issues like this.
