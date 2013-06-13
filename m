From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5640: enable LDO1 before
	creating regmap
Date: Thu, 13 Jun 2013 10:30:38 +0100
Message-ID: <20130613093038.GW1403@sirena.org.uk>
References: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
 <1371072864-13205-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7203022827820958203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B34F2261AE4
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 11:30:43 +0200 (CEST)
In-Reply-To: <1371072864-13205-2-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7203022827820958203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NUQP2JP/Zo+En7Or"
Content-Disposition: inline


--NUQP2JP/Zo+En7Or
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 03:34:24PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Enable the LDO1_EN GPIO to the CODEC, which enables the device to show
> up on the I2C bus, before creating the regmap object. This guarantees
> that if devm_regmap_init_i2c() were to attempt to communicate with the
> device, it would be able to.

Is this an actual issue?  Unless specifically asked to the regmap code
really shouldn't be interacting with the hardware and the ordering the
code currently has is the standard one so if we're having problems then
a number of other drivers ought to be fixed.

--NUQP2JP/Zo+En7Or
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuZE7AAoJELSic+t+oim90C0P/1jSpri8p9xaZViATgmKYHpT
vmj/pdK0rLjYQfuzhlAPdWN/ebN9mO/iJhcq6w1Xts1+fXIqa14PkIPS3J3B6ni2
RL/1yw+awsamXe7ETpfV9mQR0Kz0hSJDlJEY5lvydz4UIdhJDCR95Rb9seF1oFeU
DRzHkXJJwcc7BQLqIO7KdFp5RfSvS1MaRwEA9aE0WheqO2jg682FjjqJyLbIq23C
hL25p+wnKaX1avKJT2O3VWgRK+a3bHsk7JUdwhf0T9KFNPQ5I2WvukFxr08/PwWJ
uWwHONN4SvZL8Ta5LtLh5YhFBvRGjk+BxRLDrsQgOpwNOp8hm4VjMbv45BRgDQ/5
ntDr18275Fp3WQCeppSFoUH/ozJDQmNxcFKx1q3vy0Ue1dNWCGU3uFUEYC2UAxHj
LcLBUxMgTWxg2XDMzslzQM3SZrgOEZS948FnssBUxD7w/N9BvLSZp40rDewA9JdR
Ag4K4dZGD0vO2OT47JJ9lDvw9LXNjkn4KLxp/LkvIczkSlQdV+W1p4cP0rhhWEB7
VcmXZJR6pbCZ7dBBH6Rm3pO00ToIcylotJVAlx1IouBW8xWWEiHjkzVJAArXdKRU
B6Vg7MN/q3flzknhbqe8SEd+YYD6bShR/XqPycGLNGmh5smahIevOtEFS2MVA//h
Qu3wKCI5a9A/26OPAkA3
=Hu7D
-----END PGP SIGNATURE-----

--NUQP2JP/Zo+En7Or--

--===============7203022827820958203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7203022827820958203==--
