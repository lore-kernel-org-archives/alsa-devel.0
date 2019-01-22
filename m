From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: soc-core: use
 for_each_link_codecs() for dai_link codecs
Date: Tue, 22 Jan 2019 17:39:02 +0000
Message-ID: <20190122173902.GE7579@sirena.org.uk>
References: <87imyiamj4.wl-kuninori.morimoto.gx@renesas.com>
 <CGME20190121003405epcas1p3f72eb59673abe94235326cbb24251b3d@epcas1p3.samsung.com>
 <87a7juamhi.wl-kuninori.morimoto.gx@renesas.com>
 <6e72e1ea-8879-7cab-f2d8-18da7a0a883c@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9034062016285884037=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C38A2674B9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 18:39:04 +0100 (CET)
In-Reply-To: <6e72e1ea-8879-7cab-f2d8-18da7a0a883c@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org


--===============9034062016285884037==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 04:43:08PM +0100, Sylwester Nawrocki wrote:

> It seems this patch causes card registration failure in multicodec=20
> configuration. When I revert the patch there is no error as below=20
> on Odroid boards:

OK, I'll drop the patch for now.

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxHVTUACgkQJNaLcl1U
h9BCTAf/apXilQiCvAtG0P6OErBoWsk6XbBt8TLoKcfUdMnmYysn/9FUFcl0FOQ4
FHdeVfw5ChF+V99TNusOCoxAcQXe+ZWYvqggs6/LOMBu7Z77810S3lAfPbvTzFUx
ZJFdDeoh+ktt8XJ2ntnkmZKz2H1sczeHI9f1Kb/z4Q0zJDkbIYoodAj0R39+t4p7
aHVkI6P9Z2BWcnI5Xeqn6+vN7m/nvKFttP7a3LkANFNnqrEd7pGuHRnQzcR1SRJY
FnI9uiG6KHkgA1qabE19D5vYBS/G5gBHvkqVVmZU9lwgcLzl4R0gReuCombdRwlk
DLjp2ohaSTvxOVZJHEZwR/loW1rrHQ==
=waf7
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

--===============9034062016285884037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9034062016285884037==--
