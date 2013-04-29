From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC : playback and capture counts in soc_new_pcm
Date: Mon, 29 Apr 2013 21:43:23 +0100
Message-ID: <20130429204323.GJ3270@sirena.org.uk>
References: <CANXQt8a6XyQVgb50+e-jQ-QXn5d-fS_AGZZrnXo4oU9WOQbKXw@mail.gmail.com>
 <CANXQt8ans6uVNqT2V7MuGuRu47fLE-2vWaegBYOTxnAezZ7GZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6402587337324220982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BE112616B4
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 22:43:26 +0200 (CEST)
In-Reply-To: <CANXQt8ans6uVNqT2V7MuGuRu47fLE-2vWaegBYOTxnAezZ7GZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: JongHo Kim <furmuwon@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6402587337324220982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
Content-Disposition: inline


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2013 at 04:55:51PM +0900, JongHo Kim wrote:
> 2013/3/5 JongHo Kim <furmuwon@gmail.com>

> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2014,9 +2014,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
> num)
>                 if (cpu_dai->driver->capture.channels_min)
>                         capture = 1;
>         } else {
> -               if (codec_dai->driver->playback.channels_min)
> +               if (codec_dai->driver->playback.channels_min &&
> +                   cpu_dai->driver->playback.channels_min)
>                         playback = 1;
> -               if (codec_dai->driver->capture.channels_min)
> +               if (codec_dai->driver->capture.channels_min &&
> +                   cpu_dai->driver->capture.channels_min)
>                         capture = 1;
>         }

This looks reasonably sensible - can you please submit using the process
in Documentation/SubmittingPatches (ie, CC the maintainers and include a
changelog and so on with Signed-off-by)?

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRfttoAAoJELSic+t+oim9VFgP/iq56Bd3hLSYedn5Pe1ASKlT
NaxwytsjJjFHbKcwTbRtstFCYt5+4JXNzFRY8w2ayrImO7npF+hTRELaosYKXkMv
YH8CPsVNyzhXSqQ1ySZxYbClF7ihcrNjF5Rf8GOvU7xNDhlfxFWVC95fl5g5Ci18
mJqmvpocWdl+OItSS5FP1L/ypq0ybw7UBBD+ddJBAiMNiX5KKp6BKZnW6AJXgKai
v7XGImscyzYKIRnVYlaZ84D5BkGSzToNYNYnvE53gmKsdUhi5pjaq284vG/ZSMMx
iLCyQQ9R13igXXSYmSDj+YIY16+tEFgmTp7o6+LbLtoIGKp1YJLXNWQANpaSlkg0
NR6Swzb3NX2FroCqgDw0jvIkctpEtmT4vv4w422Ih8TxiPl3p3DtJalIRt4Zzh9t
vduRKtlmZbxgcXWvMjGeSh7mCKNLTLMUHj/qXdhHlifYV5SzGUHO5bfS/3R8QUSy
WiC0j2TxUTpZHd8ZKzpz6uo5TXoXTPyOj+YwJ8gaY+D6OgsiL9cK8PABNBmUmFlm
pU2eQCAy9mRFsUH/sX77Fb+qCd3U2CvnO+dVdowbABtmDyxORm9wFvax+qxcxIGx
ACEgImRek2XeRjd1PwIwD3CoZblTUyafYiwEJz5vYlTCZvXin85ropPVXcMfjQ/6
2MSxmI4Tp5plYQzNJZpP
=sxiS
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--

--===============6402587337324220982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6402587337324220982==--
