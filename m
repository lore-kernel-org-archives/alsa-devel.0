From: Tony Vroon <tony@linx.net>
Subject: Recalcitrant input pin on ALC262
Date: Sun, 01 Feb 2009 20:56:40 +0000
Message-ID: <1233521800.3811.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0434078510731451858=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 61FF1243AF
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 21:55:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by gold.linx.net (Postfix) with ESMTP id 9A48310077
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 20:55:29 +0000 (GMT)
Received: from [192.168.253.34] (5adb2625.bb.sky.com [90.219.38.37])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tony@linx.net)
	by gold.linx.net (Postfix) with ESMTPSA id 4C9621005F
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 20:55:29 +0000 (GMT)
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


--===============0434078510731451858==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-F+w2NSPw/7fNdbXKWqqq"


--=-F+w2NSPw/7fNdbXKWqqq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good evening,

Currently I am implementing full support for the Tyan Thunder n6650W and
have noticed a pin complex that advertises input, but can't seem to be
set to it:
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
    DefAssociation =3D 0xf, Sequence =3D 0x0
    Misc =3D NO_PRESENCE
  Pin-ctls: 0x00:

As you can see the pin capabilities reflect input. However, even after
issuing this in the model-specific verbs:
{0x1c, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},

the pin-ctls firmly remains 0x00. Even the python-based hda-analyzer
appears unable to flip the pin-ctls over to 0x20 and reports no error
messages in the GUI or in the terminal.

What am I missing please?

Slightly related, is it considered acceptable to modify pin defaults if
they are blatantly wrong? (Reported colour, N/A vs Fixed, etc)

Regards,
Tony V.

--=-F+w2NSPw/7fNdbXKWqqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmGDIgACgkQp5vW4rUFj5p/egCeLJPPSwm5e795xyh87kkjCeCl
focAn144VCNp3ymmNT2pwgLQqHf+GDPa
=UcUF
-----END PGP SIGNATURE-----

--=-F+w2NSPw/7fNdbXKWqqq--


--===============0434078510731451858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0434078510731451858==--
