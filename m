From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Updates to EVM hardware
	params callback
Date: Tue, 26 Jan 2010 11:14:15 +0000
Message-ID: <20100126111415.GK15759@rakim.wolfsonmicro.main>
References: <1263987161-29657-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB81D1038C3
	for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2010 12:14:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263987161-29657-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2010 at 05:02:41PM +0530, Chaithrika U S wrote:

> @@ -64,9 +64,11 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  
>  	/* set codec DAI configuration */
> -	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
> -	if (ret < 0)
> -		return ret;
> +	if (codec_dai->ops->set_fmt) {
> +		ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
> +		if (ret < 0)
> +			return ret;
> +	}

It would be better to have separate hw_params() functions for separate
links rather than do things like this.  There's a strong expectation
that the board driver knows exactly what CODEC it's talking to and how
to configure it so code like this looks odd.
