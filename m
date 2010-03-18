From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai
 to snd_soc_pcm_stream
Date: Thu, 18 Mar 2010 18:22:11 +0000
Message-ID: <20100318182211.GH6142@rakim.wolfsonmicro.main>
References: <1268933737.3773.36.camel@odin>
	<1268935739-2931-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AB6A1038A2
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 19:22:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268935739-2931-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Michael Hirsch <m.hirsch@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 07:08:59PM +0100, Daniel Mack wrote:
> This fixes a memory corruption when using ASoC devices are used in
> full-duplex mode. Specifically for pxa-ssp code, where this pointer
> is dynamically allocated for each direction and destroyed upon each
> stream start.

> All other platforms are fixed blindly, I couldn't even compile-test
> them. Sorry for any breakage I may have caused.

Looks good at first pass, though I think there's some more platforms
have been missed?  I'm just about to leave for today, Liam and I will
check properly tomorrow.  Thanks for diagnosing this!

> +static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
> +					     const struct snd_pcm_substream *ss)
> +{
> +	return (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +		dai->playback.dma_data : dai->capture.dma_data;
> +}
> +
> +static inline void snd_soc_dai_set_dma_data(struct snd_soc_dai *dai,
> +					    const struct snd_pcm_substream *ss,
> +					    void *data)
> +{
> +	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		dai->playback.dma_data = data;
> +	else
> +		dai->capture.dma_data = data;
> +}

Make your mind up if you like the ternery operator :P
