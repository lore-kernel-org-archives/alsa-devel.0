From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC_ii/iv 3/3] ASoC: Extend DAPM to handle power
 changes on cross-device paths
Date: Fri, 29 Oct 2010 14:03:10 -0700
Message-ID: <20101029210309.GI3921@opensource.wolfsonmicro.com>
References: <1288353742-22005-1-git-send-email-jhnikula@gmail.com>
	<1288353742-22005-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73A3110386B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 23:03:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1288353742-22005-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 29, 2010 at 03:02:22PM +0300, Jarkko Nikula wrote:

> Functions dapm_seq_run and dapm_seq_run_coalesced are modified so that a new
> write is issued when the sequence extends to an another device and DAPM
> context of a widget instead of originating DAPM context is used when doing
> pop waits and register writes.

I'm having a hard time parsing this bit of the changelog, I'm afraid.
What I'd expect is that the comparison operation used for coalescing
would be extended to compare based on the CODEC/DAPM context too and the
split per device should naturally fall out of that.  I didn't notice the
comparison being updated?

Otherwise this looks pretty good, these are stylistic things:

>  		/* power down pre event */
>  		if (!w->power && w->event &&
>  		    (w->event_flags & SND_SOC_DAPM_PRE_PMD)) {
> -			pop_dbg(dapm->pop_time, "pop test : %s PRE_PMD\n",
> +			pop_dbg(w->dapm->pop_time, "pop test : %s PRE_PMD\n",
>  				w->name);

We probably need to start putting the dev_names in these.

>  			if (power)
> -				sys_power = 1;
> +				w->dapm->sys_power = 1;

sys_power needs to be renamed - probably dev_power or something.

> -	/* If we're changing to all on or all off then prepare */
> -	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
> -	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
> -		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
> -		if (ret != 0)
> -			pr_err("Failed to prepare bias: %d\n", ret);
> +		/* If we're changing to all on or all off then prepare */
> +		if ((d->sys_power && d->bias_level == SND_SOC_BIAS_STANDBY) ||
> +		    (!d->sys_power && d->bias_level == SND_SOC_BIAS_ON)) {
> +			ret = snd_soc_dapm_set_bias_level(card, d, SND_SOC_BIAS_PREPARE);
> +			if (ret != 0)
> +				pr_err("Failed to prepare bias: %d\n", ret);
> +		}

We can switch these over to dev_ prints now, I think.
