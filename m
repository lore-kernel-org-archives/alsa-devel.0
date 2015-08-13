From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Thu, 13 Aug 2015 16:57:06 +0200
Message-ID: <55CCB042.7090100@metafoo.de>
References: <alpine.DEB.2.02.1508131428310.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCD1261A5A
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 16:57:08 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508131428310.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/13/2015 03:55 PM, Ricard Wanderlof wrote:
> +
> +#define ICS43432_RATE_MIN 7190 /* Hz, from data sheet */
> +#define ICS43432_RATE_MAX 52800  /* Hz, from data sheet */

If the part can work with continuous rates between those two values set
rate_min and rate_max in the DAI struct and set the rates field of the same
struct to SNDRV_PCM_RATE_CONTINUOUS.

> +
> +static int ics43432_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	unsigned int rate = params_rate(params);
> +
> +	if (rate < ICS43432_RATE_MIN || rate > ICS43432_RATE_MAX)
> +		return -EINVAL;

And then drop all of this. The ALSA core will take care of enforcing the
constraints.

> +
> +	return 0;
> +}
