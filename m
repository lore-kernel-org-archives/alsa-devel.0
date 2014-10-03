From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Do a sanity check on
	SYS_MCLK
Date: Fri, 3 Oct 2014 11:21:03 +0100
Message-ID: <20141003102103.GF4273@sirena.org.uk>
References: <1412282165-1500-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0402698482640109763=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38FD3260446
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 12:21:08 +0200 (CEST)
In-Reply-To: <1412282165-1500-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============0402698482640109763==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tWc6BTYdre847SEs"
Content-Disposition: inline


--tWc6BTYdre847SEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2014 at 05:36:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> According to the sgtl5000 datasheet the valid range for SYS_MCLK is from =
8 to
> 27 MHz.

Applied, thanks.

--tWc6BTYdre847SEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULniOAAoJECTWi3JdVIfQdbgH/RrriJ+ftx+UipuMmuGY+FLQ
cmXTPAS6foB8UkfghRuWAgOL7vGGEJ3fN0GNBU8MGnFb6k4dP1TSZMZ3ko66tmAG
8oX+Ett1Gk2tvVDV8kRfx5eXv/tvwXWo8oRJnRqAcoDVzzyOB6mjCg4IMBJu4rAb
Hf26uqXVQ7utePa4q0BCx/Z7t3C0jssb6t34PZK7Xa4TuesYcTPXtHzShHbdhvhr
QoHMBQtPl3ICdq08eD2ZXVobaxyNogVBT4ljNpNu9OQzPj+KK7JxGmYiLwlIkdEa
RCL8UTTjCnJdEZzvAJDx5tB29w8FH23FOaECExH7xuBwFLvOxbwmRwNWKvdDhps=
=uiUA
-----END PGP SIGNATURE-----

--tWc6BTYdre847SEs--

--===============0402698482640109763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0402698482640109763==--
