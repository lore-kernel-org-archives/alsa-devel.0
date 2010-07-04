From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: Add SmartQ sound driver
Date: Sun, 04 Jul 2010 12:03:33 +0200
Message-ID: <4C305C75.1060305@gmail.com>
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

 Op 03-07-10 02:46, Maurus Cuelenaere schreef:
> +static struct snd_soc_jack_pin smartq_jack_pins[] = {
> +	/* Disable speaker when headphone is plugged in */
> +	{
> +		.pin	= "Internal Speaker",
> +		.mask	= SND_JACK_HEADPHONE,
> +		.invert	= true,
> +	},
> +};

Hmm I just discovered that this .invert should be false (guess I didn't test enough), should I resubmit this patch or submit an incremental one?

-- 
Maurus Cuelenaere
