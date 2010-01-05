From: michael@cadilhac.name (=?iso-8859-1?Q?Micha=EBl?= Cadilhac)
Subject: Re: Getting pcm_usb_stream plugin to know its limits.
	[Kind of SOLVED]
Date: Mon, 04 Jan 2010 22:26:23 -0500
Message-ID: <87y6kdz0yo.fsf@cadilhac.name>
References: <87ljgkuzdl.fsf@cadilhac.name> <87eimbvkxg.fsf@cadilhac.name>
	<87aawzviyd.fsf_-_@cadilhac.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 3200510380B
	for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2010 04:26:51 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NS04H-0006Oa-4g
	for alsa-devel@alsa-project.org; Tue, 05 Jan 2010 04:26:49 +0100
Received: from 64.235.212.30 ([64.235.212.30])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Jan 2010 04:26:49 +0100
Received: from michael by 64.235.212.30 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 05 Jan 2010 04:26:49 +0100
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
List-Id: alsa-devel@alsa-project.org

michael@cadilhac.name (Micha=EBl Cadilhac) writes:

> So, my final saying is the following patch.  It fixes the segfault on
> stopping a non-started usb_stream, plus it adds the ability to set a
> period size and sound rate.  The latter offers a workaround for the
> second issue I came with (that the default values for period bytes, and
> hence period size, were too high for us122l to work).

Any comment on that patch would be greatly appreciated.  I'm just
wondering if it's safe for me to give it to some people.

> --- /dd/alsa-plugins/usb_stream/pcm_usb_stream.c	2008-11-21 18:08:16.0000=
00000 -0500
> +++ pcm_usb_stream.c	2009-12-30 23:40:46.467973740 -0500
> @@ -48,6 +48,9 @@
>  #define VDBG(f, ...)
>  #endif
>  =

> +#define FRAME_SIZE 6
> +
> +
>  #define LCARD 32
>  struct user_usb_stream {
>  	char			card[LCARD];
> @@ -70,6 +73,8 @@
>  	unsigned		periods_done;
>  =

>  	unsigned 		channels;
> +	snd_pcm_uframes_t	period_size;
> +	unsigned int		rate;
>  } snd_pcm_us_t;
>  =

>  static struct user_usb_stream *uus;
> @@ -177,7 +182,7 @@
>  	VDBG("");
>  =

>  	us_cfg.version =3D USB_STREAM_INTERFACE_VERSION;
> -	us_cfg.frame_size =3D 6;
> +	us_cfg.frame_size =3D FRAME_SIZE;
>  	us_cfg.sample_rate =3D io->rate;
>  	us_cfg.period_frames =3D io->period_size;
>  =

> @@ -256,8 +261,11 @@
>  static int snd_pcm_us_stop(snd_pcm_ioplug_t *io)
>  {
>  	snd_pcm_us_t *us =3D io->private_data;
> -	VDBG("%u", us->uus->s->periods_done);
>  =

> +	if (!us->uus->s)
> +	  return 0;
> +
> +	VDBG("%u", us->uus->s->periods_done);
>  	if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK)
>  		memset(us->uus->write_area, 0, us->uus->s->write_size);
>  =

> @@ -370,6 +378,10 @@
>  	};
>  =

>  	int err;
> +	unsigned int rate_min =3D us->rate ? us->rate : 44100,
> +		rate_max =3D us->rate ? us->rate : 96000,
> +		period_bytes_min =3D us->period_size ? FRAME_SIZE * us->period_size : =
128,
> +		period_bytes_max =3D us->period_size ? FRAME_SIZE * us->period_size : =
64*4096;
>  =

>  	if ((err =3D snd_pcm_ioplug_set_param_list(&us->io, SND_PCM_IOPLUG_HW_A=
CCESS,
>  						 ARRAY_SIZE(access_list), access_list)) < 0 ||
> @@ -378,19 +390,20 @@
>  	    (err =3D snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW=
_CHANNELS,
>  						   us->channels, us->channels)) < 0 ||
>  	    (err =3D snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW=
_RATE,
> -						   44100, 96000)) < 0 ||
> +						   rate_min, rate_max)) < 0 ||
>  	    (err =3D snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW=
_PERIOD_BYTES,
> -						   128, 64*4096)) < 0 ||
> +						   period_bytes_min, period_bytes_max)) < 0 ||
>  	    (err =3D snd_pcm_ioplug_set_param_minmax(&us->io, SND_PCM_IOPLUG_HW=
_PERIODS,
>  						   2, 2)) < 0)
>  		return err;
> -
>  	return 0;
>  }
>  =

>  static int snd_pcm_us_open(snd_pcm_t **pcmp, const char *name,
>  				   const char *card,
> -				   snd_pcm_stream_t stream, int mode)
> +			   snd_pcm_stream_t stream, int mode,
> +			   snd_pcm_uframes_t period_size,
> +			   unsigned int rate)
>  {
>  	snd_pcm_us_t *us;
>  	int err;
> @@ -421,6 +434,8 @@
>  	snd_hwdep_poll_descriptors(us->hwdep, &us->pfd, 1);
>  =

>  	us->channels =3D 2;
> +	us->period_size =3D period_size;
> +	us->rate =3D rate;
>  =

>  	us->io.version =3D SND_PCM_IOPLUG_VERSION;
>  	us->io.name =3D "ALSA <-> USB_STREAM PCM I/O Plugin";
> @@ -455,6 +470,7 @@
>  	snd_config_iterator_t i, next;
>  	const char *card;
>  	int err;
> +	long period_size =3D 0, rate =3D 0;
>  	=

>  	snd_config_for_each(i, next, conf) {
>  		snd_config_t *n =3D snd_config_iterator_entry(i);
> @@ -472,12 +488,27 @@
>  			snd_config_get_string(n, &card);
>  			continue;
>  		}
> +		if (strcmp(id, "period_size") =3D=3D 0) {
> +			if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_INTEGER) {
> +				SNDERR("Invalid type for %s", id);
> +				return -EINVAL;
> +			}
> +			snd_config_get_integer(n, &period_size);
> +			continue;
> +		}
> +		if (strcmp(id, "rate") =3D=3D 0) {
> +			if (snd_config_get_type(n) !=3D SND_CONFIG_TYPE_INTEGER) {
> +				SNDERR("Invalid type for %s", id);
> +				return -EINVAL;
> +			}
> +			snd_config_get_integer(n, &rate);
> +			continue;
> +		}
>  		SNDERR("Unknown field %s", id);
>  		return -EINVAL;
>  	}
>  =

> -	err =3D snd_pcm_us_open(pcmp, name, card, stream, mode);
> -
> +	err =3D snd_pcm_us_open(pcmp, name, card, stream, mode, period_size, ra=
te);
>  	return err;
>  }

-- =

Micha=EBl `Micha' Cadilhac (LITQ, U. de Montr=E9al) -- http://michael.cadil=
hac.name
	|| <ESC>ape this <COLON> thing,
	||   <Q>uit and do <NOT> <RET>urn.
	||         -- VI
