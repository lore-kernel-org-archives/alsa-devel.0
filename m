From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 08/17] ASoC: fsl-ssi: introduce SoC
	specific data
Date: Tue, 20 May 2014 23:02:13 +0100
Message-ID: <20140520220213.GZ12304@sirena.org.uk>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0838800827187917130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0F18265499
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 00:02:30 +0200 (CEST)
In-Reply-To: <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0838800827187917130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8rOSj8ZDSRY/wsXb"
Content-Disposition: inline


--8rOSj8ZDSRY/wsXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2014 at 12:54:49PM +0200, Markus Pargmann wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> Introduce a SoC data struct which contains the differences between
> the different SoCs this driver supports. This makes it easy to support
> more differences without having to introduce a new switch/case each
> time.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied everything before this patch, thanks.  I've not applied this one
since you didn't sign it off - please make sure when forwarding patches
for other people that you add your signoff at the bottom, this is needed
for legal reasons (see SubmittingPatches).

--8rOSj8ZDSRY/wsXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9DhAAoJELSic+t+oim9sj4P/1ZnIROGA0n8jgeMCG/Ym8NT
wF9a35xhvpiCf+/eWfquNuYNN3o+5htCvmQIY5BVPNyOyQrcdfD9hT+6uvetXn/U
vrI7FTKbdgz7fy8rl0mY7cKnRPDJcezOap1oCxGJVm8kfq9IRq58PmNfaa8DZ+iU
qVOrnEgu2ZlLS+tefbQgMnadMckh0psBvov8Z8dCKhfGCMDRNNDzDUGDPTIXFre6
NbdoPe7cceZDlklRNtHHKVC1t0w3fRsQTJlS4PyREXH70JJIMWLWpMqlLrncWU5E
m8ToR2v8pQQtORB/P6+Uh5GcFbyzKo3RVABE5+lxULJCbTHKK5+VmvjqLUtd7MMm
l3FVclPMudfYgOcMSMy4MB3D7jg/XMDNCNvyR7qufrvoc9UkK+g/K/LgVLmniQ/g
I930hbvZWTJjh74lAy9gTHkVIeGf6m8t23Oo3vA/DroHjriEsM2sH2ammAFKDxcZ
IAUj9GVn4Sb4MY2GCDCA7mlxLtZ2uyP7HpFBWUGhDIt5lvSKURCrqeTddcw7WTo0
V1HMTpSxAUq5GxAi8AITxM2pRwd6a9Aaf8yAYLWXnGwz7k3b+u4R84xHs49GIBNO
KqXBWm9ZCZ4D3vASlY5AHfM7ajDvHioJiDq+CRvTWcQZQTmpUP9Cc6PzcKmjipCm
GSNZNNWmfJJh/KmDOSn8
=191N
-----END PGP SIGNATURE-----

--8rOSj8ZDSRY/wsXb--

--===============0838800827187917130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0838800827187917130==--
