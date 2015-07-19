From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Sun, 19 Jul 2015 15:42:07 +0800
Message-ID: <55AB54CF.20609@rock-chips.com>
References: <1437196124-32655-1-git-send-email-zhengxing@rock-chips.com> <1437196124-32655-2-git-send-email-zhengxing@rock-chips.com> <20150718091608.GW11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150718091608.GW11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 2015=E5=B9=B407=E6=9C=8818=E6=97=A5 17:16, Mark Brown wrote:
> On Sat, Jul 18, 2015 at 01:08:43PM +0800, Xing Zheng wrote:
>
>> +	ret =3D devm_snd_soc_register_card(&pdev->dev, card);
>> +	if (ret) {
>> +		dev_err(&pdev->dev,
>> +			"Soc register card failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int snd_rk_mc_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_card *soc_card =3D platform_get_drvdata(pdev);
>> +
>> +	snd_soc_unregister_card(soc_card);
> The point with using devm_snd_soc_register_card() is that you don't n=
eed
> to manually unregister the card - devm_ ensures that the card is free=
d.
Got it. Thank you.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
