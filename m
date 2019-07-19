From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v6 2/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Fri, 19 Jul 2019 13:19:31 +0200
Message-ID: <a4bcf146-4e5a-09be-599e-0ba12113d128@intel.com>
References: <20190719100524.23300-1-oleksandr.suvorov@toradex.com>
 <20190719100524.23300-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719100524.23300-3-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 2019-07-19 12:05, Oleksandr Suvorov wrote:
> VAG power control is improved to fit the manual [1]. This patch fixes as
> minimum one bug: if customer muxes Headphone to Line-In right after boot,
> the VAG power remains off that leads to poor sound quality from line-in.
> 
> I.e. after boot:
>    - Connect sound source to Line-In jack;
>    - Connect headphone to HP jack;
>    - Run following commands:
>    $ amixer set 'Headphone' 80%
>    $ amixer set 'Headphone Mux' LINE_IN
> 
> Change VAG power on/off control according to the following algorithm:
>    - turn VAG power ON on the 1st incoming event.
>    - keep it ON if there is any active VAG consumer (ADC/DAC/HP/Line-In).
>    - turn VAG power OFF when there is the latest consumer's pre-down event
>      come.
>    - always delay after VAG power OFF to avoid pop.
>    - delay after VAG power ON if the initiative consumer is Line-In, this
>      prevents pop during line-in muxing.
> 
> According to the data sheet [1], to avoid any pops/clicks,
> the outputs should be muted during input/output
> routing changes.
> 
> [1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf
> 
> Cc: stable@vger.kernel.org
> Fixes: 9b34e6cc3bc2 ("ASoC: Add Freescale SGTL5000 codec support")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> ---
> 
> Changes in v6:
> - Code optimization

You went crazy with that description (u16 mute_mask[]) :)

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
