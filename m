From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: wm9713: convert to regmap
Date: Mon, 26 Oct 2015 12:27:20 +0100
Message-ID: <562E0E18.80500@metafoo.de>
References: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/24/2015 11:37 PM, Robert Jarzmik wrote:
[...]
> -static unsigned int ac97_read(struct snd_soc_codec *codec,
> -	unsigned int reg);
> -static int ac97_write(struct snd_soc_codec *codec,
> -	unsigned int reg, unsigned int val);

For review purposes it would be helpful to split this into two patches. One
performing the regmap conversion the other replacing
ac97_read()/ac97_write() with the matching snd_soc_ calls (or
snd_soc_update_bits).

> +	snd_soc_codec_init_regmap(codec, regmap);

You need to call snd_soc_odec_exit_regmap() when the CODEC is unbound.
