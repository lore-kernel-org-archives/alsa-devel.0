From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SPEAr spdif_{in,
 out}: use devm for clk and a few more cleanups
Date: Wed, 8 May 2013 11:52:49 +0100
Message-ID: <20130508105249.GB7478@sirena.org.uk>
References: <1368006458-20438-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2880253676804300213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F399261666
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 12:53:12 +0200 (CEST)
In-Reply-To: <1368006458-20438-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Vipin Kumar <vipin.kumar@st.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============2880253676804300213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJWLbGElk4npXSe3"
Content-Disposition: inline


--OJWLbGElk4npXSe3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2013 at 11:47:38AM +0200, Uwe Kleine-K=F6nig wrote:
> Drop dev_set_drvdata as this is handled in the core and use
> devm_request_and_ioremap instead of devm_ioremap to properly register the
> address range used

Applied, thanks.

--OJWLbGElk4npXSe3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRii5+AAoJELSic+t+oim9YskP/isKeTU6KZF08LTBU+es9Vt+
gYe1VF7+8LJEmZ6xe+HsHvKMF9umNDZHp/BnO5O+FIrvRfLghLycpTKAwmYOBhO5
g9ouoX6YsAflu64sMCRSokRtvXO1GJ3Qk0vKJkzeKwV/hjzG9rBsinyUBbI2fEN1
rA5ivMkbaqHZa/qw5WNuFDQTSCN6YNfwTo9UbPPV85Pc4vvpxf4rSfMgWGTnJAbA
hX0ynIipxbMhnqWfATe3A7ORQ97CiAQGXh8piyzh6waMtcT9BR5qBabV8+kGpfzB
5yclJCoP/mh51VWIhY0pEOSf+D98KnJT6z0TisG0Dtw4UAQ9a3aI7W/4WhTrXFMT
ujual0pDkQMfiP9cFEATgGV4jT5vOtRcRSaSXsxZGdqrvKQnSRkp5XkAV/qS2xCc
o9E05FLjB9mqaW5iuxzXcxjQOn/+znusFaSChnuqMJ9ulRL5LShIXJ8wRYGg99n0
uMKDUbmkjBh402WRcVtxq6Kw5iL3XBWmbkKd9NslNAEtw2h5PwYh4s/QqZVf13n+
J/eGl3Wr1bpDvHhNy8o7Lkx5fYgN4O69NUpyt8OFWxEhbd74FrC58aBiKDnmK1IL
+vp9f7i8Aub2LKoO2WHoKhJCOFbxvy6OX9Sn/U1KIcAAU/vyLqbByCyp0eR7jTuu
1zhAvt4a+DykpaCWW+E5
=hTII
-----END PGP SIGNATURE-----

--OJWLbGElk4npXSe3--

--===============2880253676804300213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2880253676804300213==--
