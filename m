From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Do not redefine
	DIV_ROUND_CLOSEST_ULL
Date: Tue, 31 Mar 2015 08:12:18 +0100
Message-ID: <20150331071218.GH2869@sirena.org.uk>
References: <1427765462-7318-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5094783346887479132=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 450E42608CD
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 09:12:29 +0200 (CEST)
In-Reply-To: <1427765462-7318-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, peda@axentia.se
List-Id: alsa-devel@alsa-project.org


--===============5094783346887479132==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ieONPShpRWd85B+o"
Content-Disposition: inline


--ieONPShpRWd85B+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 10:31:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> DIV_ROUND_CLOSEST_ULL is already defined at <linux/kernel.h>, so use the=
=20
> definition from this header file rather than re-defining it locally.

Someone already sent a patch for this, unfortunately the issue exists
only in -mm and akpm didn' pick the patch up yet.

--ieONPShpRWd85B+o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGkjSAAoJECTWi3JdVIfQDKkH+wQUf7g9dgpmYRzfxicy1+cu
nRkvN3nZ7x0yLMWDL0rqo0RBTUW/e0e/NAalkyTZaGRdNJYoqmuSwk9eha6i/Q92
1FELGP9qmkyaEbWSl6PVTCWlauamLB8IFwE6Yb1tWAtesAjYpvKkgwn8v4yAK4mX
YXOG6xsOrx4u0HaR1ThYc+t3sBXQ3fs7NVBzpKJDGcdfaO6j+GH7/Yza1B29saA2
k5VhTQBLMsH02DOfdG+r4shw2JG+7OqAISeRl+QFZhOPhVvk+0f5zAHRKjdNZFoW
q6RGNP7W6QgA74Ij58iv9wFMaeMWJmc1RCLPmyIfXTRQBuwiaVuvSYngQu7sW9o=
=3WrQ
-----END PGP SIGNATURE-----

--ieONPShpRWd85B+o--

--===============5094783346887479132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5094783346887479132==--
