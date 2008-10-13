From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Mon, 13 Oct 2008 15:34:08 +0100
Message-ID: <20081013143407.GA20516@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<48F3598E.3050404@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D77DF244F8
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Oct 2008 16:34:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F3598E.3050404@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: ext-jukka.hynninen@vaisala.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 13, 2008 at 04:22:06PM +0200, Sedji Gaouaou wrote:
> ext-jukka.hynninen@vaisala.com a ?crit :

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

> What happens if the user wants to change the master clock divider at
> runtime - for example, when changing sample rates?

Usually you'd end up using constraints to prevent user space selecting a
different sample rate if it wasn't possible to change safely.
