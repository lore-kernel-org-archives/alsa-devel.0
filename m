From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/7] ASoC: i.MX31ads: initialize only on
	correct machine
Date: Fri, 5 Nov 2010 10:16:24 +0100
Message-ID: <20101105091624.GS6017@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
	<1288886745-25977-2-git-send-email-s.hauer@pengutronix.de>
	<20101104185136.GG6088@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B81FD2433C
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 10:16:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101104185136.GG6088@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 04, 2010 at 02:51:36PM -0400, Mark Brown wrote:
> On Thu, Nov 04, 2010 at 05:05:39PM +0100, Sascha Hauer wrote:
> 
> > +	if (!machine_is_mx31ads())
> > +		return 0;
> > +
> 
> As previously discussed we need a better check than this - most of these
> machines won't have a 1133-EV1 PMIC module on them.  Better to convert
> the driver to instantiate from a platform device...

This does not solve the problem as we do not know when to register the
platform_device. I think what we need is a kernel parameter which can be
used to select the correct path in arch/arm/mach-mx3/mach-mx31ads.c
aswell. I will look into it. For now, can we just take this patch? It
at least fixes all other i.MX31 boards and leaves only the mx31ads to
work on.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
