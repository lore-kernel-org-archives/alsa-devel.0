From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Thu, 19 Apr 2018 09:58:17 +0800
Message-ID: <1524103097.3290.14.camel@mtksdaap41>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
 <20180418164040.GG10061@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id A48FF26767A
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 03:58:22 +0200 (CEST)
In-Reply-To: <20180418164040.GG10061@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-04-18 at 17:40 +0100, Mark Brown wrote:
Wants to clarify a few comment here, others will be update in next patch

> > +static int mt6351_codec_probe(struct snd_soc_codec *codec)
> > +{
> > +	struct mt6351_priv *priv = snd_soc_codec_get_drvdata(codec);
> > +
> > +	/* add codec controls */
> > +	snd_soc_add_codec_controls(codec,
> > +				   mt6351_snd_controls,
> > +				   ARRAY_SIZE(mt6351_snd_controls));
> > +	snd_soc_add_codec_controls(codec,
> > +				   mt6351_snd_ul_controls,
> > +				   ARRAY_SIZE(mt6351_snd_ul_controls));
> > +
> > +	mt6351_codec_init_reg(codec);
> > +
> > +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] = 8;
> > +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] = 8;
> > +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1] = 3;
> > +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2] = 3;
> > +
> > +	return 0;
> > +}
> 
> Can we read the configuration of the device back from the hardware?
> It's better to just use the defaults rather than set things up for a
> particular use case, that way there's a standard that can be agreed even
> if it's not good for every use case.
> 

mt6351_codec_init_reg(), regs bit in here are not govern by DAPM,
and is not optimal for low power in hardware default state.
so fixed those reg bit in optimal state by init its reg.

> > +static struct snd_soc_codec_driver mt6351_soc_codec_driver = {
> > +	.probe = mt6351_codec_probe,
> > +	.get_regmap = mt6351_get_regmap,
> 
> We're just about to remove CODEC drivers entirely and replace them with
> components - nothing else is using the get_regmap() callback.  Do you
> really need that callback, if you do we should just add it to the
> component interface?
> 
> > +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> > +	if (IS_ERR(priv->regmap))
> > +		return PTR_ERR(priv->regmap);
> 
> This should be the default behaviour so I'm guessing you don't need the
> callback?

the regmap is obtain from parent dev, i assume i can use
snd_soc_component_init_regmap() as alternative for
get_regmap().callback?

Thanks
