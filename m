From: Bard Liao <bardliao@realtek.com>
Subject: RE: [PATCH v2 1/4] ASoC: rt5660: Add ACPI support
Date: Fri, 13 Jan 2017 02:53:10 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7012363F1@RTITMBSV03.realtek.com.tw>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
 <20170112120101.16933-2-shrirang.bagul@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112120101.16933-2-shrirang.bagul@canonical.com>
Content-Language: zh-TW
Sender: linux-kernel-owner@vger.kernel.org
To: Shrirang Bagul <shrirang.bagul@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Shrirang Bagul [mailto:shrirang.bagul@canonical.com]
> Sent: Thursday, January 12, 2017 8:01 PM
> To: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org; Bard Liao; Oder Chiou; Liam Girdwood; Mark
> Brown; Jaroslav Kysela; Takashi Iwai
> Subject: [PATCH v2 1/4] ASoC: rt5660: Add ACPI support
> 
> On Dell IoT Gateways, RT5660 codec is available with ACPI ID 10EC3277.
> Also, GPIO's are only available by index, so we register mappings to allow
> machine drivers to access them by name.
> 
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> ---
> +static const struct acpi_gpio_params audio_wake_intr_gpio =
> { RT5660_GPIO_WAKE_INTR, 0, false };
> +static const struct acpi_gpio_params lineout_mute_gpio =
> { RT5660_GPIO_LINEOUT_MUTE, 0, true };
> +
> +static const struct acpi_gpio_mapping byt_rt5660_gpios[] = {
> +	{ "audio-wake-intr-gpios", &audio_wake_intr_gpio, 1 },
> +	{ "lineout-mute-gpios", &lineout_mute_gpio, 1 },
> +	{ NULL },
> +};
> +

I am thinking if it is more suitable to move the gpio params to
machine driver? They are not codec's gpios and are only used
by machine driver. 

> --
> 2.9.3
