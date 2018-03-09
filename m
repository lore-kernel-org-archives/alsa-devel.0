From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Fri, 9 Mar 2018 12:50:50 +0000
Message-ID: <20180309125050.GD5252@sirena.org.uk>
References: <20180308200653.GA47801@beast>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0845275017821549227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8391B2675BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 13:50:56 +0100 (CET)
In-Reply-To: <20180308200653.GA47801@beast>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kees Cook <keescook@chromium.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: alsa-devel@alsa-project.org


--===============0845275017821549227==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:

> If a codec is not attached to the sound soc, a NULL deref is possible as a
> regular user in /sys.

I can't parse this, sorry.  What is the "sound soc"?

> +++ b/sound/soc/soc-core.c
> @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_code=
c *codec, char *buf,
>  	size_t total =3D 0;
>  	loff_t p =3D 0;
> =20
> +	if (!codec || !codec->driver)
> +		return 0;
> +

How are we managing to create a sysfs file for a CODEC which doesn't
have a CODEC struct associated with it?  That is obviously nonsensical
and suggests we've got some more serious problem going on here - if
there's no CODEC those sysfs attributes simply shouldn't be there.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqigyoACgkQJNaLcl1U
h9DiVQf/X7ZSftcm7/aW6N5+2aqS/gdxfYU4v8jETHcyr6Lqq/DR+/B7qv149I7i
k5fjo/RSG7lb7nKZZc8Bqa6NnO+6YyTVWGMQrW5pwYHKbFCTY/13yDZhUQiYuQuX
wBQfoA1wXCtHU2Q+JimDZXcR3FoFv5C68i9AhL0Rvd53oWeqSFPgFYJL4fkapYtY
DAih4xg3Ho+1ZUKJpzpGJ2fUQNy6EYyDr3lYEMxIC9TeV7V7WORgzX65o65Bb6wS
WeSAZx9izRZhdX7xYo+VRtjcslmMY5ZabegSrrR+wOwVqx5JIBok9ISymi85lz5J
hwqQMOh9/kZZwxA4lknhFXXVtganEA==
=/0cK
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

--===============0845275017821549227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0845275017821549227==--
