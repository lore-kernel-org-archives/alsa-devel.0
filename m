From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] Add combined clock support to Atmel
	SoC audio
Date: Tue, 23 Nov 2010 23:29:44 +0000
Message-ID: <20101123232943.GA2726@opensource.wolfsonmicro.com>
References: <4CEC3A97.4040400@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 186C2103936
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 00:29:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CEC3A97.4040400@bluewatersys.com>
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

On Wed, Nov 24, 2010 at 11:05:11AM +1300, Ryan Mallon wrote:

> This patch is posted as RFC since the approach is incomplete and a bit
> hackish. I am mostly interested in knowing if this is a sensible
> approach, and could be cleaned up for mainline inclusion, or if there is
> a better way to do this.

This doesn't look obviously hideous.

It should set the symmetric_rates flag when going into combined clocks
mode.  A few other comments:

> +			if (atomic_dec_and_test(&ssc_p->substreams_running))
> +				ssc_writel(ssc_p->ssc->regs, CR,
> +					   dma_params->mask->ssc_disable);

It'd seem clearer to use a regular lock here; probably safer also as you
could get a race between the test and the write which tries to revert
the change - ie a:

	dec_and_test
			inc
			read
			write
	write

type pattern.

> +	if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_RX_ON_TX) {

How about just calling these defines ATMEL_SSC_CLOCK_TX or _RX?  You're
identifying the clock line to use for both cases, it's probably clearer
to say "use the RX lines" or "use the TX" lines than say "do one on the
other" if you see what I mean.

> +		/* RX clock is sourced from TK pin */
> +		rcmr &= ~SSC_BF(RCMR_CKS, 0x7);
> +		rcmr |=  SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);

Is this done by the driver normally, or is it done by the machine
normally?  If it's normally done by the machine perhaps it should be
moved into the driver in all cases.

> +		if (dir == 1) {
> +			/*
> +			 * Set the TX clock period to the RX clock period
> +			 * FIXME - Is this okay if we are already doing TX?
> +			 */
> +			tcmr &= 0x00ffffff;
> +			tcmr |= rcmr & 0xff000000;

Should probably enforce a constraint to stop users doing something that
forces the change?
