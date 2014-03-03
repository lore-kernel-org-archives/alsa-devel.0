From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv2 1/3] ASoC: codec: Simplify ASoC probe code.
Date: Mon, 3 Mar 2014 03:01:52 +0000
Message-ID: <ea3da7fbf6564020b12bcd8b4878ae4a@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393578267-18255-1-git-send-email-Li.Xiubo@freescale.com>
 <1393578267-18255-2-git-send-email-Li.Xiubo@freescale.com>
 <20140301042818.GP29849@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140301042818.GP29849@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> > "Just removing the set_cache_io() call will not work for all
> > drivers. There are some MFD child devices which use regmap from the parent
> > device. So dev_get_regmap() will return NULL for those."
> 
> This is the sort of thing that I was referring to when talking about
> doing the non-boring drivers separately.  As well as the warnings Lars
> mentioned there's a bisection issue here:
> 
> > -	codec->control_data = da7213->regmap;
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
> Unless the core sets up the I/O before calling probe() the above is
> going to mean that the snd_soc_update_bits() call fails since the I/O
> operations won't have been set up.  There is a defualt call to set a
> regmap up but it's only done after the probe.

Yes, like the SGTL5000 CODEC driver, which needs to read the chip information
in main probe. And then it must use the regmap core APIs directly.

And I have do another research early, all the CODEC drivers who are calling
set_cache_io() in ASoC probes, and before that they all are using the regmap core
APIs instead of ASoC ones if needed. 

I think we should move the set_cache_io() calling more earlier as we discussed
before, but need much more research and testing. Splitting them into another
separate patch later will be much better and easier to be reviewed.

Thanks,

--
Best Regards,
Xiubo
