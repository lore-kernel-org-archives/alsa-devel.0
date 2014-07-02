From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH 2/2] ASoC: add driver for Rockchip RK3xxx I2S controller
Date: Wed, 02 Jul 2014 18:57:46 +0800
Message-ID: <53B3E5AA.9060300@rock-chips.com>
References: <1404203860-30712-1-git-send-email-xjq@rock-chips.com> <1404204458-30881-1-git-send-email-xjq@rock-chips.com> <20140701170747.GA15028@sirena.org.uk> <53B359FD.3080809@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B359FD.3080809@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Tao <huangtao@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, zhangqing@rock-chips.com, hj@rock-chips.com, kever.yang@rock-chips.com, zyw@rock-chips.com, yzq@rock-chips.com, zhenfu.fang@rock-chips.com, cf@rock-chips.com, kfx@rock-chips.com
List-Id: alsa-devel@alsa-project.org

Hi Mark:

Since regmap_update_bits is int style, I have to error check every time=
 after call it.
Also I find that the tegra_i2s.c call the function without error checki=
ng,

Could you tell me the right way to handle the regmap_update_bits ?


Best Regards

On 2014=E5=B9=B407=E6=9C=8802=E6=97=A5 09:01, Huang Tao wrote:
> Hi, Mark:
>=20
> =E4=BA=8E 2014=E5=B9=B407=E6=9C=8802=E6=97=A5 01:07, Mark Brown =E5=86=
=99=E9=81=93:
>>> +static inline void i2s_writel(struct rk_i2s_dev *i2s, u32 value,
>>>> +			      unsigned int offset)
>>>> +{
>>>> +	writel_relaxed(value, i2s->regs + offset);
>>>> +}
>>>> +
>>>> +static inline u32 i2s_readl(struct rk_i2s_dev *i2s, unsigned int =
offset)
>>>> +{
>>>> +	return readl_relaxed(i2s->regs + offset);
>>>> +}
>> Perhaps use regmap?  The main advantage would be the debug
>> infrastructure, though you could also use _update_bits() to reduce t=
he
>> amount of time spent locked.
>>
> Are you sure? This is a I2S driver, we can write the register directl=
y,
> do not through I2C or SPI bus.
> Write a register is only a few instructions on ARM, but write through
> regmap, it may take a long path.
> I think it will just consume CPU power and make the whole thing more
> complex.
> Could you tell me what benefits we can get if use regmap? Or somethin=
g I
> just missing?
>=20
>=20
>=20

--=20
-------------
=E8=AE=B8 =E5=89=91 =E7=BE=A4 Jay
Rockchip Electronics Co.Ltd
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
