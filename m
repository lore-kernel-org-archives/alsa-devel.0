From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: fsl: imx-wm8962: Grant hw_params/free()
 permission to control FLL
Date: Fri, 6 Dec 2013 22:31:39 +0800
Message-ID: <20131206143138.GA29975@MrMyself>
References: <cover.1386322845.git.b42378@freescale.com>
 <bed76b8bfd2d4ed9739269657cd55e4a81b65403.1386322845.git.b42378@freescale.com>
 <20131206143433.GH29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131206143433.GH29268@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 02:34:33PM +0000, Mark Brown wrote:
> On Fri, Dec 06, 2013 at 05:47:43PM +0800, Nicolin Chen wrote:
> 
> > +static int imx_wm8962_enable_fll(struct snd_soc_dai *codec_dai, u32 sample_rate,
> > +				snd_pcm_format_t sample_format)
> > +{
> > +	struct imx_priv *priv = &card_priv;
> > +	struct device *dev = &priv->pdev->dev;
> > +	struct imx_wm8962_data *data = platform_get_drvdata(priv->pdev);
> > +	u32 freq, ret;
> > +
> > +	if (data->fll_lock)
> > +		return 0;
> 
> Don't we need an actual lock to protect this?

Thank you for the advice, I will revise it.

Best regards,
Nicolin Chen
