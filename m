From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl: imx-wm8962: Grant hw_params/free()
 permission to control FLL
Date: Tue, 10 Dec 2013 13:18:42 +0800
Message-ID: <20131210051740.GA10655@MrMyself>
References: <cover.1386344000.git.b42378@freescale.com>
 <105d07ac1a77bf99872d75608c97b3342079bfb7.1386344000.git.b42378@freescale.com>
 <20131209175640.GL29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131209175640.GL29268@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 09, 2013 at 05:56:40PM +0000, Mark Brown wrote:
> On Fri, Dec 06, 2013 at 11:38:29PM +0800, Nicolin Chen wrote:
> 
> > +static int imx_hifi_hw_free(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +
> > +	/* Don't diable FLL if still having multiple substreams running */
> > +	if (codec_dai->active != 1)
> > +		return 0;
> > +
> > +	return imx_wm8962_disable_fll(codec_dai);
> 
> This will still disable the FLL if there's an analogue bypass path
> active.  I'd suggest changing enable() and disable() to reference count.

I was expecting this would disable it for further reconfiguration. But it
seems I should also considerate the case using bypass path and normal PCM
playback simultaneously, which looks a bit complex.

> 
> > +		if (dapm->bias_level == SND_SOC_BIAS_STANDBY)
> > +			return imx_wm8962_enable_fll(codec_dai, 44100,
> > +						SNDRV_PCM_FORMAT_S16_LE);
> 
> It might be slightly nicer to keep the static variable for the frequency
> - that way if we start up due to set_bias_level() we'll keep the last
> rate played which might be more likely to avoid locking playbacks out.
> Very minor thing though, I wouldn't worry about it.

I'd like to follow this way.

Thank you,
Nicolin Chen
