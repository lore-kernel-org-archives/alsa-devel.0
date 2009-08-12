From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Wed, 12 Aug 2009 20:17:24 +0200
Message-ID: <20090812181724.GZ19257@buzzloop.caiaq.de>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EF3C2245C6
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 20:17:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Daniel Ribeiro <drwyrm@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ok, I spent some time in debugging this again, and here are my
findings.

Again, to summarize what this is all about - what I need the code to
produce is the following output:

	- syncronous LRCLK
	- 64fs on I2SCLK
	- I2S data on the first 16bits of each LRCLK edge
	-> http://caiaq.de/download/tmp/2.png

So I applied all three patches and added the following call to my board
support code:

	snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, 16);

Which translates into "give me 2 slots with 16 bits each, and distribute
them over the timeline as a 0-1-0-1 pattern". Which is exactly what I
need, right?

But unfortunately, the code didn't make the SSP port do that. I ended up
having a asynchronous clock and the data somewhere where I wouldn't have
expected them: http://caiaq.de/download/tmp/1.png

I did some minor modifications to the patches 2/3 and 3/3 which made it
work for me eventually - find them inline.

Not sure whether I got the theory about the API right, and of course I
didn't test on any other hardware than the one I have.


On Thu, Aug 06, 2009 at 03:55:18PM +0100, Mark Brown wrote:
> * Automatically sets TDM mode for frame_width larger than 32 bits, if
>   the user doesn't setup the TDM slots with set_tdm_slot().
> * Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
> * Makes SSCR0_MOD optional.
> * Clears SSCR1_RWOT case SSCR0_MOD is set.
> 
> Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/pxa/pxa-ssp.c |   92 +++++++++++++++++++++++++++--------------------
>  1 files changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 5b9ed64..d60492e 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c

[...]

> @@ -532,48 +532,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
>  	struct ssp_priv *priv = cpu_dai->private_data;
>  	struct ssp_device *ssp = priv->dev.ssp;
>  	int chn = params_channels(params);
> -	u32 sscr0;
> -	u32 sspsp;
> +	u32 sscr0, sscr1, sspsp;
>  	int width = snd_pcm_format_physical_width(params_format(params));
> -	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
> +	int slot_width, frame_width = 0;
> +
> +	/* check if the user explicitly set a slot_width */
> +	sscr0 = ssp_read_reg(ssp, SSCR0);
> +
> +	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
> +		slot_width = (sscr0 & SSCR0_DSS) +
> +			(sscr0 & SSCR0_EDSS ? 17 : 1);
> +	else
> +		frame_width = slot_width = width * chn;
>  
>  	/* generate correct DMA params */
>  	if (cpu_dai->dma_data)
>  		kfree(cpu_dai->dma_data);
>  
> -	/* Network mode with one active slot (ttsa == 1) can be used
> -	 * to force 16-bit frame width on the wire (for S16_LE), even
> -	 * with two channels. Use 16-bit DMA transfers for this case.
> -	 */
> -	cpu_dai->dma_data = ssp_get_dma_params(ssp,
> -			((chn == 2) && (ttsa != 1)) || (width == 32),
> +	cpu_dai->dma_data = ssp_get_dma_params(ssp, slot_width > 16,
>  			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);

The condition for the width4 parameter needs to be
(slot_width * slots) > 16 for me. With that parameter set to 0, audio
plays at half speed on my system.

And in patch 3/3,


> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index d60492e..aac85fe 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c

[...]

> @@ -561,6 +543,59 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
>  		sscr0 |= SSCR0_FPCKE;
>  #endif
>  
> +	sspsp = ssp_read_reg(ssp, SSPSP);
> +	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		/*
> +		 * I2S and LEFT_J are stereo only, we have to send data for
> +		 * both channels.
> +		 */
> +		if (chn == 1)
> +			frame_width *= 2;
> +
> +		/*
> +		 * If the user did not use network mode, we assume the codec
> +		 * is I2S compliant.
> +		 */
> +		if (frame_width > 0) {
> +			sspsp |= SSPSP_SFRMWDTH(frame_width / 2);
> +			sspsp |= SSPSP_FSRT;
> +		} else {
> +			/*
> +			 * Otherwise we assume that it is a single TDM slot, and
> +			 * the user is abusing set_tdm_slot to support an
> +			 * out of spec codec.
> +			 */
> +			int slots = ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;
> +
> +			/* PXA2XX doesn't support DMYSTOP > 3 */
> +			if (slot_width != (width * 2) && !cpu_is_pxa3xx())
> +				return -EINVAL;
> +
> +			sspsp |= SSPSP_DMYSTRT(1);
> +			sspsp |= SSPSP_DMYSTOP(
> +					(slot_width * slots) / 2 - width - 1);
> +			sspsp |= SSPSP_SFRMWDTH((slot_width * slots) / 2);

These two calculations are wrong my case. What works here is

	sspsp |= SSPSP_DMYSTOP(
			(slot_width * slots * chn) / 2 - width - 1);
	sspsp |= SSPSP_SFRMWDTH((slot_width * slots * chn) / 2);

... which is another multiplication by factor 2. But I'm not sure if I
got the wrong variable with value 2 :)

I then end up having the following register contents:

	SSCR0 0xa10003ff
	SSCR1 0x00601d08
	SSPSP 0x31a00084
	SSACD 0x00000060
	SSTSA 0x00000003
	SSRSA 0x00000003

Daniel
