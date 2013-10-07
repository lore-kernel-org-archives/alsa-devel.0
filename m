From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: dapm: Add support for virtual
	mixer controls
Date: Mon, 7 Oct 2013 12:10:42 +0300
Message-ID: <52527A92.9050209@ti.com>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id E2509264F10
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 11:10:34 +0200 (CEST)
In-Reply-To: <1381059831-16074-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/06/2013 02:43 PM, Lars-Peter Clausen wrote:
> This patch adds support for virtual DAPM mixer controls. They are similar=
 to
> virtual DAPM enums. There is no hardware register backing the control, so
> changing the control's value wont have any direct effect on the hardware.=
 But it
> still influences the DAPM graph by causing the path it sits on to be conn=
ected
> or disconnected. This in turn can cause power changes for some of the wid=
gets on
> the DAPM graph, which will then modify the hardware state.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  include/sound/soc-dapm.h |  4 ++++
>  include/sound/soc.h      |  3 ++-
>  sound/soc/soc-dapm.c     | 45 +++++++++++++++++++++++++++---------------=
---
>  3 files changed, 33 insertions(+), 19 deletions(-)
> =

> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index 27a72d5..2037c45 100644
> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h
> @@ -286,6 +286,8 @@ struct device;
>  	.info =3D snd_soc_info_volsw, \
>  	.get =3D snd_soc_dapm_get_volsw, .put =3D snd_soc_dapm_put_volsw, \
>  	.private_value =3D SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
> +#define SOC_DAPM_SINGLE_VIRT(xname, max) \
> +	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0)
>  #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
>  {	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
>  	.info =3D snd_soc_info_volsw, \
> @@ -300,6 +302,8 @@ struct device;
>  	.tlv.p =3D (tlv_array), \
>  	.get =3D snd_soc_dapm_get_volsw, .put =3D snd_soc_dapm_put_volsw, \
>  	.private_value =3D SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
> +#define SOC_DAPM_SINGLE_TLV_VIRT(xname, max, tlv_array) \
> +	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0, tlv_array)
>  #define SOC_DAPM_ENUM(xname, xenum) \
>  {	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
>  	.info =3D snd_soc_info_enum_double, \
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 6dd329a..af1678c 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -1049,7 +1049,8 @@ struct snd_soc_pcm_runtime {
>  /* mixer control */
>  struct soc_mixer_control {
>  	int min, max, platform_max;
> -	unsigned int reg, rreg, shift, rshift;
> +	int reg, rreg;
> +	unsigned int shift, rshift;
>  	unsigned int invert:1;
>  	unsigned int autodisable:1;
>  };
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index c17c14c..25b9554 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -499,18 +499,22 @@ static void dapm_set_path_status(struct snd_soc_dap=
m_widget *w,
>  		int val;
>  		struct soc_mixer_control *mc =3D (struct soc_mixer_control *)
>  			w->kcontrol_news[i].private_value;
> -		unsigned int reg =3D mc->reg;
> +		int reg =3D mc->reg;
>  		unsigned int shift =3D mc->shift;
>  		int max =3D mc->max;
>  		unsigned int mask =3D (1 << fls(max)) - 1;
>  		unsigned int invert =3D mc->invert;
>  =

> -		val =3D soc_widget_read(w, reg);
> -		val =3D (val >> shift) & mask;
> -		if (invert)
> -			val =3D max - val;
> +		if (reg !=3D SND_SOC_NOPM) {
> +			val =3D soc_widget_read(w, reg);
> +			val =3D (val >> shift) & mask;
> +			if (invert)
> +				val =3D max - val;
> +			p->connect =3D !!val;
> +		} else {
> +			p->connect =3D 0;
> +		}
>  =

> -		p->connect =3D !!val;
>  	}
>  	break;
>  	case snd_soc_dapm_mux: {
> @@ -2791,7 +2795,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kco=
ntrol,
>  	struct snd_soc_card *card =3D codec->card;
>  	struct soc_mixer_control *mc =3D
>  		(struct soc_mixer_control *)kcontrol->private_value;
> -	unsigned int reg =3D mc->reg;
> +	int reg =3D mc->reg;
>  	unsigned int shift =3D mc->shift;
>  	int max =3D mc->max;
>  	unsigned int mask =3D (1 << fls(max)) - 1;
> @@ -2804,7 +2808,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kco=
ntrol,
>  			 kcontrol->id.name);
>  =

>  	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
> -	if (dapm_kcontrol_is_powered(kcontrol))
> +	if (dapm_kcontrol_is_powered(kcontrol) && reg !=3D SND_SOC_NOPM)
>  		val =3D (snd_soc_read(codec, reg) >> shift) & mask;
>  	else
>  		val =3D dapm_kcontrol_get_value(kcontrol);
> @@ -2835,7 +2839,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kco=
ntrol,
>  	struct snd_soc_card *card =3D codec->card;
>  	struct soc_mixer_control *mc =3D
>  		(struct soc_mixer_control *)kcontrol->private_value;
> -	unsigned int reg =3D mc->reg;
> +	int reg =3D mc->reg;
>  	unsigned int shift =3D mc->shift;
>  	int max =3D mc->max;
>  	unsigned int mask =3D (1 << fls(max)) - 1;
> @@ -2857,19 +2861,24 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *k=
control,
>  =

>  	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
>  =

> -	dapm_kcontrol_set_value(kcontrol, val);
> +	change =3D dapm_kcontrol_set_value(kcontrol, val);
>  =

> -	mask =3D mask << shift;
> -	val =3D val << shift;
> +	if (reg !=3D SND_SOC_NOPM) {
> +		mask =3D mask << shift;
> +		val =3D val << shift;
> +
> +		change =3D snd_soc_test_bits(codec, reg, mask, val);
> +	}
>  =

> -	change =3D snd_soc_test_bits(codec, reg, mask, val);
>  	if (change) {
> -		update.kcontrol =3D kcontrol;
> -		update.reg =3D reg;
> -		update.mask =3D mask;
> -		update.val =3D val;
> +		if (reg !=3D SND_SOC_NOPM) {
> +			update.kcontrol =3D kcontrol;
> +			update.reg =3D reg;
> +			update.mask =3D mask;
> +			update.val =3D val;
>  =

> -		card->update =3D &update;
> +			card->update =3D &update;
> +		}
>  =

>  		soc_dapm_mixer_update_power(card, kcontrol, connect);
>  =

> =



-- =

P=E9ter
