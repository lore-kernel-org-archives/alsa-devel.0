From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASOC: core: Double control update err
 for snd_soc_put_volsw_sx
Date: Fri, 9 Nov 2012 16:10:02 +0000
Message-ID: <20121109161001.GN23807@opensource.wolfsonmicro.com>
References: <n>
 <1352442220-2210-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7693545190780157130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22733261744
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 17:10:03 +0100 (CET)
In-Reply-To: <1352442220-2210-1-git-send-email-y>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: y@dbdp33.itg.ti.com
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mukund Navada <navada@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7693545190780157130==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2012 at 11:53:40AM +0530, y@dbdp33.itg.ti.com wrote:
> From: Mukund Navada <navada@ti.com>
>=20
> snd_soc_put_volsw_sx function fails to update second control
> if first control is updated by snd_soc_update_bits_locked.

Applied, thanks.

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnSrLAAoJELSic+t+oim9mQAP/2Wvu4V79477MDMpEWqbBZ3H
QSCcvBTHdk15/u9anbnhABYpVh49fphmd9EltmQG3uIq3bl7teEFW7KxnkNV7tn7
dB40rDHK3SaBZWFqcwhUsHKJuF4Xx9ddaDUJFI2j/41mFHZP0yynGP5csVVtgsAE
g8QlaoruxzAyWFNKts3BSGJlmeh9ot65BctaV3CbmI8DzcX6OEHQp2xwNpIq3UhP
MwPh54K7Q7ZUF1kvawPZt/CR/2xsfIO5GyzydMBi1qjnj3jaej2xOKqQjCyln2V3
XdlFp0L1WhHUhFDR4xewq/isVq5xKpKe8Wf4gjbFsok8OKdC0chNR5RURcuTvQ8g
3bbw9yXvK6b9rHwtjhMm++rkADBZqMaYFz1C8Yqrg3sXZTn8iZmCZoqA8OLiwwCX
G/GX3RY6+hkFEloa8Uk3TuYigfhJ/P+wKHV0h27rNW4BQddLqHKxMCpfYAedDhfZ
mmHMTls0cqX3TgqNRR707s7W4BRMFXIyTgXKMZKUm9DPeeWfbWmq9ve9GKXJbvie
hnWgG3lG7NgNLKTxFTHS0sOj1qjx/EA4D9BCQPAhpxBF7v6+w/Tbgna03rRiVwyN
Ad/+azgy5bxwe7QVRcWdD00n3XfzbS7hLiKKzAfgyxuugoOh7otIAvBSfzEB5tfA
8/Ji02UlnEEFmWPEqgl/
=2Jgb
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--

--===============7693545190780157130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7693545190780157130==--
