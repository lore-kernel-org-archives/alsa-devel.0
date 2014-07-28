From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: request IRQ in soc level
Date: Mon, 28 Jul 2014 13:24:04 +0100
Message-ID: <20140728122404.GT17528@sirena.org.uk>
References: <1406534923-27415-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3617994581752190138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DC1CA261740
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 14:24:13 +0200 (CEST)
In-Reply-To: <1406534923-27415-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3617994581752190138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dSpJDy4UaQtcpV/6"
Content-Disposition: inline


--dSpJDy4UaQtcpV/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 04:08:43PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We assign rt286->codec in rt286_probe. To prevent rt286->codec =3D NULL
> when rt286_irq is executed, it is better to request IRQ in rt286_probe
> instead of rt286_i2c_probe.

No, this is a step backwards - resources should be requested in the
device level probe not in the ASoC level probe.  It is better to make
the interrupt safe if it happens to be called before the card is ready.

--dSpJDy4UaQtcpV/6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1kDhAAoJELSic+t+oim9L+kP/15XzRmZxfuP2sZx+wg56zdr
FpejHRfT//ML+jiACjARmgMsNujzr3h2lY7SNN07zl0efuxwdW+hi2DkwrfxcDf4
8n7W9xB2VD3t8IvRMiN8ZoQUwEfwHVeLVjTmllCK9KYdmcnq4Q290FhK0y3Mep0j
XuF15C3St64b7yIvlNovNf2Z/yAFPV3xskX2JPYZHIFulzPCfHubLrZmSDDpdp/g
RggUxcLWj7oEks/kRyi/lFsVydiExR5UBey+dLdzIbtqyXYgFuJ4n+uNlrSCTPm2
2y55hzmzhPvLTLbKEJraKu4zYm+H4IpAYbVierDMWGzX1ZBtb+S1e+pPPC2g8ntz
1ZwnexhOQwWcPZ/6v1+/oykzGmjFMeburohJaJ8PZUYiqirBJ63rsnaw5/gQi9zh
cljhNoN5NL1LBnNM+3trL/NEqL20MKQn9LeHCCn/ZGij8tsbwDHm0lq7qJvoyUD/
BmqFEj8XRro9vPaoyBJ3E0oaHZwt6oTnxaK5idsRzAwN9KZDf3YgmLaiTEBwgQHM
89hyIsJIuYKQHykA4GQzhtIigayMesWAz9dpmi1CihSX9iqh7k6PoQ6YUWujVxTu
uUeqWNnAjmat4To0vyeM8i8nJsEaFeGvB6ryp1l76p5W2oEyC66lH0ZISIoOJyRp
r/wLi1+poDO4h5JbVZTa
=JepJ
-----END PGP SIGNATURE-----

--dSpJDy4UaQtcpV/6--

--===============3617994581752190138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3617994581752190138==--
