From: "Tony \"Chainsaw\" Vroon" <chainsaw@gentoo.org>
Subject: Audigy bay protocol
Date: Thu, 26 Jun 2008 14:11:55 +0100
Message-ID: <1214485915.3972.32.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6401867370108392719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 150B124648
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 15:13:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ganymede.vroon.org (Postfix) with ESMTP id 37E565B8355
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 14:13:09 +0100 (BST)
Received: from [195.66.233.95] (amalthea.dyn.pbo.linx.net [195.66.233.95])
	(Authenticated sender: tony@vroon.org)
	by ganymede.vroon.org (Postfix) with ESMTP id C43C35B8345
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 14:12:59 +0100 (BST)
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


--===============6401867370108392719==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ikGVGN8XJqPH+58srMen"


--=-ikGVGN8XJqPH+58srMen
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Good afternoon,

Having spent some time looking at the MIDI that the internal/external
Audigy bays emit, I noticed that they report more then is currently used
by the LIRC driver.

There is one thing missing in here, which is how to control the bay
power LED (which is supposed to blink when the card is muted) and the
CMSS LED. I am not sure whether this is controlled through MIDI SysEx
sequences or through other means.

Due to an annoying hardware failure in my Audigy 4 Pro I can not
continue this endeavour, but I want to share what I have.

Based on this, perhaps one can extend the EMU10K1/2 driver a bit with
headphone muting and volume control through the bay. With thanks to the
libdouze author, Arnaud de Bossoreille de Ribou.

=EF=BB=BFMidi System Exclusive ( extended manufacturer id =3D=3D 0x2021 )
Payload for 61 bay message:
61 00 01 00 XX YY

XX=20
00 =3D button push event
01 =3D volume knob event
02 =3D jack sense event

For XX=3D00 button push:
Bit 1: CMSS
Bit 2: Mute

For XX=3D01 volume knob:
Bit 1: Always set
Bit 7: Set for downward adjustment, unset for upward adjustment

For XX=3D02 jack sense:
YY contains jacks
Bit 1: headphone
Bit 2: digital out (back of bay)

Response to initialization:
Midi System Exclusive ( extended manufacturer id =3D=3D 0x2021, payload =3D=
=3D |
60 00 02 03 | )       <-- Unknown, bay version?
Midi System Exclusive ( extended manufacturer id =3D=3D 0x2021, payload =3D=
=3D |
61 00 01 00 02 01 | ) <-- Jack sense update

I hope it is of use to someone.

Regards,
Tony V.

--=-ikGVGN8XJqPH+58srMen
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhjlZsACgkQp5vW4rUFj5oB7wCgsHHSk4yOs2rEpVa+5XI7KjIO
A0EAn1z1mFWsANDvE2rBniRCg7vffVcW
=0q85
-----END PGP SIGNATURE-----

--=-ikGVGN8XJqPH+58srMen--


--===============6401867370108392719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6401867370108392719==--
