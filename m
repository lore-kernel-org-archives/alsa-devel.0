From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sirf: Add sirf audio hub driver
 for sharing same register address space
Date: Wed, 19 Mar 2014 18:25:34 +0000
Message-ID: <20140319182534.GT11706@sirena.org.uk>
References: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
 <1394707111-9539-2-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2986611497188401050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E4F726514A
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 19:25:48 +0100 (CET)
In-Reply-To: <1394707111-9539-2-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============2986611497188401050==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q0cnv6xNF3lEC3YB"
Content-Disposition: inline


--q0cnv6xNF3lEC3YB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 06:38:30PM +0800, RongJun Ying wrote:
> @@ -283,9 +jc83,10 @@ static int sirf_audio_codec_trigger(struct snd_pcm_=
substream *substream,
>  		int cmd,
>  		struct snd_soc_dai *dai)
>  {
> -	int playback =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
>  	struct snd_soc_codec *codec =3D dai->codec;
>  	u32 val =3D 0;
> +	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		return 0;
> =20
>  	/*
>  	 * This is a workaround, When stop playback,
> @@ -299,15 +300,13 @@ static int sirf_audio_codec_trigger(struct snd_pcm_=
substream *substream,
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
>  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> -		if (playback)
> -			val =3D IC_HSLEN | IC_HSREN;
> +		val =3D IC_HSLEN | IC_HSREN;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> =20
> -	if (playback)
> -		snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
> +	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
>  			IC_HSLEN | IC_HSREN, val);
>  	return 0;
>  }

All the changes in this file appear to be unrelated stylistic changes.
They're fine but you should do such things as separate commits, this
makes things harder to review.

> +/* This regmap is shared all child audio drivers */
> +struct regmap *regmap;

Why is this a global variable?  I'd expect it to be in the driver data
for the device.  This is also a global symbol so would at the very least
would need better namespacing.

> +
> +static const struct regmap_config sirf_audio_regmap_config =3D=20
> +	.reg_bits =3D
> +	.val_bits =3D 32,
> +	.cache_type =3D REGCACHE_NONE,

None is the default.

Looking at this code I'm not clear how the function devices get
instantiated?

--q0cnv6xNF3lEC3YB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKeEbAAoJELSic+t+oim99ekP/28CqyE+d+xkdDKHPQCLJfzE
ytqmgcru/sDEq3pAQcmcz+SIuzyD0GQRdLyz4HEoGjO7DkQ9VosmuMLwd5fue65y
I7EVKkJ0GrkTnyk2It2h0n/R0pKvkn8U09yimR4MSwG478wBRD7y48vQZlSpxmyb
QiaFpr7zcMbpK+Q6CIIWZlGWc1RcDv+hR7f0LzFegZmnH+bbkax1cnsOhBTIS4CR
O4PKsOzZXh6tDjEH47iNlX5VKGpx1BmYCi8stdeWaU2LxIhKPP8D7TXrIO+4I6p3
i3qsar7Cuau6+/eEhLGnJ87BOeCQymddyj0GPpXVLtRCu3Ui8Co4kqGyYLZqk3HO
eemaC0WWS0/e8rX5RmOT19C+x+mPeT2TCTJZuQXEFASmF9pe/OFP2YpsYIXeVGDj
UTEFaEilyP0jmzqxCQRcjYVaLlxgcZOOMEK3JxG7Zznzlo7qDwZbAoVmlPMXrf9R
Adtm5sTuKVj5bPUsmf4mRxjrA0+ODDS4FcO+JeUwgnyOQFou84kXA2RJo52E6Crq
HZMZXL6LVucc0vDsDVTnHxdtcGw/i+VN6zGI7R6+hpR3lxEZio7Ke7YA9zFg2vNm
JBbOdUbV0P2umJ+veQVGTeztFSKBIWC32MKj//Dc1mn5xh+ior5y21Kgk157cu61
kxlIH+jcQCm76v9aytXC
=zu4A
-----END PGP SIGNATURE-----

--q0cnv6xNF3lEC3YB--

--===============2986611497188401050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2986611497188401050==--
