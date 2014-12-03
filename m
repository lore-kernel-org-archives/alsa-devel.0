From: Jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
Date: Wed, 03 Dec 2014 09:03:40 +0800
Message-ID: <547E616C.1020503@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>	<1417531977-30094-1-git-send-email-jay.xu@rock-chips.com> <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Doug:

=E5=9C=A8 12/03/2014 01:54 AM, Doug Anderson =E5=86=99=E9=81=93:
> Jianqun,
>=20
> This ought to be a "v3" patch and ideally ought to describe
> differences from v2 (after the cut).  Please have Kever or Chris
> review your next patch before sending it out since I think they are
> familiar with the process.
>=20
>=20
> On Tue, Dec 2, 2014 at 6:52 AM, Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wr=
ote:
>> From: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>>
>> We need to claim the clock which is driving the codec so that when w=
e enable
>> clock gating, we continue to clock the codec when needed.  I make th=
is an
>> optional clock since there might be some applications where we don't=
 need it
>> but can still use the I2S block.
>>
>> Signed-off-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> You still forgot your own signed-off-by.  Please try again.  See
> <https://patchwork.kernel.org/patch/5334991/>
ok, I will add my signed-off-by
>=20
>=20
>> +       i2s->oclk =3D devm_clk_get(&pdev->dev, "i2s_clk_out");
>> +       if (IS_ERR(i2s->oclk)) {
>> +               dev_dbg(&pdev->dev, "Didn't find output clock\n");
>> +               i2s->oclk =3D NULL;
>> +       }
>=20
> You still forgot the blank line here requested by Heiko.  Please try
> again.  See <https://patchwork.kernel.org/patch/5334991/>
Although I thought there needn't a blank ~, I wll add it next patch
>=20
>=20
>> +       if (i2s->oclk)
>> +               ret =3D clk_prepare_enable(i2s->oclk);
>> +
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
