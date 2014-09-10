From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Xense support
Date: Wed, 10 Sep 2014 17:38:31 +0200
Message-ID: <54107077.7030203@ladisch.de>
References: <20140910141813.B328C258D256@mx02.posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 31616265558
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 17:38:33 +0200 (CEST)
In-Reply-To: <20140910141813.B328C258D256@mx02.posteo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harley Griggs <hgriggs@posteo.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Harley Griggs wrote:
> This patch adds support for the Xonar Xense card.

The title is misleading.  This is "partial support" or "stereo-only support".

> +++ b/sound/pci/oxygen/xonar_pcm179x.c

> +	data->broken_i2c = true;

It's not.  (There is no other chip at address 1001110.)

> +	data->dacs = chip->model.dac_channels_mixer / 2;

This variable counts PCM1796 chips.

> +static int xense_output_switch_put(struct snd_kcontrol *ctl,
> +               struct snd_ctl_elem_value *value)
> +{
> +...
> +	case 2:
> +		gpio &= ~(GPIO_XENSE_SPEAKERS | GPIO_ST_HP_REAR);
> +	break;

Indent.

> +static int xonar_xense_mixer_init(struct oxygen *chip)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < ARRAY_SIZE(xense_controls); ++i) {
> +		err = snd_ctl_add(chip->card,
> +		snd_ctl_new1(&xense_controls[i], chip));
> +		if (err < 0)
> +		return err;
> +	}

Same here.

> @@ -1146,6 +1273,14 @@ int get_xonar_pcm179x_model(struct oxygen *chip,
> +	case 0x8428:
> +		chip->model = model_xonar_st;
> +		chip->model.shortname = "Xonar Xense";
> +		chip->model.chip = "AV100";
> +		chip->model.init = xonar_xense_init;
> +		chip->model.mixer_init = xonar_xense_mixer_init;
> +		break;
> +

Why the empty line?


Regards,
Clemens
