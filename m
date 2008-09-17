From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 11:06:54 -0400
Message-ID: <48D11D0E.90701@endrelia.com>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.pppoe.ca
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id DF19A24655
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 17:06:57 +0200 (CEST)
In-Reply-To: <20080917110530.GA7679@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> The only major issue I see with the patch is a documentation one: it's
> not clear to me reading the code how the atmel_ssc DAI driver relates to
> the existing at91_ssc driver.  It may be that this is something that's
> obvious to someone familiar with the at91 hardware but just looking at
> the code it's not clear to me what the difference is between the two and
> when each should be used.  
> 
> Looking at the code they appear to be similar to the point where they
> should be the same driver but it's entirely possible that I'm missing
> something here.  I've CCed in Frank Mandarino who did the existing AT91
> support.  If they should be separate drivers then some comments should
> be added in the driver and the Kconfig help text explaning the
> situation.

I agree that the drivers should be combined.  Unfortunately, at this
time I am unable to contribute to this effort.

>> +/*
>> + * Record SSC clock dividers for use in hw_params().
>> + */
>> +static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
>> +	int div_id, int div)
>> +{
>> +	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
>> +
>> +	switch (div_id) {
>> +	case AT91SSC_CMR_DIV:
>> +		/*
>> +		 * The same master clock divider is used for both
>> +		 * transmit and receive, so if a value has already
>> +		 * been set, it must match this value.
>> +		 */
>> +		if (ssc_p->cmr_div == 0)
>> +			ssc_p->cmr_div = div;
>> +		else
>> +			if (div != ssc_p->cmr_div)
>> +				return -EBUSY;
>> +		break;
> 
> What happens if the user wants to change the master clock divider at
> runtime - for example, when changing sample rates?

This is code from at91-ssc.c.  I really didn't consider the case of
changing the sample rate on an open substream.  This logic could be
updated to allow the new divider value if there is only one substream open.

> 
>> +		start_event = channels == 1
>> +				? 4
>> +				: 7;
> 
> This would be much clearer if it were expanded into multiple statements.

This was a little clearer in at91-ssc.c:

                start_event = channels == 1
                                ? AT91_SSC_START_FALLING_RF
                                : AT91_SSC_START_EDGE_RF;

Perhaps these constant definitions are no longer available it the latest
kernel.  Are there updated definitions to use instead of magic numbers?

Also, I'm fine with using multiple statements if that helps readability.

> 
>> +#ifdef CONFIG_PM
>> +#define atmel_ssc_suspend	NULL
>> +#define atmel_ssc_resume	NULL
>> +#else
>> +#define atmel_ssc_suspend	NULL
>> +#define atmel_ssc_resume	NULL
>> +#endif
> 
> These may as well be removed - if someone implements suspend/resume
> support they can add them then then.

Is there a reason that suspend/resume was removed?  It is really
important for embedded systems.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
