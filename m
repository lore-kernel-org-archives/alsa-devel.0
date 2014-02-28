From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: io: Remove reduntant params of
 snd_soc_codec_set_cache_io()
Date: Fri, 28 Feb 2014 08:50:36 +0000
Message-ID: <fe326d86be194020b3115e3e9fa74271@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393564009-15968-1-git-send-email-Li.Xiubo@freescale.com>
 <1393564009-15968-3-git-send-email-Li.Xiubo@freescale.com>
 <5310481D.3070106@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 07D99261A27
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 09:50:53 +0100 (CET)
In-Reply-To: <5310481D.3070106@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "mr.swami.reddy@ti.com" <mr.swami.reddy@ti.com>, "voice.shen@atmel.com" <voice.shen@atmel.com>, "mike.dyer@md-soft.co.uk" <mike.dyer@md-soft.co.uk>, "bardliao@realtek.com" <bardliao@realtek.com>, "mahaijuns@gmail.com" <mahaijuns@gmail.com>, "s.trumtrar@pengutronix.de" <s.trumtrar@pengutronix.de>, "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "swarren@nvidia.com" <swarren@nvidia.com>, "shc_work@mail.ru" <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org


> [...]
> > @@ -118,7 +115,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec
> *codec,
> >   EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
> >   #else
> >   int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
> > -			       int addr_bits, int data_bits,
> >   			       enum snd_soc_control_type control)
> 
> Since the only control type that is left is SND_SOC_REGMAP that can be
> removed as well. And while you are at it I think we should make it possible

Yes, agree.

> to specify the regmap struct as a parameter to snd_soc_codec_set_cache_io().
> So basically the new signature of the function should be:
> 
> snd_soc_codec_set_cache_io(struct snd_soc_codec *codec, struct regmap *regmap)
>
> if regmap is NULL the function should use dev_get_regmap(), otherwise use
> the supplied regmap struct. This turns the two step initialization in the
> form of
> 
> 	codec->control_data = priv->regmap;
> 	snd_soc_codec_set_cache_io(codec, ...);
> 
> into
> 	snd_soc_codec_set_cache_io(codec, priv->regmap);
> 
> which is much nicer in my opinion.
> 
> - Lars
> 

That's a good idea, I'll try to implement it.

Thanks,

--
Best Regards,
Xiubo

 
