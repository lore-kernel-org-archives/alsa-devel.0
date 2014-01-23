From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 6/8] ASoC: simple-card: add tdm slot supports
Date: Thu, 23 Jan 2014 06:35:35 +0000
Message-ID: <a02ec2db6eb4459498ad5dbea44e511c@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-7-git-send-email-Li.Xiubo@freescale.com>,<alpine.DEB.2.02.1401222210560.8088@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1401222210560.8088@chino.kir.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi David,

Firstly thanks for your comment.

> > +asoc_simple_card_of_parse_tdm_slot(struct device_node *np,
> > +				   struct device *dev,
> > +				   struct asoc_simple_dai *dai,
> > +				   const char *propname)
> > +{
> > +	struct asoc_simple_tdm_slot *tdm;
> > +	u32 out_value[4];
> > +	int ret;
> > +
> > +	if (!of_property_read_bool(np, propname))
> > +		return 0;
> > +
> > +	tdm = devm_kzalloc(dev, sizeof(*tdm), GFP_KERNEL);
> > +	if (!tdm)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32_array(np, propname, out_value, 4);
> > +	if (ret)
> > +		return ret;
> 
> Looks like a memory leak?
>

Using devm_ and this will be called by _probe().

Please see the "Documentation/driver-model/devres.txt" for detail about
devres.

 
> > +
> > +	tdm->tx_mask = out_value[0];
> > +	tdm->rx_mask = out_value[1];
> > +	tdm->slots = out_value[2];
> > +	tdm->slot_width = out_value[3];
> > +
> > +	dai->tdm = tdm;
> > +
> > +	return 0;
> > +}
> > +

Thanks,

Best Regards,
Xiubo
