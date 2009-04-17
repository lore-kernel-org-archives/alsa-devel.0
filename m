From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix for the
	constraint	handling
Date: Fri, 17 Apr 2009 15:26:42 +0100
Message-ID: <20090417142642.GD10992@sirena.org.uk>
References: <1239972908-4158-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239972908-4158-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CED06243A9
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 16:26:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239972908-4158-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2009 at 03:55:08PM +0300, Peter Ujfalusi wrote:

> +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +				SNDRV_PCM_HW_PARAM_RATE,
> +				twl4030->rate,
> +				twl4030->rate);

You did note this yourself but there's support for this in the core;
it'd be good to switch over to that (and push handling for the other
constraints into core).

> +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
> +				twl4030->sample_bits,
> +				twl4030->sample_bits);
> +
> +	snd_pcm_hw_constraint_minmax(slv_substream->runtime,
> +				SNDRV_PCM_HW_PARAM_CHANNELS,
> +				twl4030->channels,
> +				twl4030->channels);

Are you sure that these need to match exactly and don't set maxima?

Your overall approach in the patch looks good so I'll apply it - it's
an improvement on the current situation.
