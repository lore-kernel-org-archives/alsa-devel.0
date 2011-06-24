From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: Add ADAV80x codec driver
Date: Fri, 24 Jun 2011 02:44:28 +0200
Message-ID: <4E03DDEC.9060608@metafoo.de>
References: <1308808818-26775-1-git-send-email-lars@metafoo.de> <4E0332C5.7010608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E0332C5.7010608@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Frysinger <vapier.adi@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On 06/23/2011 02:34 PM, Liam Girdwood wrote:
> On 23/06/11 07:00, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices ADAV801 and ADAV803 audio codec.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>
>> ---
>> Changes since v1:
>> * Sync register on resume
>> * Don't use arrays for the mux enums and controls
>> * Rework PLL handling. Use DAPM for powering the PLL and OSC down and use
>>   set_sysclk to select the system clock instead of doing this implicitly in
>>   set_pll.
>> ---
>>  MAINTAINERS                |    1 +
>>  sound/soc/codecs/Kconfig   |    4 +
>>  sound/soc/codecs/Makefile  |    2 +
>>  sound/soc/codecs/adav80x.c |  908 ++++++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/codecs/adav80x.h |   31 ++
>>  5 files changed, 946 insertions(+), 0 deletions(-)
>>  create mode 100644 sound/soc/codecs/adav80x.c
>>  create mode 100644 sound/soc/codecs/adav80x.h
>>
> 
> snip
> 
>> +
>> +static int adav80x_probe(struct snd_soc_codec *codec)
>> +{
>> +       int ret;
>> +       struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
>> +
>> +       ret = snd_soc_codec_set_cache_io(codec, 7, 9, adav80x->control_type);
>> +       if (ret) {
>> +               dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /* Power down SYSCLK output, power down S/PDIF receiver */
>> +       snd_soc_write(codec, ADAV80X_PLL_OUTE, 0x27);
>> +       /* Disable DAC zero flag */
>> +       snd_soc_write(codec, ADAV80X_DAC_CTRL3, 0x6);
>> +
>> +       return adav80x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +}
>> +
> 
> It's usually better disable things like sysclk output in your machine driver as others may depend on it for probing.

What is the proper API to do this? set_sysclk with dir = SND_SOC_CLOCK_OUT and
freq = 0?
