From: Michael Niedermayer <michael@niedermayer.cc>
Subject: ftp.alsa-project.org connection problems
Date: Mon, 25 Feb 2019 19:04:31 +0100
Message-ID: <20190225180431.GY6706@michaelspb>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8329151428184496722=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 771EBF89650
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 19:04:32 +0100 (CET)
Received: from localhost (213-47-41-20.cable.dynamic.surfer.at [213.47.41.20])
 (Authenticated sender: michael@niedermayer.cc)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 30C3B1C0006
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 18:04:31 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8329151428184496722==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qrotSzihSRAsrOtf"
Content-Disposition: inline


--qrotSzihSRAsrOtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Iam not sure this is the correct place to report this to but i didnt see it
being reported anywhere yet on the ML archive or google

since a few days wget from ftp://ftp.alsa-project.org does not work anymore
This was noticed as it broke the ffmpeg oss-fuzz build:
https://oss-fuzz-build-logs.storage.googleapis.com/log-a252663b-b71c-49f3-8=
869-1ff2136ce38c.txt

and it is locally and on another server reproducable so it seems not a issu=
e "on my side"
intererstingly it works without pasv mode

wget ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.0.tar.bz2
--2019-02-25 18:30:15--  ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.0.=
tar.bz2
           =3D> =E2=80=98alsa-lib-1.1.0.tar.bz2=E2=80=99
Resolving ftp.alsa-project.org (ftp.alsa-project.org)... 207.180.221.201
Connecting to ftp.alsa-project.org (ftp.alsa-project.org)|207.180.221.201|:=
21... connected.
Logging in as anonymous ... Logged in!
=3D=3D> SYST ... done.    =3D=3D> PWD ... done.
=3D=3D> TYPE I ... done.  =3D=3D> CWD (1) /pub/lib ... done.
=3D=3D> SIZE alsa-lib-1.1.0.tar.bz2 ... 929874
=3D=3D> PASV ... couldn't connect to 207.180.221.201 port 35333: No route t=
o host

wget --no-passive-ftp  ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.0.ta=
r.bz2
--2019-02-25 18:30:22--  ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.0.=
tar.bz2
           =3D> =E2=80=98alsa-lib-1.1.0.tar.bz2=E2=80=99
Resolving ftp.alsa-project.org (ftp.alsa-project.org)... 207.180.221.201
Connecting to ftp.alsa-project.org (ftp.alsa-project.org)|207.180.221.201|:=
21... connected.
Logging in as anonymous ... Logged in!
=3D=3D> SYST ... done.    =3D=3D> PWD ... done.
=3D=3D> TYPE I ... done.  =3D=3D> CWD (1) /pub/lib ... done.
=3D=3D> SIZE alsa-lib-1.1.0.tar.bz2 ... 929874
=3D=3D> PORT ... done.    =3D=3D> RETR alsa-lib-1.1.0.tar.bz2 ... done.
Length: 929874 (908K) (unauthoritative)

100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>] 929,874     2.4=
3MB/s   in 0.4s  =20

2019-02-25 18:30:22 (2.43 MB/s) - =E2=80=98alsa-lib-1.1.0.tar.bz2=E2=80=99 =
saved [929874]


--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

I know you won't believe me, but the highest form of Human Excellence is
to question oneself and others. -- Socrates

--qrotSzihSRAsrOtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx0Li8ACgkQYR7HhwQLD6tJkgCdEJK7DP6qXGCwoxLsm0K6quU1
t1MAnjoBa2L2cvW9QKFinteg4rkF2VfF
=vkdO
-----END PGP SIGNATURE-----

--qrotSzihSRAsrOtf--

--===============8329151428184496722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8329151428184496722==--
