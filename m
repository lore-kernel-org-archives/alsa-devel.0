From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] Add combined clock support to Atmel
	SoC audio
Date: Wed, 24 Nov 2010 12:58:41 +0000
Message-ID: <20101124125841.GD24970@rakim.wolfsonmicro.main>
References: <4CEC3A97.4040400@bluewatersys.com>
	<20101123232943.GA2726@opensource.wolfsonmicro.com>
	<4CEC8E6F.6070009@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3120A2460A
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 13:58:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CEC8E6F.6070009@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sergey Lapin <slapin@ossfans.org>, gwossum@acm.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 05:02:55PM +1300, Ryan Mallon wrote:

> Okay, regular spin_lock should be okay right?

I guess, though something like a mutex would seem more normal.

> > Is this done by the driver normally, or is it done by the machine
> > normally?  If it's normally done by the machine perhaps it should be
> > moved into the driver in all cases.

> Essentially this code is overriding the settings in the hw_params switch
> statement for the combined clocks case. This will need to be overridden
> each time hw_params is called. Doing it here seems logical since
> atmel_ssc_dai:hw_params does the original setting. It keeps the machine
> drivers simpler too.

That's my point - if the machine drivers normally need to do this
(sam9g20ek certainly needed to configure the pinmux) then we should just
be doing this all the time.

> >> +		if (dir == 1) {
> >> +			/*
> >> +			 * Set the TX clock period to the RX clock period
> >> +			 * FIXME - Is this okay if we are already doing TX?
> >> +			 */
> >> +			tcmr &= 0x00ffffff;
> >> +			tcmr |= rcmr & 0xff000000;

> > Should probably enforce a constraint to stop users doing something that
> > forces the change?

> Okay. Could you point me at an example for this please.

symmetric_rates probably covers it.
