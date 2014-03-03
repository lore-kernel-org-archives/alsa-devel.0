From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv3 1/3] ASoC: codec: Simplify ASoC probe code.
Date: Mon, 3 Mar 2014 07:24:36 +0000
Message-ID: <5bc570ec866541a68df5813ffbe3168e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393814545-15002-1-git-send-email-Li.Xiubo@freescale.com>
 <1393814545-15002-2-git-send-email-Li.Xiubo@freescale.com>
 <20140303045952.GO2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140303045952.GO2411@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> >  static int ak4535_probe(struct snd_soc_codec *codec)
> >  {
> > -	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
> > -	int ret;
> > -
> > -	codec->control_data = ak4535->regmap;
> > -	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
> > -	if (ret < 0) {
> > -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> > -		return ret;
> > -	}
> >  	/* power on device */
> >  	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> 
> Are you sure that the set_bias_level() call doesn't do anything with
> I/O?  Can I suggest sending a patch that just does the drivers that only
> do set_cache_io() and nothing else in probe - that would be really quick
> and simple to fix.
> 
> > -	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
> > -	if (ret < 0) {
> > -		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> >  	/* Default to using ALC auto offset calibration mode. */
> >  	snd_soc_update_bits(codec, DA7213_ALC_CTRL1,
> >  			    DA7213_ALC_CALIB_MODE_MAN, 0);
> 
> This one will fail.

Sorry, I'm not very understand why will this fail ? Before the ASoC probe,
the ASoC core will set the I/O. 
:)
