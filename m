From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup SND_SOC_DAIFMT_xB_xF
	behavior
Date: Fri, 1 Aug 2014 07:25:44 +0100
Message-ID: <20140801062544.GB17528@sirena.org.uk>
References: <87bns5ow3k.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3212734521418705252=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E23A926519B
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 08:25:57 +0200 (CEST)
In-Reply-To: <87bns5ow3k.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Jun Watanabe <jun.watanabe.ue@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3212734521418705252==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L0oDrUrtRPgtRyo2"
Content-Disposition: inline


--L0oDrUrtRPgtRyo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 06:08:18PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> In current R-Car rsnd driver,
> the SND_SOC_DAIFMT_xB_xF flags are used to HW default behavior,
> but, it should be used to specific format.

Applied, thanks.  I guess some of the machine drivers probably need
updates after this change?

--L0oDrUrtRPgtRyo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2zLlAAoJELSic+t+oim9NpEP/3okIPGptgK8ENMV+j6z6a4n
ysP075QvHrbdfR/jtWEW5Pq0/Wb6+0EMGW/H9U/SmTXJ+k0QMC9yZXR+LxCkM61k
v5AEvZZHlzNBa7B+JKTdXJ+UrZAVM/JRB+AQQ1f6y63nQdH3fwHQlVKaXQf2zCO+
WCNd95cIVJyhXCThw/B66B5E4hWhiHdOAGvpQfDRmVgpVzqAl+eQyLG7N5kS8Ik/
biyE8DOqdrl3iCTobVas8yU7yeG3T56Kcj0995pkTY92TasFbetmpL3hFvdZJNHU
KxfexgnilfNSSadCnexg/riu1Xs3xguXkm2Ty7cx5AGhwxOAODF7nIa6CgNIoZt1
WUWv8siJwMeEzTUrrXzpohzmpt77QuaILoFga1hL7aWuun/IBt/8nxHLn3LeJA1c
iQzHyUvfuZ4rB9AfHGW0zXcmcKtzPxFLP/eDhDB9aEqWogWN/N88j2oAPdgTcmXt
bpnZ83w9CagkhLWTOQeUM6NIn2iS5/RoFkUQgPg0/lVFdvTXMrPll+dSjHYxe8/J
1vXceYsBUkR3vrx/aHYhNvljsOTp2qNCBIlu3i9oS7bA/FP68pM1D3xgq0Bp/rge
7/nnfaKYSb2U7AMYk//x6fByeEk2cPbpuz0i5qN5wc/PFjct3b1itV8JQqn+RgN5
c3ADXLycp3+sBZmi8fFY
=ikKZ
-----END PGP SIGNATURE-----

--L0oDrUrtRPgtRyo2--

--===============3212734521418705252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3212734521418705252==--
