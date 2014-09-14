From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
Date: Sun, 14 Sep 2014 10:27:43 +0800
Message-ID: <5414FD1F.6020603@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com> <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com> <20140913163749.GK7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140913163749.GK7960@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 09/14/2014 12:37 AM, Mark Brown =E5=86=99=E9=81=93:
> On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
>=20
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
>> @@ -423,6 +423,11 @@ static int rockchip_i2s_probe(struct platform_d=
evice *pdev)
>>  		dev_err(&pdev->dev, "Can't retrieve i2s bus clock\n");
>>  		return PTR_ERR(i2s->hclk);
>>  	}
>> +	ret =3D clk_prepare_enable(i2s->hclk);
>> +	if (ret) {
>> +		dev_err(i2s->dev, "hclock enable failed %d\n", ret);
>> +		return ret;
>> +	}
>=20
> BTW: you're also missing a clk_disable_unprepare() in the remove path
> here, please send a followup fixing that.
remove function has done the clk_disable_unprepare for "hclk".

One more thing, since "i2s_clk" is enabled at runtime_resume, and is di=
sabled in runtime_suspend,
hasn't enable in probe, so do the "i2s_clk" to be disabled in remove ?
The current driver has disable in remove.
>=20
