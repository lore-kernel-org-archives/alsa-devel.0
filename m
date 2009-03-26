From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2/2] alsa: s6105 IP camera machine	specific
	ASoC code
Date: Thu, 26 Mar 2009 14:26:40 +0000
Message-ID: <20090326142640.GE3771@sirena.org.uk>
References: <1238074574-24734-1-git-send-email-dg@emlix.com>
	<1238074574-24734-2-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DC57A103857
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2009 15:26:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238074574-24734-2-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl??ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 26, 2009 at 02:36:14PM +0100, Daniel Gl??ckner wrote:

> This patch adds machine specific code for the audio part of the Stretch
> s6105 IP camera reference design.

This looks mostly good, though some of the comments on the platform
support affect this driver too.  You should also check for current ASoC
APIs.

> +	/* set the codec system clock */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0, S6105_CODEC_CLOCK,
> +					    SND_SOC_CLOCK_OUT);

Are you sure you're applying the correct configuration to the correct
DAI here - S6105_CODEC_CLOCK is a CPU define, not a CODEC define?

> +static int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec, char *name,
> +				     int status)
> +{
> +	if (status)
> +		return snd_soc_dapm_enable_pin(codec, name);
> +	else
> +		return snd_soc_dapm_disable_pin(codec, name);
> +}

This shouldn't be in a driver!

> +	snd_soc_dapm_set_endpoint(codec, "Audio Out Differential", !val);
> +	snd_soc_dapm_set_endpoint(codec, "Audio Out Stereo", val);
> +	snd_soc_dapm_sync(codec);

Hrm.  Given the fact that you can't have the stereo and differential
outputs enabled simultaneously is it not safer to first disable the
active output, then sync, then enable the new output?
