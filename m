From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8741: Add differential mono
 mode support
Date: Mon, 11 May 2015 18:21:54 +0100
Message-ID: <20150511172154.GS3458@sirena.org.uk>
References: <1430858791-11825-1-git-send-email-ce3a@gmx.de>
 <554F31A0.1030202@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5957319780061912167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 79014260713
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 19:22:10 +0200 (CEST)
In-Reply-To: <554F31A0.1030202@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============5957319780061912167==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="szdyR02yM8NCQUEm"
Content-Disposition: inline


--szdyR02yM8NCQUEm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2015 at 12:23:28PM +0200, Sergej Sawazki wrote:
> On 05.05.2015 22:46, Sergej Sawazki wrote:

> >+struct wm8741_platform_data {
> >+	u32 diff_mode;   /* Differential Output Mode */
> >+};
> >+
> >  #endif

> Gentle ping.

Don't send content free pings, *especially* not content free pings
quoting the entire message with the text at the bottom of the mail.
Content free pings just add to e-mail volume and waste everyone's time.

It's been less than a week since you sent your patch, you need to allow
a reasonable amount of time in case people are busy, on holiday or
something.

--szdyR02yM8NCQUEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUOUyAAoJECTWi3JdVIfQdKAH/3qzFhz/W1Czap2bXqF1CBC7
mPXGYWBFNlJbLNs+313qM0QHsu+ni7K9Rfu4B/uyVqxPBpOzyx8RJ9ZYIo/ueCrd
XzRy3FQab52ub2+HQghXMXabQqVwAU/Tub6ZJGWkZB1A/Le1PU3+3g1LbwszsM7i
8LcfoQhWdjEz3LC/S89Sxo38x/vUEEMkQOQU9+XyWux4LnRvHbNbw2LdvzqIuMBM
bDs7vMnyUvzAWe6hD0k4AD3gC2cYLg+Ozl7QM4UrbI8ksKJZT0VFs1miwK+s/PSU
mq7xtOgU4+w2osy3E3RTewNVIKIh4GtFrLvIF3ng9+IXXc+JVwlGWBGvlRu10Nc=
=Wjp6
-----END PGP SIGNATURE-----

--szdyR02yM8NCQUEm--

--===============5957319780061912167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5957319780061912167==--
