From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: Intel: boards: Add Baytrail RT5660
 machine driver
Date: Mon, 19 Dec 2016 10:30:09 -0600
Message-ID: <a712abe0-4fc0-8b7f-b819-2903564b88c6@linux.intel.com>
References: <20161219135147.24208-1-shrirang.bagul@canonical.com>
 <20161219135147.24208-3-shrirang.bagul@canonical.com>
 <20161219155509.qs7o5tdnz5z6ksuw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219155509.qs7o5tdnz5z6ksuw@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: alsa-devel@alsa-project.org, Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Ben Zhang <benzh@chromium.org>, John Keeping <john@metanate.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Colin Ian King <colin.king@canonical.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/19/16 9:55 AM, Mark Brown wrote:
> On Mon, Dec 19, 2016 at 09:51:47PM +0800, Shrirang Bagul wrote:
>
>> +
>> +#define DEBUG
>
> This should be production code...
>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/acpi.h>
>> +#include <linux/device.h>
>> +#include <linux/dmi.h>
>> +#include <linux/slab.h>
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/platform_sst_audio.h>
>> +#include <linux/clk.h>
>
> The ordering of the headers is very random here, and is there a matching
> platform patch somewhere registering clocks?
>
>> +		/*
>> +		 * Set codec clock source to internal clock before
>> +		 * turning off the platform clock. Codec needs clock
>> +		 * for Jack detection and button press
>> +		 */
>> +		ret = snd_soc_dai_set_sysclk(codec_dai, RT5660_SCLK_S_RCCLK,
>> +					     0,
>> +					     SND_SOC_CLOCK_IN);
>> +		if (!ret) {
>> +			if ((byt_rt5660_quirk & BYT_RT5660_MCLK_EN) && priv->mclk)
>> +				clk_disable_unprepare(priv->mclk);
>> +		}
>
> Please write the error handling normally and don't embed the next steps
> of the process in where the error handling would usually be.
>
>> +	ret = snd_soc_add_card_controls(card, byt_rt5660_controls,
>> +					ARRAY_SIZE(byt_rt5660_controls));
>> +	if (ret) {
>> +		dev_err(card->dev, "unable to add card controls\n");
>> +		return ret;
>> +	}
>
> Why not initialize these from the card struct?
>
>> +	if ((byt_rt5660_quirk & BYT_RT5660_MCLK_EN) && priv->mclk) {
>> +		/*
>> +		 * The firmware might enable the clock at
>> +		 * boot (this information may or may not
>> +		 * be reflected in the enable clock register).
>> +		 * To change the rate we must disable the clock
>> +		 * first to cover these cases. Due to common
>> +		 * clock framework restrictions that do not allow
>> +		 * to disable a clock that has not been enabled,
>> +		 * we need to enable the clock first.
>> +		 */
>> +		ret = clk_prepare_enable(priv->mclk);
>> +		if (!ret)
>> +			clk_disable_unprepare(priv->mclk);
>
> We don't disable the clock after (apparently) temporarily enabling it
> here.
>
>> +		/*
>> +		 * Default mode for SSP configuration is TDM 4 slot, override config
>> +		 * with explicit setting to I2S 2ch 16-bit. The word length is set with
>> +		 * dai_set_tdm_slot() since there is no other API exposed
>> +		 */
>> +		ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
>> +					SND_SOC_DAIFMT_I2S     |
>> +					SND_SOC_DAIFMT_NB_IF   |
>> +					SND_SOC_DAIFMT_CBS_CFS
>> +			);
>
> Please use a normal kernel coding style and please initialize this from
> the dai_link too, it's always the same.
>
>> +	/* fixup codec name based on HID */
>> +	i2c_name = sst_acpi_find_name_from_hid(mach->id);
>> +	if (i2c_name != NULL) {
>> +		snprintf(byt_rt5660_codec_name, sizeof(byt_rt5660_codec_name),
>> +			"%s%s", "i2c-", i2c_name);
>
> There's no point in formatting a static string in here, just include it
> in the string.

All this code seems to be largely a copy-paste of the bytcr_rt5640 
machine driver and the same comments would apply there. This patch did 
miss the last correction merged by Mark to deal with errors "ASoC: 
Intel: bytcr_rt5640: fallback mechanism if MCLK is not enabled" and the 
same error handling would be needed.
The clock registration part isn't in the mainline yet, barring a 
Christmas miracle we may want to wait until it's available before adding 
more machine drivers depending on it (I have 5 related changes for 
rt5651, rt5645, rt5670, max98090 and TI 32xx on my github).
