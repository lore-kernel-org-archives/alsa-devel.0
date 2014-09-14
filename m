From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH 5/5] ASoC: rockchip-i2s: enable "hclk" for rockchip I2S
 controller
Date: Sun, 14 Sep 2014 10:24:00 +0800
Message-ID: <5414FC40.1040005@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com> <1410568993-21874-1-git-send-email-jay.xu@rock-chips.com> <20140913163648.GJ7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140913163648.GJ7960@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 09/14/2014 12:36 AM, Mark Brown =E5=86=99=E9=81=93:
> On Sat, Sep 13, 2014 at 08:43:13AM +0800, Jianqun wrote:
>> As "hclk" is used for rockchip I2S controller, driver must to enable
>> it in probe.
>=20
> Applied, again this is a bug fix.  How did the original submission ge=
t
> tested?
>=20
The original submission is verified on rk3288 with kernel 3.10, but I h=
ad to make patches based on
kernel 3.14 +, also our sdk kernel has intalized the kernel in other wa=
ys, so I missed the enable but
the driver worked well.

The new patches is verified on kernel 3.14, so it will easy to test.
