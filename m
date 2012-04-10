From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: utils: Don't use
	of_have_populated_dt()
Date: Tue, 10 Apr 2012 22:33:34 +0100
Message-ID: <20120410213333.GT7499@opensource.wolfsonmicro.com>
References: <1334085077-11089-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3162015166472077597=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E831104234
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:33:36 +0200 (CEST)
In-Reply-To: <1334085077-11089-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3162015166472077597==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lh1tzOZp3jg2TtWy"
Content-Disposition: inline


--Lh1tzOZp3jg2TtWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 01:11:17PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Recent list discussions concluded that drivers should not be calling
> of_have_populated_dt(), and hence of_have_populated_dt() should not be
> exported. Use a different mechanism to detect DT vs. non-DT boot.

Applied, thanks.

--Lh1tzOZp3jg2TtWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhKcmAAoJEBus8iNuMP3dMFUP/jt8Saiq/gJqy+ZP1maxUgLy
dCg1o+ksPZZMu+BYzVKHWJCEl2f7I6r2VafhGdlfjQuuH9AwxVn/L9YsgD1bRVmL
kBD5blD1LDEXFsj+gHNHnh1/dbM0y07SRw7YTimIWoSFuHk0TrI2X1jZEKmESXKW
TKM0DqSrNkMv8qDzapOpsprYljbHey/7rDlvuX8p0D4P5SBg1eQloE0c61L+cfHr
j5yEctQP4T+8OHZdEKc1rXMQSVH1/0hx/q/9+qINociPcLJ4KtOwEaMXOIkV32iO
mWtfRV2mf8LTd6WXr7ioWHkBDuTSXIc+2feIHJY77uxf7KXdoj8pCg4NT/GjuBDj
2mOYm/xl9RCoEbpLPL3EkZ2PwP2Cf92urrWPiCSe77i5c/azAb58IIqJxgZr92bE
iBMbzxhjilIlmC1XUu9fHFUOC41ecH6qPPi/0yIgCe+g43NFINfhJFUYXRPPiuVG
K8K5diC/bwytip5CGx3QclJ5g/4pGvE3KHNaUDffPlG1h9t5KvQoBIaSkmpNXzgv
HYlSILRISdgHmDAYVK1UaTvm2PqA2XtoNit1K3PVvOl4BVsrB4G1air2vvxtI7o4
kg7TBvUWdLdj0OOTaCw6/Wd2pPYMWR61AUGUi2AnInazFcTExqoliA0HHcJnKa/F
PjLKJFELPdzH8mQgZtvT
=NosK
-----END PGP SIGNATURE-----

--Lh1tzOZp3jg2TtWy--

--===============3162015166472077597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3162015166472077597==--
