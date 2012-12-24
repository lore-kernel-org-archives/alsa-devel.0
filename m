From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix maximum value for microphone gain
Date: Mon, 24 Dec 2012 15:29:14 +0000
Message-ID: <20121224152914.GA30837@opensource.wolfsonmicro.com>
References: <1356284479-19323-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4877183649536272073=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7EB7261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:29:16 +0100 (CET)
In-Reply-To: <1356284479-19323-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, eric.nelson@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============4877183649536272073==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2012 at 03:41:19PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> sgtl5000 microphone gain only has 2 bits of resolution, so maximum value =
is 3.
>=20
> From Eric Nelson:
> "We also found that for the microphones we have here (commodity PC boom m=
ics) a=20
> default value of 2 for the gain gives the best results."
>=20
> So change the default microphone gain as well.

The first bit is fine but the default change is not generally the sort
of thing we do in ASoC - we generally go with the chip defaults, it
saves on going round in circles arguing about what the defaults should
be.  Why would other systems not want a different default?

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HTDAAoJELSic+t+oim9YBcP/izbOaOJ6ldqluQm9p8AjMSX
4g9K7eZjQfTuhY9ycZRogNnqD+eraCekepy5B0iP0CIBjNmB9fchaSMIq5x8WDo1
xsewPc+5XRVMU+wh9Wb+3isV8To8mULXoSoS5TslHKQTY6bumZq8tjQX/m9Z0sCm
X1LlCwIJqAzCWxQlt0+RuGA6/iaSZ5ktt7l4RuMewe8AdQg/BxrhTu3gPQVFPBlB
LFbyNTIlsw8ztJCRsCY1uDzfGeKO8slPk+l8gJUlqzR4xE2wksHOZ542goq7QwJD
hgBvVY2FcK6joEdDgXvdKmD3VLTU9wFxOZFc9hmzfiB37WrPLBiY0lW7yupLRyCR
wqjzZh5W8I3QfxPnUwVxdA+pEGJZJarXCkpg03oGvvF34awnzA+Eeg0uVYVMhNwj
T8E97UqG/EO0Gr/+wBqB46TdPjgnSYPDZ4tSHNmrYXl0EzmYYZjmz1HlVt8RTc/k
N+eR4DiOCNKa0WRZK7E65CojZYcDaUOj8oEdCf0WbCqlGdgoNMIHt+trP80IrJy9
AmxCcH0EbE6wp1/aSZzQuPE2k7bp0xVeKOdi+NhjkdHWMxJBCygAVAIAxdp7V8vK
jOcNzbaEjszclUmMwg8APFPzyjME1qhAq/zcTlT4OLq2tekxAVCzEPeizXlQnhVY
MJ2OFrGbj92CdO7WVXMA
=5Pkr
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--===============4877183649536272073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4877183649536272073==--
