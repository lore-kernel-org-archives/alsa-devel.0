From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 2/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Wed, 17 Jul 2019 13:48:43 -0300
Message-ID: <CAOMZO5AgCqH+8W36vh4n3tCFvqUE=H+4Zp0jG1NQi5UFOsSSAQ@mail.gmail.com>
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190717163014.429-3-oleksandr.suvorov@toradex.com>
Sender: stable-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> Change VAG power on/off control according to the following algorithm:
> - turn VAG power ON on the 1st incoming event.
> - keep it ON if there is any active VAG consumer (ADC/DAC/HP/Line-In).
> - turn VAG power OFF when there is the latest consumer's pre-down event
>   come.
> - always delay after VAG power OFF to avoid pop.
> - delay after VAG power ON if the initiative consumer is Line-In, this
>   prevents pop during line-in muxing.
>
> Also, according to the data sheet [1], to avoid any pops/clicks,
> the outputs should be muted during input/output
> routing changes.
>
> [1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Fixes: 9b34e6cc3bc2 ("ASoC: Add Freescale SGTL5000 codec support")

Reviewed-by: Fabio Estevam <festevam@gmail.com>

By the way, I prefer the description you put in the cover letter as it
explicitly talks about a bug being fixed.
