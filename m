From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/4] ASoC: rt5660: Add ACPI support
Date: Sat, 14 Jan 2017 00:30:08 +0200
Message-ID: <CAHp75VdeAZH9U=xnzva+vkTE_3jH7i7tRDQPmKcJ3TTdmj=J8A@mail.gmail.com>
References: <20170112120101.16933-1-shrirang.bagul@canonical.com>
 <20170112120101.16933-2-shrirang.bagul@canonical.com> <ABFD875FF5FB574BA706497D987D48D7012363F1@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7012363F1@RTITMBSV03.realtek.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Shrirang Bagul <shrirang.bagul@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 13, 2017 at 4:53 AM, Bard Liao <bardliao@realtek.com> wrote:
>> +static const struct acpi_gpio_mapping byt_rt5660_gpios[] = {
>> +     { "audio-wake-intr-gpios", &audio_wake_intr_gpio, 1 },
>> +     { "lineout-mute-gpios", &lineout_mute_gpio, 1 },
>> +     { NULL },
>> +};
>> +
>
> I am thinking if it is more suitable to move the gpio params to
> machine driver? They are not codec's gpios and are only used
> by machine driver.

Generally speaking those properties should come per ACPI ID. So, they
should share the same module which has MODULE_DEVICE_TABLE(acpi, ...)
defined.

-- 
With Best Regards,
Andy Shevchenko
