From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH RFC v1] ASoC: core: Support for limiting
	the volume
Date: Fri, 7 May 2010 10:26:35 +0300
Message-ID: <201005071026.35702.peter.ujfalusi@nokia.com>
References: <1273212185-7129-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EF8D243E2
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 09:26:57 +0200 (CEST)
In-Reply-To: <1273212185-7129-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Friday 07 May 2010 09:03:05 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> Add support for the core to limit the maximum volume on an
> existing control.
> The function will modify the soc_mixer_control.max value
> of the given control.
> The new value must be lower than the original one (chip maximum)
> =

> If there is a need for limiting a gain on a given control,
> than machine drivers can do the following in their
> snd_soc_dai_link.init function:
> =

> snd_soc_limit_volume(codec, "TPA6140A2 Headphone Playback Volume", 21);
> =

> This will modify the original 31 (chip maximum) to 21, so user
> space will not be able to set the gain higher than this.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
> =

> Hello Mark, Liam,
> =

> So this is my proposed way of doing the volume limiting within the core.
> By looking around the code, this should be safe.
> With this simple function all machine driver can limit gains on a given
> control in a way, that the codec/amp driver does not need to be involved.
> =

> What do you think?
> =

> ---
> Peter
> =

>  include/sound/soc.h  |    2 ++
>  sound/soc/soc-core.c |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 0 deletions(-)
> =

> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 01e9c66..9f306f0 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -326,6 +326,8 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontro=
l,
>  	struct snd_ctl_elem_value *ucontrol);
>  int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
>  	struct snd_ctl_elem_value *ucontrol);
> +int snd_soc_limit_volume(struct snd_soc_codec *codec,
> +	const char *name, int max);
> =

>  /**
>   * struct snd_soc_jack_pin - Describes a pin to update based on jack
> detection diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index d59076e..5968499 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2238,6 +2238,44 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol
> *kcontrol, EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
> =

>  /**
> + * snd_soc_limit_volume - Set new limit to an existing volume control.
> + *
> + * @codec: where to look for the control
> + * @name: Name of the control
> + * @max: new maximum limit
> + *
> + * Return 0 for success, else error.
> + */
> +int snd_soc_limit_volume(struct snd_soc_codec *codec,
> +	const char *name, int max)
> +{
> +	struct snd_card *card =3D codec->card;
> +	struct snd_kcontrol *kctl;
> +	struct soc_mixer_control *mc;
> +	int found =3D 0;
> +	int ret =3D -EINVAL;
> +
> +	/* Sanity check for name and max */
> +	if (unlikely(!name || max <=3D 0))
> +		return -EINVAL;
> +
> +	list_for_each_entry(kctl, &card->controls, list) {
> +		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name))) {
> +			found =3D 1;
> +			break;
> +		}
> +	}
> +	if (found) {
> +		mc =3D (struct soc_mixer_control *)kctl->private_value;
> +		if (max < mc->max)
> +			mc->max =3D max;
> +		ret =3D 0;

Probably it would be better to return with 0 only, if we _changed_ the maxi=
mum.
I'll resend after the comments.

> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_limit_volume);
> +
> +/**
>   * snd_soc_dai_set_sysclk - configure DAI system or master clock.
>   * @dai: DAI
>   * @clk_id: DAI specific clock ID

-- =

P=E9ter
