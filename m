From: Lars Wendler <polynomial-c@gentoo.org>
Subject: alsa-lib-1.1.6.tar.bz2: some files are missing in the
	tarball
Date: Mon, 9 Apr 2018 15:16:16 +0200
Message-ID: <20180409151616.6c8338a7@abudhabi.paradoxon.rec>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1807079921855885950=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 21EC8266C99
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 15:16:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-bugs@gentoo.org
List-Id: alsa-devel@alsa-project.org

--===============1807079921855885950==
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/1s0Cc6zsjGi=IMnk8PinPu/"; protocol="application/pgp-signature"

--Sig_/1s0Cc6zsjGi=IMnk8PinPu/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello list,

please have a look at this Gentoo bug report [1] where a user reported
that he cannot compile alsa-lib-1.1.6 with --enable-alisp configure
option. The error message is:

  make[3]: *** No rule to make target 'SI7018/sndoc-mixer.alisp',
  needed by 'all-am'. Stop.

This happens because the directory src/conf/cards/SI7018 is missing
as well as the following files:

src/conf/cards/aliases.alisp
src/conf/smixer.conf
src/conf/sndo-mixer.alisp

First I thought those files were removed intentionally but checking the
alsa-lib git tree I can see all files still being available. So at
Gentoo we fixed this by re-adding the files through a patch [2].

Any chance this was an accidental oversight?

Kind regards
Lars

[1] https://bugs.gentoo.org/652422
[2]
https://gitweb.gentoo.org/repo/gentoo.git/tree/media-libs/alsa-lib/files/al=
sa-lib-1.1.6-missing_files.patch

P.S.: Please CC me on replies as I am not subscribed to the list.

--=20
Lars Wendler
Gentoo package maintainer
GPG: 21CC CF02 4586 0A07 ED93  9F68 498F E765 960E 9B39

--Sig_/1s0Cc6zsjGi=IMnk8PinPu/
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWCOBmo8i7LhvVmNAVx3S0DQ8YDkFAlrLZ6AACgkQVx3S0DQ8
YDm9IA/+NI8kXm6xEYrR8csfN2rVPYeobfV0Bf712CutKRZXT2kSVMKik9tFLsa4
REFrTcc8QTgLELs6g7WLLjkC2XD1H3FO/eCTxdklVBLIaPUzhytcgfUzOOJXOCGD
PjwFNm/KWxSQkp4HJjvdgjmLYLQWsGLNhbo6YroAo1kVSmzB09hOAaC/rK1kqDDX
lO0/lHtwxJ4H+ucH/iNk+Quw6PCB+C8JbvPfu3SvbFVPIZY2VFXfECHf6nuosZCO
SkzycDmBB7k1KaZSm+hC4Wk+CKY/SMH1gfKV7zaHrUG6jcLEtFp6rLMMSePSaBFn
0ePsRP+AsFiff+T/qxs708grpyvlPtqgrT5PP3qthcjln5XVjfjP7aNs+BLR+HYb
V+Vd5Fv8+HVJJWtGzwkKUqtHDMQfNWU4Na4X5mD0ymVhbjmkBBKilTJpMGOJtkdp
D9/bFhagdRlI0yysmJyEzIfsiivB1uElrUoj+K8lF0w8v2GbYSMnTkJSw98QkF0R
a9r/+78Q20q+MKEtK4TtxpS/DdcDktWc2BC5TIT3ZyjB86RO76DoHIH7mBGjFQJc
UmDZQFci1PAlgFKl5c5EqPMRyLInhDKwdlWPseSs1e6GIIiM/P8a+PBlrunA6fl4
FecwTQkSsJOwbJ6SizhDk7cIP849P7BRcrHZB2d+ybDxuq9KIrI=
=0kkF
-----END PGP SIGNATURE-----

--Sig_/1s0Cc6zsjGi=IMnk8PinPu/--

--===============1807079921855885950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1807079921855885950==--
