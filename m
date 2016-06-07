From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for MAX98357A/RT5514/DA7219
Date: Tue, 07 Jun 2016 10:49:35 +0800
Message-ID: <5756363F.40208@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com> <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com> <20160606235026.GP7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160606235026.GP7510-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 07:50, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 10:16:12PM +0800, Xing Zheng wrote:
>
>> I refered to MTK's mt8173-rt5650-rt5514.txt on upstream, that compat=
ible
>> name is "mediatek,mt8173-rt5650-rt5514".
>> Because our platform need to support 3 codecs (max98357a / da7219 / =
rt5514).
>> Perhaps, you maybe feel that name is too long? And, could you please=
 tell me
>> what names would be better?
>> For example: "rk3399-composite-codecs" ?
> It should probably be three compatibles, one per CODEC, if the driver
> needs to handle each separately.
Do you mean like this:
--------
sound {
compatible =3D "rockchip,rk3399-max98357a-rt5514-da7219";

dailink-0 {
compatible =3D "rockchip,rk3399-max98357a";
rockchip,cpu =3D <&i2s0>;
rockchip,codec =3D <&max98357a>;
};

dailink-1 {
compatible =3D "rockchip,rk3399-rt5514";
rockchip,cpu =3D <&i2s0>;
rockchip,codec =3D <&headsetcodec>;
};

dailink-2 {
compatible =3D "rockchip,rk3399-da7219";
rockchip,cpu =3D <&i2s0>;
rockchip,codec =3D <&codec>;
};
};
--------
Above, the machine drvier will handle them. Please correct me if I=20
misunderstand.

Thanks.

--=20
- Xing Zheng


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
