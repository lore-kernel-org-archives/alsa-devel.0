From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: Realtek ALC269VB Asus 1001px intern mic ist not
 working
Date: Mon, 28 Feb 2011 20:10:30 +0100
Message-ID: <1298920230.3989.17.camel@mattotaupa>
References: <4D6BE110.6020007@membee-rythms.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0953618583708295580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id B6B0A103800
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 20:10:38 +0100 (CET)
Received: from f053040157.adsl.alicedsl.de ([78.53.40.157]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Pu8UP-0000hM-36
	for alsa-devel@alsa-project.org; Mon, 28 Feb 2011 19:10:37 +0000
In-Reply-To: <4D6BE110.6020007@membee-rythms.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0953618583708295580==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-bOp1xC3BQkC8dF4kx/bh"


--=-bOp1xC3BQkC8dF4kx/bh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Marty,


On Mo, 2011-02-28 at 18:53 +0100, Marty wrote:
> Hi, hope I get some help with this problem. At the moment I work with=20
> Pulse Audio but the results are very bad.

how do you get it to work using PulseAudio?

> check:
> http://www.alsa-project.org/db/?f=3D0286416d03a64a2e34a4f73831c4f0f5cba00=
2d6

Please always additionally paste this information into the message.

        [=E2=80=A6]
       =20
        !!Kernel Information
        !!------------------
       =20
        Kernel release:    2.6.38-5-generic
        Operating System:  GNU/Linux
        Architecture:      i686
        Processor:         unknown
        SMP Enabled:       Yes
       =20
       =20
        !!ALSA Version
        !!------------
       =20
        Driver version:     1.0.23
        Library version:    1.0.23
        Utilities version:  1.0.23
       =20
        [=E2=80=A6]

Could you please try a current ALSA version, i. e. 1.0.24, (for example
using a live image) or test if some `model` parameters, e. g. `fujitsu`,
work [1][2][3]?

Searching for =C2=BB1001PX alsa=C2=AB also brought up several hits. Which o=
ne did
you try?


Thanks,

Paul


[1] http://alsa-project.org/main/index.php/Help_To_Debug
[2] http://alsa-project.org/main/index.php/Help_To_Debug_Intel_HDA
[3] https://wiki.archlinux.org/index.php/Asus_Eee_PC_1001px#Sound

--=-bOp1xC3BQkC8dF4kx/bh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1r8yYACgkQPX1aK2wOHVhhVACfZDPue4xjQlMLL4QUThFUe3aJ
UWAAn32HwfX5lojxqLfd13xbmSRrRiak
=G87F
-----END PGP SIGNATURE-----

--=-bOp1xC3BQkC8dF4kx/bh--


--===============0953618583708295580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0953618583708295580==--
