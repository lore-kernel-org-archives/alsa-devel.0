From: Jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: rockchip: i2s: set TDL and RDL
 to 16 bits
Date: Wed, 24 Dec 2014 08:36:19 +0800
Message-ID: <549A0A83.7040606@rock-chips.com>
References: <1419325709-15374-1-git-send-email-jay.xu@rock-chips.com> <1419325709-15374-3-git-send-email-jay.xu@rock-chips.com> <CAEUnVG79MOHUufRnJVe98ZTC4vouUNAEWtPsryEKWLc+Qpdjuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEUnVG79MOHUufRnJVe98ZTC4vouUNAEWtPsryEKWLc+Qpdjuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 12/24/2014 07:06 AM, Dylan Reid =E5=86=99=E9=81=93:
> On Tue, Dec 23, 2014 at 1:08 AM, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> w=
rote:
>> Set Transmit Data Level(TDL) and Receive Data Level(RDL) to 16 bits.
>> Without this setting, the TDL is default to be 0x00 (means 1 bit),
>> and the RDL is default to be 0x1f (means 16 bits).
>=20
> My impression from the TRM was that TDL and RDL were measured in
> samples.  Are you sure it's 'bits'?
You are right, I'll modify the commit message next version, thank you
>=20
>>
>> This patch is helpful to fix pop sound, tested on rk3288 board.
>>
>> Signed-off-by: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>  sound/soc/rockchip/rockchip_i2s.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/=
rockchip_i2s.c
>> index c74ba37..1cd7efc 100644
>> --- a/sound/soc/rockchip/rockchip_i2s.c
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> @@ -247,6 +247,10 @@ static int rockchip_i2s_hw_params(struct snd_pc=
m_substream *substream,
>>
>>         regmap_update_bits(i2s->regmap, I2S_TXCR, I2S_TXCR_VDW_MASK,=
 val);
>>         regmap_update_bits(i2s->regmap, I2S_RXCR, I2S_RXCR_VDW_MASK,=
 val);
>> +       regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_TDL_MAS=
K,
>> +                          I2S_DMACR_TDL(16));
>> +       regmap_update_bits(i2s->regmap, I2S_DMACR, I2S_DMACR_RDL_MAS=
K,
>> +                          I2S_DMACR_RDL(16));
>>
>>         return 0;
>>  }
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20
>=20
>=20

--=20
Jianqun Xu

***********************************************************************=
*****
*IMPORTANT NOTICE:*This email is from Fuzhou Rockchip Electronics Co.,
Ltd .The contents of this email and any attachments may contain
information that is privileged, confidential and/or exempt from
disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure,
copying, distribution, or use of the information is STRICTLY PROHIBITED=
=2E
Please immediately contact the sender as soon as possible and destroy
the material in its entirety in any format. Thank you.
***********************************************************************=
*****

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
