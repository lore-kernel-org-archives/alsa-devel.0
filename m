From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for max98090
Date: Wed, 13 May 2015 21:23:20 +0800
Message-ID: <55535048.4030703@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com> <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com> <20150512192636.GA3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150512192636.GA3066@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xing Zheng <acgzxing@gmail.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:26, Mark Brown wrote:
> On Tue, May 12, 2015 at 05:26:35PM +0800, Xing Zheng wrote:
>
>>   sound/soc/rockchip/Kconfig                   |   10 ++
>>   sound/soc/rockchip/Makefile                  |    2 +
>>   sound/soc/rockchip/rockchip_machine_driver.c |    6 +
>>   sound/soc/rockchip/rockchip_machine_driver.h |    6 +
>>   sound/soc/rockchip/rockchip_max98090.c       |  185 ++++++++++++++=
++++++++++++
> This looks more like a normal and reasonable machine driver but then =
why
> have you created the generic rockchip machine driver?  It seems like
> this should just be a regular machine driver like other platforms hav=
e,
> were it not for that this would be mostly fine apart from a couple of
> nitpicks below.
We just use rockchip_machine_driver to describe the supported codecs ba=
se on
origianl way, vendor machine driver(rockchip_max98090) will achieve=20
functions.
>> +config SND_SOC_ROCKCHIP_MAX98090
>> +	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
>> +	depends on SND_SOC_ROCKCHIP&&  I2C&&  GPIOLIB
>> +	select SND_SOC_ROCKCHIP_I2S
>> +	select SND_SOC_MAX98090
>> +	select SND_SOC_TS3A227E
> This looks like it's a driver specific to Chromebooks (possibly even
> specific Chromeooks) and so should be named as such.
>
>> +	card->dapm.idle_bias_off =3D true;
> Just set this when declaring the card, don't do it at runtime.
Thanks, I got it.
>> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
>> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
>> +	snd_soc_dapm_enable_pin(dapm, "Speaker");
>> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");
> No need to do this, all pins are enabled by default.
Yes, I got it.
>> +	snd_soc_dapm_sync(dapm);
> This has no effect during initialization.
Yes, I got it.
