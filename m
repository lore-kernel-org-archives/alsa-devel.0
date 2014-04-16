From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ASoC: fsl: Add explicit include of of.h
Date: Wed, 16 Apr 2014 12:06:07 +1000
Message-ID: <20140416120607.675e3877d217fc58c18ffd58@canb.auug.org.au>
References: <1397560326-28268-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5210733832428165142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EFEE6260859
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 04:06:16 +0200 (CEST)
In-Reply-To: <1397560326-28268-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

--===============5210733832428165142==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__16_Apr_2014_12_06_07_+1000_rRQCpQxbupQo6ZX7"

--Signature=_Wed__16_Apr_2014_12_06_07_+1000_rRQCpQxbupQo6ZX7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, 15 Apr 2014 12:12:06 +0100 Mark Brown <broonie@kernel.org> wrote:
>
> From: Mark Brown <broonie@linaro.org>
>=20
> Hopefully fixing a build failure reported by Stephen Rothwell - though
> quite why the other OF headers don't include this as well I'm not sure.

This did not fix the problem.  The declarations (and presumably the
implementations) all depend on CONFIG_OF which is not set for the x86_64
allmodconfig build ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__16_Apr_2014_12_06_07_+1000_rRQCpQxbupQo6ZX7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTTeWTAAoJEMDTa8Ir7ZwVBEYQAJKb/HXc2EiblfmcQT/l+Ta8
ndSqy4for8hVGPYW/En02CcoVN45V1Bu77AJeOi095EUIYLmectV8KTg0sCAClsZ
O0555zcW8YWGHijdssSaKPVA93hErFKYHWjVeYcI5s7WDB2hVIffFaO8vkK/ZjDr
J9Ty5AZEbEtWJx1ONWj8E5GWfnGNcGzwSsGfIhuWCmhE5XsYcaoaVZMl52eWB6zR
sJwv1XQHQijOI2iRrh5N0H4hKjq0fCsqUuJHPV8P8TcxXehqZ4v/81YBQd1CZMtJ
g9oYnIuV7TVgjnCwdzwGrkrtd1lHh5iVoRvXpmsTlwhn282P1Gnuh9HRz78cdDbc
Nh+EBbZe9JPAwKVwSbn5a6hdoumYklJF85cummFAZSaQikV2KAvtNdoOTMf2dIC7
zvt4M0AItuKMAAN+nAdfUsOa9YrZleAt0l5XZV5QuxHO+l/9FbWSCPHnVSDNFdrg
EZTTN3D/zI6R3OQbc0xU5EPrsHxq3nW5nnMxvKJ4s1spUYy1VKqmiOrI3RZ+vTh9
QMij6kJTQCusv1K/7S9BCG65hRVLjIhB7LY+qPTsIAxTLmc6Zj39cTGIQfFkkBnL
odUT6m1n7Yh05SEVxV3hC+2EYduqd1lsFQQ7cHcizgsuZ//q+YIBVexF7+9LHJKk
eczfY5j3UzL9gGknK/er
=cvqR
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Apr_2014_12_06_07_+1000_rRQCpQxbupQo6ZX7--

--===============5210733832428165142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5210733832428165142==--
