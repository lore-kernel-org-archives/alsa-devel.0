From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] Add Phytec i.MX sound support for AC97
Date: Wed, 10 Feb 2010 11:24:15 +0100
Message-ID: <20100210102415.GO17643@pengutronix.de>
References: <20100209101428.GG17643@pengutronix.de>
	<20100209195322.GA13437@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 75D6724385
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 11:24:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100209195322.GA13437@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2010 at 07:53:22PM +0000, Mark Brown wrote:
> On Tue, Feb 09, 2010 at 11:14:28AM +0100, Sascha Hauer wrote:
> 
> >  config SND_IMX_SOC
> >  	tristate "SoC Audio for Freecale i.MX CPUs"
> > -	depends on ARCH_MXC && BROKEN
> > +	depends on ARCH_MXC
> 
> BTW, this should not be here - we still need to wait for the arch/arm
> side of things to merge in before the drivers will work.

I added the corresponding files to my mxc-master branch and they should
show up on -next tomorrow. I removed the BROKEN in this patch because I
was sure that I add the files during this merge window and because it
shouldn't cause compile breakage in the mean time since the driver is
not selected in any config. But of course you are right, will do so
next time.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
