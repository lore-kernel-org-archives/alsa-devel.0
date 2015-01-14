From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: Make set_tdm_slot() semantics
	consistent
Date: Wed, 14 Jan 2015 19:08:28 +0000
Message-ID: <20150114190828.GD3043@sirena.org.uk>
References: <1421054841-19858-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4271394462546606393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 71ED22619D7
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 20:08:45 +0100 (CET)
In-Reply-To: <1421054841-19858-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4271394462546606393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 10:27:16AM +0100, Lars-Peter Clausen wrote:
> Changes since v1:
> 	* Don't modify the fsl-esai driver as it already uses the non-inverted
> 	  semantics
>=20
> Original cover letter below:
>=20
> This is something we shortly discussed during the ALSA mini conference in
> Duesseldorf last year. We want to do more useful stuff with the
> snd_soc_set_tdm_slot() API and build generic infrastructure on top of it.

Applied all, thanks.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtr6sAAoJECTWi3JdVIfQIBoH/3qdOne8rEKw1s0ga7/E3icr
1T/JKWwnVxgMAjaFaIBOUSxvwvvAMswdT8NN+RQR1gQ7F3W6JShgt+46VF27jcSP
TbmbidKBYkWm8YMTwA2xSUKWTY5McqX1tiXSthKHupg8qTggYqjlClCakllfYyca
r9i/i7pVgggkzKe1RIas4TrBTcfJ5PxzcrTzjz1xWZtp5zk5c8fa5QI6qYhbgk2b
6pgvtAgtLGSiPRdoeeP7bydUSml8mKZmV08ZBPDFI7/rvoro30Imolhrw5/ILSel
xy8MOcvrHn1BQb28uko96a+ME2+YVNGilNolykuhxaQBQ8MwpdixZ42Aco3lGOE=
=afRc
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

--===============4271394462546606393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4271394462546606393==--
