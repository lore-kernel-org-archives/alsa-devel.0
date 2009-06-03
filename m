From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC codec: SSM2602: assign
	last	substream to the master when shutting down
Date: Wed, 3 Jun 2009 11:52:23 +0100
Message-ID: <20090603105223.GE11507@sirena.org.uk>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 58FCB24402
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 12:52:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243916337-29953-2-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 12:18:54AM -0400, Mike Frysinger wrote:

> -		snd_pcm_hw_constraint_minmax(substream->runtime,
> -					     SNDRV_PCM_HW_PARAM_RATE,
> -					     master_runtime->rate,
> -					     master_runtime->rate);
> -
> -		snd_pcm_hw_constraint_minmax(substream->runtime,
> -					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> -					     master_runtime->sample_bits,
> -					     master_runtime->sample_bits);
> +		if (master_runtime->rate != 0)
> +			snd_pcm_hw_constraint_minmax(substream->runtime,
> +						     SNDRV_PCM_HW_PARAM_RATE,
> +						     master_runtime->rate,
> +						     master_runtime->rate);

> +
> +		if (master_runtime->sample_bits != 0)
> +			snd_pcm_hw_constraint_minmax(substream->runtime,
> +						     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> +						     master_runtime->sample_bits,
> +						     master_runtime->sample_bits);

This change is entirely unrelated to your changelog and should have been
submitted as a separate patch.  It's preventing the use of the
configuration from an unconfigured master which isn't what the patch is
about).  It's also going over the 80 column limit.

For the rate constraint you should switch to using the symmetric_rates 
flag in the DAI which implements the equivalent constraints with no
per-driver code.

However, given that this fix has missed two kernel releases due to the
very slow rate of responses to review comments I've applied it so users
get the benefit of the bug fix.  Things would go more smoothly if you
could get new versions of patches submitted faster after the original
review.
