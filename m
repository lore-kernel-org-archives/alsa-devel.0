From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: soc-core: check rate for
 symmetry only when pcm is ongoing
Date: Wed, 24 Aug 2011 10:19:03 +0100
Message-ID: <20110824091902.GR9232@opensource.wolfsonmicro.com>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 615C024962
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 11:19:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314172640-26972-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 03:57:20PM +0800, Dong Aisheng wrote:

> Now we only check rate for symmetry when the pcm is really ongoing
> which seems more sensible.

There's a genuine issue here due to the raciness of the ALSA APIs -
we're not enforcing constraints and we should be.  If the two programs
end up setting incompatible rates we need to handle that.

>  	/* Symmetry data - only valid if symmetry is being enforced */
>  	unsigned int rate;
> +	unsigned int ongoing;

This isn't a clear name, I don't understand it.

> @@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>  	cpu_dai->active++;
>  	codec_dai->active++;
>  	rtd->codec->active++;
> +	rtd->ongoing = 1;
>  	mutex_unlock(&rtd->pcm_mutex);
>  	return 0;
>  
> @@ -322,6 +326,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>  			SND_SOC_DAPM_STREAM_STOP);
>  	}
>  
> +	rtd->ongoing = 0;

What happens when the stream in one direction is stopped but not the
other?  For example, capture stops but playback continues.
