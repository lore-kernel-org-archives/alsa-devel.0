From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/3] ASoC: Add codec driver for ST
	TDA7802
Date: Tue, 30 Jul 2019 13:38:25 +0100
Message-ID: <20190730123825.GG54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-3-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B323AF80214
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 14:38:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-3-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Marco Felsch <m.felsch@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Nate Case <ncase@tesla.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Rob Duncan <rduncan@tesla.com>, Patrick Glaser <pglaser@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2019 at 01:09:36PM +0100, Thomas Preston wrote:
> Add an I2C based codec driver for ST TDA7802 amplifier. The amplifier
> supports 4 audio channels but can support up to 16 with multiple
> devices.
> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
> Changes since v1:
> - Use ALSA kcontrol interface to expose device controls to userland
> 	- Gain
> 	- Channel diagnostic mode
> 	- Impedance efficiency optimiser. I decided against setting this
> 	  as a DT property since it seems like something that can be
> 	  changed on the fly.
> - Add regmap default values
> 	- Channel unmute by default is added in a downstream patch.
> 	- I'm not sure if I should keep this since they're all zero,
> 	  although there are other drivers will all-zero reg_defaults.
> - I believe the "//" style is used for SPDX headers in normal C source files.
>   https://lwn.net/Articles/739183/
> - Drop the "enable" sysfs device attribute.
> - Don't set TDM format using magic numbers.
> - Set sample rate using hw_params.
> - Remove unecessary defines.
> - Use DAPM to handle AMP_ON.
> - Cosmetic fixups
> 
>  sound/soc/codecs/Kconfig   |   6 +
>  sound/soc/codecs/Makefile  |   2 +
>  sound/soc/codecs/tda7802.c | 509 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 517 insertions(+)
>  create mode 100644 sound/soc/codecs/tda7802.c
> 
> +++ b/sound/soc/codecs/tda7802.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tda7802.c  --  codec driver for ST TDA7802
> + *
> + * Copyright (C) 2016-2019 Tesla Motors, Inc.
> + */

Better to make the whole comment // see something like
sound/soc/codecs/cs47l35.c for an example.

> +static int tda7802_set_bias_level(struct snd_soc_component *component,
> +		enum snd_soc_bias_level level)
> +{
> +	const struct tda7802_priv *tda7802 =
> +		snd_soc_component_get_drvdata(component);
> +	struct snd_soc_dapm_context *dapm_context =
> +			snd_soc_component_get_dapm(component);
> +	const enum snd_soc_bias_level oldlevel =
> +		snd_soc_dapm_get_bias_level(dapm_context);
> +	int err = 0;
> +
> +	dev_dbg(component->dev, "%s level %d\n", __func__, level);
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		err = regulator_enable(tda7802->enable_reg);
> +		if (err < 0) {
> +			dev_err(component->dev, "Could not enable.\n");
> +			return err;
> +		}
> +		dev_dbg(component->dev, "Regulator enabled\n");
> +		msleep(ENABLE_DELAY_MS);
> +
> +		if (oldlevel == SND_SOC_BIAS_OFF) {
> +			dev_dbg(component->dev, "Syncing regcache\n");
> +			err = regcache_sync(component->regmap);
> +			if (err < 0)
> +				dev_err(component->dev,
> +					"Could not sync regcache, %d\n", err);

If your doing a regcache_sync I would probably have expected to
see calls to regcache_cache_only.

If the device needs syncing that implies the hardware registers
have lost state, so there is little point in writing to them
if they are unavailable/about to loose their state.

> +		}
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		regcache_mark_dirty(component->regmap);
> +		err = regulator_disable(tda7802->enable_reg);
> +		if (err < 0)
> +			dev_err(component->dev, "Could not disable.\n");
> +		break;
> +	}
> +
> +	return err;
> +}

Thanks,
Charles
