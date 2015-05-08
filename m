From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: No need call
	of_device_is_available()
Date: Fri, 8 May 2015 12:05:51 +0100
Message-ID: <20150508110551.GE22845@sirena.org.uk>
References: <1431051856-22476-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5352648915327014433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A4B265CC1
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 13:06:00 +0200 (CEST)
In-Reply-To: <1431051856-22476-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============5352648915327014433==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIihDAIFcHS4kFQ7"
Content-Disposition: inline


--XIihDAIFcHS4kFQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 11:24:16PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The comment and the call to of_device_is_available() are not really
> needed.

Applied, thanks.

--XIihDAIFcHS4kFQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTJiPAAoJECTWi3JdVIfQVZ0H/jUFR53YAguf2PTF+J/7Cjyc
nAtUln6FoAcu9q1CXjE4KL8wsOwMrKXF645+J21HlEBwsXXad1lH/sGFo8jyAZX3
obkA32fNh0McT8qGuuf5JfIKJ4dihcAttfnvOnPZpTPF3EnjBw7WPWBoQ1KuNbOp
qtpULQ2khG9wtMJhalJOYZfLBzb2BADjsPzEtESHnphM+4GD6apuO0mvhbWTWMrg
sMMCGVv6zLxu8oSpQjNeqfBFER6P8R6GNkn7Ps/X6rJWBZGSCfwNoLkLIk34eumD
tX2UsnzTUQ+xZHct1/zdEp27muidyCDz4O6Ua8VQGL3+92SFSssLVYgukGOntEs=
=/Iec
-----END PGP SIGNATURE-----

--XIihDAIFcHS4kFQ7--

--===============5352648915327014433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5352648915327014433==--
