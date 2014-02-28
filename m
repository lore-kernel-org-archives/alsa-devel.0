From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: core: Set the default I/O up try
 regmap.
Date: Fri, 28 Feb 2014 07:50:41 +0000
Message-ID: <049024c359df495fb8acedd96e574ce2@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
 <20140228035244.GJ9383@sirena.org.uk>
 <c405df11848a40b7beda8d8fe747e7a7@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140228052904.GP9383@sirena.org.uk>
 <1b89016263c84e0297655034a648032f@BY2PR03MB505.namprd03.prod.outlook.com>
 <53102EE4.80702@metafoo.de>
 <d872d0fd60eb4c01b38af98014c802aa@BY2PR03MB505.namprd03.prod.outlook.com>
 <531030C7.2060703@metafoo.de>
 <5d534c2ac77040d9bc373db9e43dde7c@BY2PR03MB505.namprd03.prod.outlook.com>
 <53103787.2020702@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53103787.2020702@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> 
> A quick grep reveals:
> mc13783.c:	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);
> si476x.c:	codec->control_data = dev_get_regmap(codec->dev->parent, NULL);
> wm5102.c:	codec->control_data = priv->core.arizona->regmap;
> wm5110.c:	codec->control_data = priv->core.arizona->regmap;
> wm8997.c:	codec->control_data = priv->core.arizona->regmap;
> 
> But there might be more.
> 

I have found the following ones, who are using MFD & set_cache_io.

   1    143  sound/soc/codecs/cq93vc.c <<cq93vc_probe>>
             snd_soc_codec_set_cache_io(codec, 32, 32, SND_SOC_REGMAP);
   2    618  sound/soc/codecs/mc13783.c <<mc13783_probe>>
             ret = snd_soc_codec_set_cache_io(codec, 8, 24, SND_SOC_REGMAP);
   3   1765  sound/soc/codecs/wm5102.c <<wm5102_codec_probe>>
             ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
   4   1593  sound/soc/codecs/wm5110.c <<wm5110_codec_probe>>
             ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);
   5   1510  sound/soc/codecs/wm8350.c <<wm8350_codec_probe>>
             snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
   6   1322  sound/soc/codecs/wm8400.c <<wm8400_codec_probe>>
             snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
   7   4004  sound/soc/codecs/wm8994.c <<wm8994_codec_probe>>
             snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
   8   1058  sound/soc/codecs/wm8997.c <<wm8997_codec_probe>>
             ret = snd_soc_codec_set_cache_io(codec, 32, 16, SND_SOC_REGMAP);


Thanks,

--
Best regards,
Xiubo
