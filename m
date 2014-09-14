From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of rockchip
 i2s controller
Date: Sun, 14 Sep 2014 10:20:11 +0800
Message-ID: <5414FB5B.8090907@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com> <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com> <20140913163613.GI7960@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140913163613.GI7960@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 09/14/2014 12:36 AM, Mark Brown =E5=86=99=E9=81=93:
> On Sat, Sep 13, 2014 at 08:42:12AM +0800, Jianqun wrote:
>> Reference rockchip I2S controller TRM, modify some registers' proper=
ty
>> I2S_FIFOLR: read / write, but not volatile, not precious
>> I2S_INTSR: read / write
>> I2S_CLR: volatile, register value will be cleared by read
>=20
> Applied, again this is a bug fix (volatile and precious being wrong s=
eem
> like bugs) so should have been earlier in the series.
>=20
ok, I'll re-order the patches
