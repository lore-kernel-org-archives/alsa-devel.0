From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH v6] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
Date: Mon, 11 Jul 2016 14:20:01 +0800
Message-ID: <57833A91.7090109@rock-chips.com>
References: <1466080858-29565-1-git-send-email-zhengxing@rock-chips.com>
 <20160620130812.GA24614@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620130812.GA24614@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, dianders@chromium.org, heiko@sntech.de, smbarber@google.com, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
     In your opinion, is there anything needs to be optimized in this p=
atch?

Thanks.

On 2016=E5=B9=B406=E6=9C=8820=E6=97=A5 21:08, Rob Herring wrote:
> On Thu, Jun 16, 2016 at 08:40:58PM +0800, Xing Zheng wrote:
>> Because we need to support the multiple codecs (MAX98357A/RT5514/DA7=
219)
>> on the RK3399 GRU boards, this patch can help us to support these co=
decs.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> ---
>>
>> Changes in v6:
>> - remove enable/disable dapm pins, and to switch codecs via user spa=
ce
>> - fix "Speaker" dapm route for max98357a
>> - add SND_JACK_LINEOUT flag for da7219 jack detection
>>
>> Changes in v5:
>> - fix the build warning for missing I2C/CLKDEV_LOOKUP dependency
>>
>> Changes in v4:
>> - the compatible name needs to be based on a single reference design=
,
>>    and the name of the board is called "GRU"
>> - use one i2sX card "rockchip,cpu =3D <&i2s0>" instead of array that=
 is
>>    based on GRU
>> - rename DOC to rockchip,rk3399-gru-sound.txt
>> - rename compatible to rockchip,rk3399-gru-sound
>> - rename source code to rk3399_gru_sound.c
>>
>> Changes in v3:
>> - rename DOC to rockchip,rk3399-max98357a-rt5514-da7219.txt
>> - rename compatible to rockchip,rk3399-max98357a-rt5514-da7219
>> - rename source code to rk3399_max98357a_rt5514_da7219.c
>>
>> Changes in v2:
>> - use the FS 256 to set mclks of the max98357a and rt5514 danamicall=
y
>> - add more sample rate for da7219
>>
>>   .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   15 +
> Acked-by: Rob Herring <robh@kernel.org>
>
>>   sound/soc/rockchip/Kconfig                         |   11 +
>>   sound/soc/rockchip/Makefile                        |    2 +
>>   sound/soc/rockchip/rk3399_gru_sound.c              |  322 ++++++++=
++++++++++++
>>   4 files changed, 350 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/rockchi=
p,rk3399-gru-sound.txt
>>   create mode 100644 sound/soc/rockchip/rk3399_gru_sound.c
>
>

--=20
- Xing Zheng
