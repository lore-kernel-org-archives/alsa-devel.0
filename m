From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 16:21:44 +0100
Message-ID: <20080917152143.GC7679@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B802224654
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 17:21:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48D11D0E.90701@endrelia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Mandarino <fmandarino@endrelia.com>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 17, 2008 at 11:06:54AM -0400, Frank Mandarino wrote:
> Mark Brown wrote:

> >> +
> >> +	switch (div_id) {
> >> +	case AT91SSC_CMR_DIV:
> >> +		/*
> >> +		 * The same master clock divider is used for both
> >> +		 * transmit and receive, so if a value has already
> >> +		 * been set, it must match this value.
> >> +		 */
> >> +		if (ssc_p->cmr_div == 0)
> >> +			ssc_p->cmr_div = div;
> >> +		else
> >> +			if (div != ssc_p->cmr_div)
> >> +				return -EBUSY;
> >> +		break;

> > What happens if the user wants to change the master clock divider at
> > runtime - for example, when changing sample rates?

> This is code from at91-ssc.c.  I really didn't consider the case of
> changing the sample rate on an open substream.  This logic could be
> updated to allow the new divider value if there is only one substream open.

Ah, right - on further inspection I see that cmr_div is reset when the
stream is shut down.  That's fine since it means that the clocks can be
reconfigured when reopening the device which is the case I was worried
about.

Changing the dividers on an active stream is unlikely to work well so
it's perfectly reasonable to not support it.

> >> +		start_event = channels == 1
> >> +				? 4
> >> +				: 7;

> > This would be much clearer if it were expanded into multiple statements.
> 
> This was a little clearer in at91-ssc.c:

>                 start_event = channels == 1
>                                 ? AT91_SSC_START_FALLING_RF
>                                 : AT91_SSC_START_EDGE_RF;

> Perhaps these constant definitions are no longer available it the latest
> kernel.  Are there updated definitions to use instead of magic numbers?

> Also, I'm fine with using multiple statements if that helps readability.

I wasn't so worried about the magic numbers as the combination of
assignment and an equality test without even any brackets.  I can see
what's going on but it's certainly not the most transparent way of
writing it.

> > These may as well be removed - if someone implements suspend/resume
> > support they can add them then then.

> Is there a reason that suspend/resume was removed?  It is really
> important for embedded systems.

Yeah, I did wonder, though there are plenty of embedded systems that
aren't particular power sensitive for one reason or another.
