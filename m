From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: usb audio race at disconnect time
Date: Fri, 12 Oct 2012 17:42:19 +0200
Message-ID: <50783A5B.9090009@parrot.com>
References: <5076E327.5030503@parrot.com> <s5hvceh9d0v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hvceh9d0v.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ALSA devel <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,


Takashi Iwai a =E9crit :
> [Added Daniel and Clemens in the loop]
>=20
>=20
> I don't think this is needed.
>=20
> So... the below is a quick hack I did without testing at all.
> Hopefully this can give some advance.
Thanks for the quick patch.

The patch didn't apply cleany of linus tree, of which tree is based you=
r patch ?

It solve the race in snd_usb_hw_params.

But I wonder if snd_usb_substream_playback_trigger,
snd_usb_substream_capture_trigger, snd_usb_pcm_pointer are safe : they =
don't
take shutdown_mutex.

Also it is hard to check if everything is safe. Sometimes the chip->shu=
tdown is
far from the shutdown_mutex. For example snd_usb_pcm_open take shutdown=
_mutex,
but the check is done in snd_usb_autoresume.

I will do more testing.

Thanks,

Matthieu
>=20
>=20
> Takashi
>=20
> ---
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 561bb74..115484e 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -131,9 +131,13 @@ static void snd_usb_stream_disconnect(struct lis=
t_head *head)
>  		subs =3D &as->substream[idx];
>  		if (!subs->num_formats)
>  			continue;
> +		if (subs->pcm_substream)
> +			snd_pcm_stream_lock_irq(subs->pcm_substream);
>  		subs->interface =3D -1;
>  		subs->data_endpoint =3D NULL;
>  		subs->sync_endpoint =3D NULL;
> +		if (subs->pcm_substream)
> +			snd_pcm_stream_unlock_irq(subs->pcm_substream);
>  	}
>  }
> =20
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index 55e19e1..01e82ac 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -444,7 +444,6 @@ static int configure_endpoint(struct snd_usb_subs=
tream *subs)
>  {
>  	int ret;
> =20
> -	mutex_lock(&subs->stream->chip->shutdown_mutex);
>  	/* format changed */
>  	stop_endpoints(subs, 0, 0, 0);
>  	ret =3D snd_usb_endpoint_set_params(subs->data_endpoint,
> @@ -455,7 +454,7 @@ static int configure_endpoint(struct snd_usb_subs=
tream *subs)
>  					  subs->cur_audiofmt,
>  					  subs->sync_endpoint);
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
> =20
>  	if (subs->sync_endpoint)
>  		ret =3D snd_usb_endpoint_set_params(subs->data_endpoint,
> @@ -466,8 +465,6 @@ static int configure_endpoint(struct snd_usb_subs=
tream *subs)
>  						  subs->cur_audiofmt,
>  						  NULL);
> =20
> -unlock:
> -	mutex_unlock(&subs->stream->chip->shutdown_mutex);
>  	return ret;
>  }
> =20
> @@ -488,10 +485,15 @@ static int snd_usb_hw_params(struct snd_pcm_sub=
stream *substream,
>  	struct audioformat *fmt;
>  	int ret;
> =20
> +	mutex_lock(&subs->stream->chip->shutdown_mutex);
> +	if (subs->stream->chip->shutdown) {
> +		ret =3D -ENODEV;
> +		goto unlock;
> +	}
>  	ret =3D snd_pcm_lib_alloc_vmalloc_buffer(substream,
>  					       params_buffer_bytes(hw_params));
>  	if (ret < 0)
> -		return ret;
> +		goto unlock;
> =20
>  	subs->pcm_format =3D params_format(hw_params);
>  	subs->period_bytes =3D params_period_bytes(hw_params);
> @@ -502,17 +504,20 @@ static int snd_usb_hw_params(struct snd_pcm_sub=
stream *substream,
>  	if (!fmt) {
>  		snd_printd(KERN_DEBUG "cannot set format: format =3D %#x, rate =3D=
 %d, channels =3D %d\n",
>  			   subs->pcm_format, subs->cur_rate, subs->channels);
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +		goto unlock;
>  	}
> =20
>  	if ((ret =3D set_format(subs, fmt)) < 0)
> -		return ret;
> +		goto unlock;
> =20
>  	subs->interface =3D fmt->iface;
>  	subs->altset_idx =3D fmt->altset_idx;
>  	subs->need_setup_ep =3D true;
> =20
> -	return 0;
> + unlock:
> +	mutex_unlock(&subs->stream->chip->shutdown_mutex);
> +	return ret;
>  }
> =20
>  /*
> @@ -547,17 +552,26 @@ static int snd_usb_pcm_prepare(struct snd_pcm_s=
ubstream *substream)
>  	struct usb_interface *iface;
>  	int ret;
> =20
> +	mutex_lock(&subs->stream->chip->shutdown_mutex);
> +	if (subs->stream->chip->shutdown) {
> +		ret =3D -ENODEV;
> +		goto unlock;
> +	}
> +
>  	if (! subs->cur_audiofmt) {
>  		snd_printk(KERN_ERR "usbaudio: no format is specified!\n");
> -		return -ENXIO;
> +		ret =3D -ENXIO;
> +		goto unlock;
>  	}
> =20
> -	if (snd_BUG_ON(!subs->data_endpoint))
> -		return -EIO;
> +	if (snd_BUG_ON(!subs->data_endpoint)) {
> +		ret =3D -EIO;
> +		goto unlock;
> +	}
> =20
>  	ret =3D set_format(subs, subs->cur_audiofmt);
>  	if (ret < 0)
> -		return ret;
> +		goto unlock;
> =20
>  	iface =3D usb_ifnum_to_if(subs->dev, subs->cur_audiofmt->iface);
>  	alts =3D &iface->altsetting[subs->cur_audiofmt->altset_idx];
> @@ -567,12 +581,12 @@ static int snd_usb_pcm_prepare(struct snd_pcm_s=
ubstream *substream)
>  				       subs->cur_audiofmt,
>  				       subs->cur_rate);
>  	if (ret < 0)
> -		return ret;
> +		goto unlock;
> =20
>  	if (subs->need_setup_ep) {
>  		ret =3D configure_endpoint(subs);
>  		if (ret < 0)
> -			return ret;
> +			goto unlock;
>  		subs->need_setup_ep =3D false;
>  	}
> =20
> @@ -592,8 +606,10 @@ static int snd_usb_pcm_prepare(struct snd_pcm_su=
bstream *substream)
>  	/* for playback, submit the URBs now; otherwise, the first hwptr_do=
ne
>  	 * updates for all URBs would happen at the same time when starting=
 */
>  	if (subs->direction =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> -		return start_endpoints(subs, 1);
> +		ret =3D start_endpoints(subs, 1);
> =20
> + unlock:
> +	mutex_unlock(&subs->stream->chip->shutdown_mutex);
>  	return 0;
>  }
> =20
> @@ -980,14 +996,18 @@ static int snd_usb_pcm_open(struct snd_pcm_subs=
tream *substream, int direction)
>  	struct snd_usb_stream *as =3D snd_pcm_substream_chip(substream);
>  	struct snd_pcm_runtime *runtime =3D substream->runtime;
>  	struct snd_usb_substream *subs =3D &as->substream[direction];
> +	int ret;
> =20
> +	mutex_lock(&as->chip->shutdown_mutex);
>  	subs->interface =3D -1;
>  	subs->altset_idx =3D 0;
>  	runtime->hw =3D snd_usb_hardware;
>  	runtime->private_data =3D subs;
>  	subs->pcm_substream =3D substream;
>  	/* runtime PM is also done there */
> -	return setup_hw_info(runtime, subs);
> +	ret =3D setup_hw_info(runtime, subs);
> +	mutex_unlock(&as->chip->shutdown_mutex);
> +	return ret;
>  }
> =20
>  static int snd_usb_pcm_close(struct snd_pcm_substream *substream, in=
t direction)
> @@ -995,6 +1015,7 @@ static int snd_usb_pcm_close(struct snd_pcm_subs=
tream *substream, int direction)
>  	struct snd_usb_stream *as =3D snd_pcm_substream_chip(substream);
>  	struct snd_usb_substream *subs =3D &as->substream[direction];
> =20
> +	mutex_lock(&as->chip->shutdown_mutex);
>  	stop_endpoints(subs, 0, 0, 0);
> =20
>  	if (!as->chip->shutdown && subs->interface >=3D 0) {
> @@ -1004,6 +1025,7 @@ static int snd_usb_pcm_close(struct snd_pcm_sub=
stream *substream, int direction)
> =20
>  	subs->pcm_substream =3D NULL;
>  	snd_usb_autosuspend(subs->stream->chip);
> +	mutex_unlock(&as->chip->shutdown_mutex);
> =20
>  	return 0;
>  }
> @@ -1222,6 +1244,9 @@ static int snd_usb_substream_playback_trigger(s=
truct snd_pcm_substream *substrea
>  {
>  	struct snd_usb_substream *subs =3D substream->runtime->private_data=
;
> =20
> +	if (subs->stream->chip->shutdown)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
