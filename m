From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: Add driver for CLPS711X DAI
	interface
Date: Thu, 1 May 2014 11:29:35 -0700
Message-ID: <20140501182935.GT3245@sirena.org.uk>
References: <1397283328-633-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4515601086344569221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95191265455
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 20:42:09 +0200 (CEST)
In-Reply-To: <1397283328-633-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org


--===============4515601086344569221==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8bPn4FL4u+7TADa"
Content-Disposition: inline


--c8bPn4FL4u+7TADa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 12, 2014 at 10:15:28AM +0400, Alexander Shiyan wrote:

> +static int clps711x_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct clps711x_dai *dai = snd_soc_platform_get_drvdata(rtd->platform);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		atomic_set(&dai->running, 1);
> +		hrtimer_start(&dai->hrt, ns_to_ktime(dai->reload),
> +			      HRTIMER_MODE_REL);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		atomic_set(&dai->running, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

This machinery seems pretty much identical to the FIQ code for i.MX -
I know you don't think anything can be shared but can you please be more
explicit about why?  The contents of the FIQ are different but the
start and stop mechanics don't look so different (and given that the
general idea of what they do is very similar this isn't surprising to
me).

> +static int clps711x_pcm_silence(struct snd_pcm_substream *substream,
> +				int channel, snd_pcm_uframes_t pos,
> +				snd_pcm_uframes_t count)
> +{
> +	/* Silence is provided in the FIQ interrupt routine */
> +	/* This empty function is necessary */
> +	return 0;
> +}

Why is it required?  It seems like what actually happens here is that
the FIQ handles underflow by playing zero bytes but that's not quite the
same thing as what silence does - we can still underflow after sending
silence, this is about sending an explicit amount of silence.

--c8bPn4FL4u+7TADa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYpKMAAoJELSic+t+oim9Y+gP/RNvMbeFlWiTHkC98Ko1PG3G
o7A7+6geNCiMtOdeTSAKAUKKGQZnlFJFh+f7j3EmCzT2mNXbTPEjts91jArVz2BE
TM5DHmI6XU8LdGoe/w2n1pxL6NrXeu9VI3YqxGkCgTobQGqOCp6iXuad32mQdw2T
aP2NZmAcT0stdh6XZ8t6FRWHM5H/Zytw+tLKk9heiOAkiGqNLu6Kqf4II3A0AWDQ
hh8L9H6HgbJq3KmMvLT7nZ57fu5qWwrqfNmqwG+CyjhO19Sf+uRj/48CsmSyt43L
vgIwZ5WqIakcI7ekDCSfd+x1TBIui9+jkjdpzmsof3ZtCoTURi8MPz3jj3ZTmApt
EWPgslRxxsE4yjy4AQW6uAx7WW9FU6tzw/5QaQIlwaZa7REMhqHl+iRKGHMeCO8m
Az+yxa6ep2h/jBVYaXl3w2RYzNRniRW8gj9hOQdbEFD5taascj0v22s7tkoMYmuC
BTeNOTnWLn1gyw5fJwaYLTqtgOw2Qbk+4MpXMcRuRvY/+S4h95p2aIfaYU/H2B1s
BrKGj1I66rWN676dZ1BbTUaSI/Tn/7etNrx3NVb7Ri5Hty7+qN/A29nNQhchd9t1
J9we+icKL0a01yDZ5/gQQZv9d72ddl3t0llsoGxLFcrrfKLg/y7gJZoCMg3sz4rv
EbqCmvwLfwBxiMFLWcAj
=NN7l
-----END PGP SIGNATURE-----

--c8bPn4FL4u+7TADa--

--===============4515601086344569221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4515601086344569221==--
