From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix incorrect condition check for case
 SNDRV_PCM_TRIGGER_SUSPEND
Date: Mon, 12 May 2014 21:16:31 +0100
Message-ID: <20140512201631.GF12304@sirena.org.uk>
References: <1399896725-28083-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kFa0FWpjwNIzuSe5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399896725-28083-1-git-send-email-Guangyu.Chen@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--kFa0FWpjwNIzuSe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2014 at 08:12:05PM +0800, Nicolin Chen wrote:
> The regular state before we execute SNDRV_PCM_TRIGGER_SUSPEND should be
> SNDRV_PCM_TRIGGER_START, not SNDRV_PCM_TRIGGER_STOP. Thus fix it.

Applied, thanks.

--kFa0FWpjwNIzuSe5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcSwcAAoJELSic+t+oim9QJIP/RN8flUV4fX6+gmhkaAbQFFs
1xl58MKx6qpOyVOER/sTkmWV/OsI2+JN4fIcw9H4cFT9hJsTLWcsgY4vU7r9Nl9M
nyfIgZ5jYJTh5wLFh7sRo4qxJai9H1Z11ODIrddHE1odCkrLCEnmJ0tu4rOLHH/p
z4yblfwZU5xhDNlZCMwOD9e1BjB+XNCCR+7MwOwb9skaeBanGeUUx91I2lN5nqRu
Q3EAOkzh7FbEmXDbhgBy7RifLl0s494vOKLZhvrolmYT49vB5WkRVC0h+GnHQLRD
J35ZRoBLNMZ2V9h1z/k+YDDxOH6vd6RLPuseJ+Bo2wKxJ68G1/P0m02savwkIC/o
cqexGC/aguue5hHr6Ojq8H8zwwpj/Q5U4Z+Z89+r2VwQXcOCIZ+GSzVrP+QuFI2j
WQoG72J8a/IWQS1JS0KmsaBH4tQnVWVZdyeZx+MzkycMVlXxBUDz2AOCtBzQSv1P
CI5GoEWlP43JymwjH/lwazHhgmQ8SPYf5YNo8my3im0Vk0PddcBxQxKTA94pbK1M
w/o5VPLCD6CtQCHccaT9eXypuF+KFXyZW4DlfNjKRuqpGzrUyiFyCqsP0U/hWTVV
Ws5K23LXevbaODdxqvzJY/cSgrNwe+ERpfIs9mwxJ3dcwXZ/DMr1aUAq9/Kkw2zD
1roQdr6oQxHfMFOdHaKM
=klqC
-----END PGP SIGNATURE-----

--kFa0FWpjwNIzuSe5--
