From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5677: Reintroduce I2C device IDs
Date: Wed, 23 Aug 2017 17:29:33 +0300
Message-ID: <1503498573.25945.69.camel@linux.intel.com>
References: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503453106-5564-1-git-send-email-trini@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-08-22 at 21:51 -0400, Tom Rini wrote:
> Not all devices with ACPI and this combination of sound devices will
> have the required information provided via ACPI.  Reintroduce the I2C
> device ID to restore sound functionality on on the Chromebook 'Samus'
> model.

> This is a regression from v4.12 on my laptop (a Chromebook 'Samus'
> that's not running ChromeOS).  My fault for getting out of the habit
> of
> trying -rc1 when it comes out and not spotting this sooner.  I'm not
> 100% sure if this fix is correct for all cases as I'm only able to
> test
> my hardware here, and this does fix my laptop.

Are you sure the commit ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data
in the module sources") does not fix your issue?

> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 36e530a36c82..6f629278d982 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5021,6 +5021,7 @@ static int rt5677_write(void *context, unsigned
> int reg, unsigned int val)
>  static const struct i2c_device_id rt5677_i2c_id[] = {
>  	{ "rt5677", RT5677 },
>  	{ "rt5676", RT5676 },
> +	{ "RT5677CE:00", RT5677 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);

This one looks weird.

The board code has this 

sound/soc/intel/boards/bdw-rt5677.c:285:                .codec_name =
"i2c-RT5677CE:00",

It's clearly a match to ACPI enumerated I2C slave device.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
