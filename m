From: "Ryan C. Underwood" <nemesis@icequake.net>
Subject: rawmidi virtual and long sysexes
Date: Sat, 19 Dec 2015 15:31:44 -0800
Message-ID: <20151219233143.GK28165@localhost.localdomain>
Reply-To: nemesis@icequake.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6033664609301624559=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.icequake.net (64-251-151-187.fidnet.com [64.251.151.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 86DAC260606
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 00:31:49 +0100 (CET)
Received: from localhost (aurora [127.0.0.1])
 by mail.icequake.net (Postfix) with ESMTP id ABB19FBD5
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 17:31:47 -0600 (CST)
Received: from mail.icequake.net ([127.0.0.1])
 by localhost (aurora.icequake.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id npLLcput3659 for <alsa-devel@alsa-project.org>;
 Sat, 19 Dec 2015 17:31:45 -0600 (CST)
Received: from localhost (50-76-49-98-ip-static.hfc.comcastbusiness.net
 [50.76.49.98])
 by mail.icequake.net (Postfix) with ESMTPSA id F2C75FBCD
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 17:31:44 -0600 (CST)
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


--===============6033664609301624559==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Content-Disposition: inline


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi alsa-devel,

Recently I noticed this problem and fixed it in the client consuming
sequencer events:
https://github.com/munt/munt/commit/0ea0846d0849872acf4384bdf5edeff026d12f42

Basically, the rawmidi virtual plugin enforces a 256-byte limit on
events, and emits multiple events if e.g. a >256 byte sysex is
encountered.

This does not seem to be documented behavior for
snd_seq_event_input(), nor is the fixed limit described anywhere.

Would it be better if the maximum event size could be configured
through params?  That would avoid needing this clumsy workaround by
sequencer clients.  In any case, it seems that the documentation
should be updated to reflect the need to receive multiple sequencer
events to complete a sysex if EOX is not located in the first.

Please cc me as I'm not subscribed.

--=20
Ryan C. Underwood, <nemesis@icequake.net>

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFWdejfIonHnh+67jkRAo6RAJ9352VoZJ/0kMp58S34lwNwlaNkOgCfTb+0
YOoWvlrhhTntG8vPIVGsRiU=
=7Yi2
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--

--===============6033664609301624559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6033664609301624559==--
