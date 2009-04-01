From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2] tlv320aic3x: disable ADC/DAC while
	changing clock
Date: Wed, 1 Apr 2009 13:10:33 +0100
Message-ID: <20090401121032.GA21294@sirena.org.uk>
References: <1238073706-23821-1-git-send-email-dg@emlix.com>
	<1238583415-19543-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DD35624345
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 14:10:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238583415-19543-1-git-send-email-dg@emlix.com>
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

On Wed, Apr 01, 2009 at 12:56:55PM +0200, Daniel Gl??ckner wrote:

> +static int aic3x_trigger(struct snd_pcm_substream *substream, int cmd,
> +                        struct snd_soc_dai *codec_dai)
> +{
> +       struct snd_soc_codec *codec = codec_dai->codec;
> +       struct aic3x_priv *aic3x = codec->private_data;
> +
> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               aic3x->running[substream->stream] = 1;
> +               break;

Hrm, does the chip support asymmetric configurations for playback and
capture?

> +/*
> + * Enables or disables the left/right ADC/DAC according to new.
> + * Bits in new:
> + *	0 left ADC
> + *	1 right ADC
> + *	2 left DAC
> + *	4 right DAC
> + * A set bit enables the component.
> + * Returns the previous state of those components encoded in the same way.
> + */

Is this really required?  I can't see it being a good idea to bounce the
power of the DAC or ADC while they are live since that will impact the
audio stream noticably.  It looks like it'd be better to do a check
which refuses to do the reconfiguration when it's not possible.

It's especially suspicious since the power of the DAC and ADC is managed
via DAPM; the only current user should be safe since it saves then
restores the state but it does raise alarm bells.

>  	case SND_SOC_BIAS_OFF:
> -		/* force all power off */
> -		reg = aic3x_read_reg_cache(codec, LINE1L_2_LADC_CTRL);
> -		aic3x_write(codec, LINE1L_2_LADC_CTRL, reg & ~LADC_PWR_ON);

This should be split into a separate patch; it's a separate change.
