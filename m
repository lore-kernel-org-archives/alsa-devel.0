From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add machine driver for ML7213 Carrier Board
Date: Tue, 6 Mar 2012 14:49:24 +0900
Message-ID: <CANKRQnhHo1P0cmxyfUAShTinWMv0B81d8v8f7M6Oj3Yx9807zg@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-3-git-send-email-tomoya.rohm@gmail.com>
	<20120302130509.GF3230@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120302130509.GF3230@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2012年3月2日22:05 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Feb 23, 2012 at 02:46:51PM +0900, Tomoya MORINAGA wrote:
>
>>         This option enables support for the AC Link Controllers in ML7213 IOH SoC.
>> +config SND_SOC_ML7213_MACHINE
>> +     tristate "ML7213 IOH ASoC machine driver"
>> +     select SND_SOC_ML7213_PLATFORM
>> +     help
>> +       This is ASoC machine driver for ML7213 IOH
>
> This needs to depend on the CODEC as well, how have you tested?
OK, will add this.

When I test this, I selected "Build all ASoC ...." of Kconfig

> You're also missing a blank line between this and the previous stanza.
Sorry, I can't understand your saying.

>
>> +static struct platform_device *ioh_snd_device;
>> +
>> +
>> +static int __init ioh_i2s_init(void)
>> +{
>> +     int ret;
>> +     ioh_snd_device = platform_device_alloc("soc-audio", -1);
>> +     if (!ioh_snd_device)
>> +             return -ENOMEM;
>
> Use snd_soc_register_card() and a real device.
OK.
As a matter of interest, why do you recommend me to use
snd_soc_register_card() ?
At present, many ASoC drivers use platform_device_alloc.

thanks,
-- 
ROHM Co., Ltd.
tomoya
