From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH] Add combined clock support to Atmel
	SoC audio
Date: Wed, 24 Nov 2010 17:02:55 +1300
Message-ID: <4CEC8E6F.6070009@bluewatersys.com>
References: <4CEC3A97.4040400@bluewatersys.com>
	<20101123232943.GA2726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F5A0103936
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 05:01:51 +0100 (CET)
In-Reply-To: <20101123232943.GA2726@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sergey Lapin <slapin@ossfans.org>, gwossum@acm.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 11/24/2010 12:29 PM, Mark Brown wrote:
> On Wed, Nov 24, 2010 at 11:05:11AM +1300, Ryan Mallon wrote:
> 
>> This patch is posted as RFC since the approach is incomplete and a bit
>> hackish. I am mostly interested in knowing if this is a sensible
>> approach, and could be cleaned up for mainline inclusion, or if there is
>> a better way to do this.
> 
> This doesn't look obviously hideous.

Thanks :-)

> It should set the symmetric_rates flag when going into combined clocks
> mode.  A few other comments:
> 
>> +			if (atomic_dec_and_test(&ssc_p->substreams_running))
>> +				ssc_writel(ssc_p->ssc->regs, CR,
>> +					   dma_params->mask->ssc_disable);

Okay.

> It'd seem clearer to use a regular lock here; probably safer also as you
> could get a race between the test and the write which tries to revert
> the change - ie a:
> 
> 	dec_and_test
> 			inc
> 			read
> 			write
> 	write
>
> type pattern.

Okay, regular spin_lock should be okay right?

>> +	if (ssc_p->combined_clock == ATMEL_SSC_CLOCK_RX_ON_TX) {
> 
> How about just calling these defines ATMEL_SSC_CLOCK_TX or _RX?  You're
> identifying the clock line to use for both cases, it's probably clearer
> to say "use the RX lines" or "use the TX" lines than say "do one on the
> other" if you see what I mean.

Okay, will change.

> 
>> +		/* RX clock is sourced from TK pin */
>> +		rcmr &= ~SSC_BF(RCMR_CKS, 0x7);
>> +		rcmr |=  SSC_BF(RCMR_CKS, SSC_CKS_CLOCK);
>
> Is this done by the driver normally, or is it done by the machine
> normally?  If it's normally done by the machine perhaps it should be
> moved into the driver in all cases.

Essentially this code is overriding the settings in the hw_params switch
statement for the combined clocks case. This will need to be overridden
each time hw_params is called. Doing it here seems logical since
atmel_ssc_dai:hw_params does the original setting. It keeps the machine
drivers simpler too.

>> +		if (dir == 1) {
>> +			/*
>> +			 * Set the TX clock period to the RX clock period
>> +			 * FIXME - Is this okay if we are already doing TX?
>> +			 */
>> +			tcmr &= 0x00ffffff;
>> +			tcmr |= rcmr & 0xff000000;
> 
> Should probably enforce a constraint to stop users doing something that
> forces the change?

Okay. Could you point me at an example for this please.

Thanks,
~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
