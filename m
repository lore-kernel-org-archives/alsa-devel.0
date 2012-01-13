From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
Date: Fri, 13 Jan 2012 06:21:00 +0000
Message-ID: <7FE21149F4667147B645348EC605788508FBC9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
	<20120112222759.GA23716@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id ACDB02414B
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 07:21:05 +0100 (CET)
In-Reply-To: <20120112222759.GA23716@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Julia Lawall <julia.lawall@lip6.fr>, Fabio Estevam <festevam@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>, "zengzm.kernel@gmail.com" <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Friday, January 13, 2012 6:28 AM
> To: Julia Lawall; Fabio Estevam; Wolfram Sang; Dong Aisheng-B29396; Shawn Guo
> Cc: lrg@ti.com; alsa-devel@alsa-project.org
> Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
> Importance: High
> 
> On Thu, Jan 12, 2012 at 10:13:24PM +0100, Julia Lawall wrote:
> > There is a duplicated test in the function sgtl5000_restore_regs in
> > the file sound/soc/codecs/sgtl5000.c:
> 
> >                /* this regs depends on the others */
> >                 if (reg == SGTL5000_CHIP_ANA_POWER ||
> >                         reg == SGTL5000_CHIP_CLK_CTRL ||
> >                         reg == SGTL5000_CHIP_LINREG_CTRL ||
> >                         reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
> >                         reg == SGTL5000_CHIP_CLK_CTRL)
> >                         continue;
> 
> > I don't know if some constant other than SGTL5000_CHIP_CLK_CTRL should
> > be tested, or if the second test should just be deleted.
> 
> Adding the people who've been working on the driver.  Generally this is a good
> idea when reporting issues like this.
Cc Zhaoming.

Looking at the code, I guess it's a typo error and the second check should be
SGTL5000_CHIP_REF_CTRL since it will restore it again.

Hi Mark,
Since zhaoming leaved Freescale a few month ago,
would you mind if I send a patch to add my name under MODULE_AHTOER as
Co-maintainer for this driver and update Zhaoming's email address?

Regards
Dong Aisheng
