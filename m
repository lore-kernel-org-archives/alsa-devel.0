From: Thorsten =?ISO-8859-1?Q?Edelh=E4u=DFer?= <toersi@gmx.de>
Subject: MIDI message handling
Date: Tue, 03 Jun 2008 21:54:47 +0200
Message-ID: <1212522887.17865.14.camel@un1001x>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5229179811530836659=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 745032483D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jun 2008 21:54:50 +0200 (CEST)
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


--===============5229179811530836659==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9AFVD5OQl6Fd077fqsQw"


--=-9AFVD5OQl6Fd077fqsQw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi!

I'm writing a driver for the MARIAN MARC 8 Midi soundcard. Today I
tested some MIDI functionality and get some errors from hydrogen
("unhandled midi message type"). I did some research and got to the
point, that the MIDI alive message (0xfe) should not arrive at the
application. So my question is: Do I have to process the midi messages
by myself before I give it to the alsa "snd_rawmidi_receive" function?
Or is there already some code, which will do it?

If someone is interested here is the project page:
http://sourceforge.net/projects/marc8-driver/=20

Regards,
Thorsten

--=-9AFVD5OQl6Fd077fqsQw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIRaGHOMZokbhZ9v4RAsBFAJ9AR7keMGahP+zsnw2xV2Ih+cQUYACfal8O
D0rJhGpFahV1qRc4uRBqsyQ=
=9pA6
-----END PGP SIGNATURE-----

--=-9AFVD5OQl6Fd077fqsQw--


--===============5229179811530836659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5229179811530836659==--
