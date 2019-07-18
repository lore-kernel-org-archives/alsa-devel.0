From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v5 2/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Thu, 18 Jul 2019 20:42:10 +0200
Message-ID: <9c9ee47c-48bd-7109-9870-8f73be1f1cfa@intel.com>
References: <20190718090240.18432-1-oleksandr.suvorov@toradex.com>
 <20190718090240.18432-3-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190718090240.18432-3-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Igor Opaniuk <igor.opaniuk@toradex.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2019-07-18 11:02, Oleksandr Suvorov wrote:
>   
> +enum {
> +	HP_POWER_EVENT,
> +	DAC_POWER_EVENT,
> +	ADC_POWER_EVENT,
> +	LAST_POWER_EVENT
> +};
> +
> +static u16 mute_mask[] = {
> +	SGTL5000_HP_MUTE,
> +	SGTL5000_OUTPUTS_MUTE,
> +	SGTL5000_OUTPUTS_MUTE
> +};

If mute_mask[] is only used within common handler, you may consider 
declaring const array within said handler instead (did not check that 
myself).
Otherwise, simple comment for the second _OUTPUTS_MUTE should suffice - 
its not self explanatory why you doubled that mask.

> +
>   /* sgtl5000 private structure in codec */
>   struct sgtl5000_priv {
>   	int sysclk;	/* sysclk rate */
> @@ -137,8 +157,109 @@ struct sgtl5000_priv {
>   	u8 micbias_voltage;
>   	u8 lrclk_strength;
>   	u8 sclk_strength;
> +	u16 mute_state[LAST_POWER_EVENT];
>   };
>   

When I spoke of LAST enum constant, I did not really had this specific 
usage in mind.

 From design perspective, _LAST_ does not exist and should never be 
referred to as "the next option" i.e.: new enum constant.
That is way preferred usage is:
u16 mute_state[ADC_POWER_EVENT+1;
-or-
u16 mute_state[LAST_POWER_EVENT+1];

Maybe I'm just being radical here :)

Czarek
