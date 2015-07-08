From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] Revert "ASoC: wm8996: Pass the
	IRQF_ONESHOT flag"
Date: Wed, 8 Jul 2015 19:34:22 +0100
Message-ID: <20150708183422.GY11162@sirena.org.uk>
References: <1435843604.17967.1.camel@ingics.com>
 <1435843741.17967.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8308229559242807637=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17B9A2650AF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:34:43 +0200 (CEST)
In-Reply-To: <1435843741.17967.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Michal Marek <mmarek@suse.cz>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8308229559242807637==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sMP3l7aO1Ldl3x+Z"
Content-Disposition: inline


--sMP3l7aO1Ldl3x+Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2015 at 09:29:01PM +0800, Axel Lin wrote:
> This reverts ed043aebe6ec ("ASoC: wm8996: Pass the IRQF_ONESHOT flag").

Please use subject lines reflecting the style for the subsystem, even
for reverts.

--sMP3l7aO1Ldl3x+Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnW0tAAoJECTWi3JdVIfQmQcH/icGQ6fZwCd1ohhjPemMXtiI
FPM2fgYtT8s3XFLuemt2SSE1dn567ylVoLH/OLrwodfv6DfnMTEd8nL66X2xrhcW
deIGT0YaJuw7LFg767D0u2mQSmkr25U70MQbxV1w2Jw05smI+vce9CXd7KmucZA0
CRPy60cXeozsewhuFAwXYubD63EC+eOdYUdGMOciELRR5aAYx5EMapAEopujCiI2
7uT30YWZJ/sW/vmjtYNXPbOu+YKKfa2xSVrNHp+m/TV7mg8H3r1C2Tp87Qxx83uv
E92PCD4snMaunABz8sb2D7nVUy9Jcw81KAlaTo+qudo7t5BDbSZnGk4QxBdHDzU=
=fQj6
-----END PGP SIGNATURE-----

--sMP3l7aO1Ldl3x+Z--

--===============8308229559242807637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8308229559242807637==--
