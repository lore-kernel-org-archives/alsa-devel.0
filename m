From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for MAX98357A/RT5514/DA7219
Date: Tue, 07 Jun 2016 19:38:23 +0800
Message-ID: <5756B22F.9000105@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com> <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com> <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com> <20160607104711.GR7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607104711.GR7510@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org, dianders@chromium.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 18:47, Mark Brown wrote:
> On Tue, Jun 07, 2016 at 10:49:35AM +0800, Xing Zheng wrote:
>> On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 07:50, Mark Brown wrote:
>>> It should probably be three compatibles, one per CODEC, if the driv=
er
>>> needs to handle each separately.
>> Do you mean like this:
>> --------
>> sound {
>> compatible =3D "rockchip,rk3399-max98357a-rt5514-da7219";
>>
>> dailink-0 {
>> compatible =3D "rockchip,rk3399-max98357a";
>> rockchip,cpu =3D<&i2s0>;
>> rockchip,codec =3D<&max98357a>;
>> };
>>
>> dailink-1 {
>> compatible =3D "rockchip,rk3399-rt5514";
>> rockchip,cpu =3D<&i2s0>;
>> rockchip,codec =3D<&headsetcodec>;
>> };
>>
>> dailink-2 {
>> compatible =3D "rockchip,rk3399-da7219";
>> rockchip,cpu =3D<&i2s0>;
>> rockchip,codec =3D<&codec>;
>> };
>> };
>> --------
>> Above, the machine drvier will handle them. Please correct me if I
>> misunderstand.
> No, that'd be one card with all three CODECs on the same board which =
I'm
> guessing isn't the intention?
Yes, because on our board, the audio connection by hardware really is s=
uch:
                   |-- max98357a
i2s0 <=3D=3D> |-- rt5514
                   | -- da7219

We do need to support max98357a / rt5514 / da7219 via i2s0 on the same=20
board for RK3399.

I remember that it will be failed if we register card with i2s0 more=20
times. Therefore, I chose this mothod that create 3 dai-links on one=20
machine driver.

Thanks.

--=20
- Xing Zheng
