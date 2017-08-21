From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: GPIO issue with RT5670
Date: Mon, 21 Aug 2017 17:02:45 -0500
Message-ID: <8b70e5c5-4603-2884-1306-b8dbedd7f736@linux.intel.com>
References: <5568f645-b001-3628-06a7-36c2b41fed5f@linux.intel.com>
 <s5ha82svcod.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B51F2674BD
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 00:02:48 +0200 (CEST)
In-Reply-To: <s5ha82svcod.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 08/21/2017 04:22 PM, Takashi Iwai wrote:
> On Mon, 21 Aug 2017 23:18:45 +0200,
> Pierre-Louis Bossart wrote:
>> the commit f10e4bf6632b5be11cea875b66ba959833a69258
>>      gpio: acpi: Even more tighten up ACPI GPIO lookups
>>
>> now generates the following issue
>>
>> [    9.694204] rt5670 i2c-10EC5672:00: ASoC: Cannot get gpio at index 0: -2
>> [    9.694293] rt5670 i2c-10EC5672:00: Adding jack GPIO failed
>>
>> This is the 3rd occurrence of an audio issue with this commit [1][2],
>> what is the recommended fix here since this codec is not only used in
>> ACPI-based devices and do we need to check for more issues in audio
>> drivers?
> Likely you need to give the proper mapping in the machine driver, and
> correct the hp_gpio.name to the corresponding one.
>
> It's cht_bsw_rt5672?  If so, the required change would be something
> like below.

yep, this works, thanks Takashi. With an additional DMI fix i'll submit 
later I get sound on the Dell 5585.

Tested-by: Pierre Bossart <pierre-louis.bossart@linux.intel.com>
>
>
> Takashi
>
> ---
> diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
> index 0ec7985ed306..054b613cb0d0 100644
> --- a/sound/soc/codecs/rt5670.c
> +++ b/sound/soc/codecs/rt5670.c
> @@ -567,7 +567,7 @@ int rt5670_set_jack_detect(struct snd_soc_codec *codec,
>   
>   	rt5670->jack = jack;
>   	rt5670->hp_gpio.gpiod_dev = codec->dev;
> -	rt5670->hp_gpio.name = "headphone detect";
> +	rt5670->hp_gpio.name = "headset";
>   	rt5670->hp_gpio.report = SND_JACK_HEADSET |
>   		SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2;
>   	rt5670->hp_gpio.debounce_time = 150;
> diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
> index bc2a52de06a3..f597d5582223 100644
> --- a/sound/soc/intel/boards/cht_bsw_rt5672.c
> +++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
> @@ -184,6 +184,13 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static const struct acpi_gpio_params headset_gpios = { 0, 0, false };
> +
> +static const struct acpi_gpio_mapping cht_rt5672_gpios[] = {
> +	{ "headset-gpios", &headset_gpios, 1 },
> +	{},
> +};
> +
>   static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
>   {
>   	int ret;
> @@ -191,6 +198,9 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
>   	struct snd_soc_codec *codec = codec_dai->codec;
>   	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
>   
> +	if (devm_acpi_dev_add_driver_gpios(codec->dev, cht_rt5672_gpios))
> +		dev_warn(runtime->dev, "Unable to add GPIO mapping table\n");
> +
>   	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
>   	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
>   	if (ret < 0) {
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
