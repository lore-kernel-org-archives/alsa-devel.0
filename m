From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: Do DAPM control updates in the
	middle of DAPM sequences
Date: Thu, 16 Dec 2010 15:03:09 +0200
Message-ID: <201012161503.09095.peter.ujfalusi@nokia.com>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E65292441B
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 14:03:10 +0100 (CET)
In-Reply-To: <1292349202-25538-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 December 2010 19:53:22 ext Mark Brown wrote:
> @@ -1634,13 +1671,12 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol
> *kcontrol, (struct soc_mixer_control *)kcontrol->private_value; unsigned
> int reg =3D mc->reg;
>         unsigned int shift =3D mc->shift;
> -       unsigned int rshift =3D mc->rshift;
>         int max =3D mc->max;
>         unsigned int mask =3D (1 << fls(max)) - 1;
>         unsigned int invert =3D mc->invert;
> -       unsigned int val, val2, val_mask;
> -       int connect;
> -       int ret;
> +       unsigned int val, val_mask;
> +       int connect, change;

You do not need the change variable, since

> +       struct snd_soc_dapm_update update;
> =

>         val =3D (ucontrol->value.integer.value[0] & mask);
> =

> @@ -1648,18 +1684,12 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol
> *kcontrol, val =3D max - val;
>         val_mask =3D mask << shift;
>         val =3D val << shift;
> -       if (shift !=3D rshift) {
> -               val2 =3D (ucontrol->value.integer.value[1] & mask);
> -               if (invert)
> -                       val2 =3D max - val2;
> -               val_mask |=3D mask << rshift;
> -               val |=3D val2 << rshift;
> -       }
> =

>         mutex_lock(&widget->codec->mutex);
>         widget->value =3D val;
> =

> -       if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
> +       change =3D snd_soc_test_bits(widget->codec, reg, val_mask, val);
> +       if (change) {

it is used only here, so you could just keep the old if () way.

>                 if (val)
>                         /* new connection */
>                         connect =3D invert ? 0:1;
> @@ -1667,28 +1697,20 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol
> *kcontrol, /* old connection must be powered down */
>                         connect =3D invert ? 1:0;
> =

> +               update.kcontrol =3D kcontrol;
> +               update.widget =3D widget;
> +               update.reg =3D reg;
> +               update.mask =3D mask;
> +               update.val =3D val;
> +               widget->dapm->update =3D &update;
> +
>                 dapm_mixer_update_power(widget, kcontrol, connect);
> +
> +               widget->dapm->update =3D NULL;
>         }
> =

> -       if (widget->event) {
> -               if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
> -                       ret =3D widget->event(widget, kcontrol,
> -                                               SND_SOC_DAPM_PRE_REG);
> -                       if (ret < 0) {
> -                               ret =3D 1;
> -                               goto out;
> -                       }
> -               }
> -               ret =3D snd_soc_update_bits(widget->codec, reg, val_mask,
> val); -               if (widget->event_flags & SND_SOC_DAPM_POST_REG)
> -                       ret =3D widget->event(widget, kcontrol,
> -                                               SND_SOC_DAPM_POST_REG);
> -       } else
> -               ret =3D snd_soc_update_bits(widget->codec, reg, val_mask,
> val); -
> -out:
>         mutex_unlock(&widget->codec->mutex);
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);

-- =

P=E9ter
