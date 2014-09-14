From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH] ASoC: rockchip-i2s: dt: swap tx and rx channed request
 number
Date: Sun, 14 Sep 2014 10:29:50 +0800
Message-ID: <5414FD9E.4000602@rock-chips.com>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com> <20140913164032.GN7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140913164032.GN7960@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 09/14/2014 12:40 AM, Mark Brown =E5=86=99=E9=81=93:
> On Sat, Sep 13, 2014 at 09:04:41AM +0800, Jianqun wrote:
>> Reference to RK3288 TRM, fix an error channel id for i2s tx and rx
>> Table 10-1 DMAC_BUS Request Mapping Table
>> Req number	Source	Polarity
>> 0		I2S tx	High level
>> 1		I2S rx	High level
>=20
> Applied, thanks.  The changelog should've just noted that this is an
> error in the example rather than the code or the binding, I was a bit
> confused about this.
>=20
ok, I will do it
