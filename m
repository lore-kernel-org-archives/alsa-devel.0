From: Alexander Blinne <alexander.blinne@uni-jena.de>
Subject: Decibel Levels for Storm Medusa 5.1 USB Headset
Date: Mon, 22 Jul 2013 22:05:14 +0200
Message-ID: <51ED907A.1070305@uni-jena.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8258641113102654698=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout0.rz.uni-jena.de (mailout0.rz.uni-jena.de [141.35.1.28])
 by alsa0.perex.cz (Postfix) with ESMTP id C671D261A34
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 22:05:17 +0200 (CEST)
Received: from mailsmtp2.rz.uni-jena.de (mailsmtp2.rz.uni-jena.de
 [141.35.1.21])
 by mailout0.rz.uni-jena.de (8.14.4/8.14.4) with ESMTP id r6MK5H0Q015588
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 22:05:17 +0200
Received: from [10.42.23.75] (dyn-0a2a174b.stwwh.uni-jena.de [10.42.23.75])
 (authenticated id=ci29hub bits=0)
 by mailsmtp2.rz.uni-jena.de (8.14.4/8.14.4) with ESMTP id r6MK5Gp1031127
 (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 22:05:17 +0200
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
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8258641113102654698==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LJLCWUBVAOVLXDVAOKQQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LJLCWUBVAOVLXDVAOKQQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I hope this Information helps. I have the Storm Medusa 5.1 USB Headset
which reports wrong decibel levels to pulseaudio. My Alsa-Info are
located at

http://www.alsa-project.org/db/?f=3Da882f3db6769c5dfce83c266946eff52d1d55=
349

The Headset is card2 in the above dump.

My decibel levels-fix

[DecibelFix Speaker]
db-values =3D 1:-30 37:3

works fine. Level 0 is mute, hence -infinity dB.

Greetings


------enig2LJLCWUBVAOVLXDVAOKQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHtkHwACgkQSpzrZw97cyk5nQCeI7NFba37RRfEUW7mrCK0XOHM
NwcAoMA0zGwSxzsp0dLvQ0ZtPoUzSJay
=s2OO
-----END PGP SIGNATURE-----

------enig2LJLCWUBVAOVLXDVAOKQQ--

--===============8258641113102654698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8258641113102654698==--
