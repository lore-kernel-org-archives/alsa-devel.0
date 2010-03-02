From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 2/4] ASoC: core: Add delay operation
	to	snd_soc_dai_ops
Date: Tue, 2 Mar 2010 13:45:08 +0000
Message-ID: <20100302134508.GD10658@sirena.org.uk>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AD271038DF
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:45:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1267537191-25254-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 03:39:49PM +0200, Peter Ujfalusi wrote:

> +	/* Query the delay only for playback stream */
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		if (cpu_dai->ops->delay)
> +			delay += cpu_dai->ops->delay(substream, cpu_dai);
> +
> +		if (codec_dai->ops->delay)
> +			delay += codec_dai->ops->delay(substream, codec_dai);
> +
> +		runtime->delay = delay;
> +	}

I'd be inclined to leave this up to the drivers to avoid surprises if it
becomes useful for the capture case in the future.  Not sure that that's
likely, but I'd rather avoid potential future transitions.
