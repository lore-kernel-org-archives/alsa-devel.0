From: Jianqun <xjq@rock-chips.com>
Subject: Re: [PATCH 4/5] ASoC: rockchip-i2s: fix registers' property of rockchip
 i2s controller
Date: Sun, 14 Sep 2014 10:29:02 +0800
Message-ID: <5414FD6E.2050006@rock-chips.com>
References: <1410568723-21559-1-git-send-email-jay.xu@rock-chips.com> <1410568932-21823-1-git-send-email-jay.xu@rock-chips.com> <5414AFA6.9060904@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5414AFA6.9060904@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Jianqun <jay.xu@rock-chips.com>, heiko@sntech.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org



=E5=9C=A8 09/14/2014 04:57 AM, Sergei Shtylyov =E5=86=99=E9=81=93:
> Hello.
>=20
> On 9/13/2014 3:42 AM, Jianqun wrote:
>=20
>> Reference rockchip I2S controller TRM, modify some registers' proper=
ty
>> I2S_FIFOLR: read / write, but not volatile, not precious
>> I2S_INTSR: read / write
>> I2S_CLR: volatile, register value will be cleared by read
>=20
>> Test on RK3288 with max98090.
>=20
>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>> ---
>>   sound/soc/rockchip/rockchip_i2s.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
>> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/=
rockchip_i2s.c
>> index 1b9b404..6595383 100644
>> --- a/sound/soc/rockchip/rockchip_i2s.c
>> +++ b/sound/soc/rockchip/rockchip_i2s.c
> [...]
>> @@ -385,8 +387,6 @@ static bool rockchip_i2s_volatile_reg(struct dev=
ice *dev, unsigned int reg)
>>   static bool rockchip_i2s_precious_reg(struct device *dev, unsigned=
 int reg)
>>   {
>>       switch (reg) {
>> -    case I2S_FIFOLR:
>> -        return true;
>>       default:
>>           return false;
>>       }
>=20
>    Shouldn't this be folded into simple *return* false now?
That is more reasonable, thank you.
>=20
> WBR, Sergei
>=20
>=20
>=20
>=20
>=20
