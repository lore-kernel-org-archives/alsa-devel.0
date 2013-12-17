From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Tue, 17 Dec 2013 21:38:13 +0000
Message-ID: <20131217213813.GE28455@sirena.org.uk>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8331852461464976542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9733C2610A0
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 22:38:18 +0100 (CET)
In-Reply-To: <52B062EC.2050605@metafoo.de>
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
Cc: haojian.zhuang@gmail.com, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8331852461464976542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EXKGNeO8l0xGFBjy"
Content-Disposition: inline


--EXKGNeO8l0xGFBjy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 03:42:52PM +0100, Lars-Peter Clausen wrote:
> On 12/17/2013 01:49 PM, Mark Brown wrote:

> > Applied, thanks.  Can you also convert to use snd_dmaengine_pcm_registe=
r()=20
> > and remove this file completely?

> The problem here is that the driver uses sram for its audio memory and the
> platform has a custom function for looking up the sram pool. What we real=
ly
> need is a generic version of that which we can use in memalloc.c in the c=
ore.

Ah, yes - now I remember.

--EXKGNeO8l0xGFBjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsMRCAAoJELSic+t+oim9ST8P/AooxJSI59cvXb4/CQyDcT+T
I7RqFmwkesRrTGxV2pFE9dEjsYQwz53MbgNGB/QoHzHZcDb+piOnkmzbnuJyW3KM
RWaF4C5x0gSbSILkfDvOt2Qdp4ZWgW7TeMIdQKLhbNvfD2Ygb4kgZTx75Lnayc/N
3Ow9FDs2uOtFL3AwDlf0wudDYWc6yqw74JDhiQgWUjU3CZgTeKzEIil734AB7eC8
SxiP6JF7owTYmOyaR1rhL+9CR+afcouCPcSwHcwAYcXWMkKtNMHLgfAJe7CpfMlF
z4QxY+wPCH+RauLo5HIJ+EIAjcbwl7OBvQpKjzcba3uHMoEDau6aTUQDoMN0BnN7
Q6OdEbGEcaApX0rDcz9EgUQ4PtSBv7RFXWxUo0p8IH6j40X1m1MxzZ5gf432Dka+
6ZxNbGKBmUyLXFRLeErFIrUwgGXQK8WnyUkfYg3wny2ngsyq/cltGfszT89QQTNa
A7LzXTWtStmAE34SOisFqRncY/x/D/tUbR6WuJpCGu7FlM85C7HW5Fu6fS924Alh
0O/OEo6CeWUQU3KO/LtVwoNkBhpy7mllAJyPACy6iIkiaFwhHNf0PPS2AyJi92Xe
gRqmwY8tZk2RgB+QcfptmD1Pe6Y+wRww2ziE8oYOG1T4+cEWw68tdqG3FiT7QLsa
pcoi55xPf6CONwDaE39I
=Zdc5
-----END PGP SIGNATURE-----

--EXKGNeO8l0xGFBjy--

--===============8331852461464976542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8331852461464976542==--
