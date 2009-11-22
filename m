From: Tony Vroon <tony@linx.net>
Subject: Xonar Essence ST (PCI) on 2.6.32-rc8-00011-ga8a8a66:
 no analog audio, SPDIF fine
Date: Sun, 22 Nov 2009 18:53:53 +0000
Message-ID: <1258916033.3113.8.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2841368433718074410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EFE92441D
	for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2009 19:51:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2841368433718074410==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PpAK187Tebxz/2ehrleP"


--=-PpAK187Tebxz/2ehrleP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good evening,

After the success of the Xonar D2X in my system, I decided to upgrade to
an Essence ST (of the PCI variety, no D6 daughterboard). Unfortunately
it seems that it produces no audio for me over the headphone port (the
reason I bought this card) or the front-panel headphone port.
I currently lack the RCA cabling to hook up the analog "speakers" port,
but I promise to try this as soon as practical.
The SPDIF output is functional and can be switched on and off using the
mixer controls.

I'm wondering if the Essence ST driver was written based on an a ST+D6
engineering sample as mine is the ST (no D6) retail box. Is it possible
that the hardware is different?

lspci output follows, in the hope that it is of use:
01:06.0 Multimedia audio controller [0401]: C-Media Electronics Inc
CMI8788 [Oxygen HD Audio] [13f6:8788]
	Subsystem: ASUSTeK Computer Inc. Virtuoso 100 (Xonar ST) [1043:835d]
	Flags: bus master, medium devsel, latency 64, IRQ 17
	I/O ports at c800 [size=3D256]
	Capabilities: [c0] Power Management version 2
	Kernel driver in use: AV200

Also, from the ALSA side:
# cat /proc/asound/ST/cmi8788=20
CMI8788

00: 80 e7 1e 86 d0 ed eb cf 00 00 88 bf ff 7f ff 3f
10: d8 ce 98 7e 7c ef c4 c1 00 00 8a bf 37 11 4f 04
20: 60 f7 93 bf af 5a 00 00 d7 4e 00 00 00 00 00 00
30: 30 81 91 92 20 92 ba 74 00 00 00 00 00 00 00 00
40: 10 00 00 00 10 40 00 00 00 00 00 00 00 00 00 00
50: 72 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 19 01 00 09 19 01 00 09 00 00 00 00 00 00 00 00
70: 02 20 00 01 24 08 00 00 00 00 00 00 00 00 00 00
80: 00 40 4d 43 00 00 00 00 00 00 00 00 00 00 00 00
90: 98 11 bf 00 c0 01 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 01 00 93 01 8f 01 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 20 e0 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
d0: 10 00 03 00 00 00 00 00 00 00 00 00 1f 9f 96 00
e0: 01 00 00 00 07 00 0e 00 00 02 05 00 00 b2 02 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

AC97
00: 0000 0000 0000 0000 0000 8000 0000 8808
10: 8808 8808 8808 9f1f 8808 0000 8000 0000
20: 0000 0000 0000 030c 0bc2 3c30 0000 0000
30: 0000 0000 0000 8080 8080 2000 0000 0000
40: 0000 0000 0000 0000 0000 0000 0000 0000
50: 0000 0000 0000 0000 0000 0000 0004 0000
60: 8080 188f 8043 0004 0000 0000 0000 0000
70: 0300 0011 c000 3935 0000 0000 434d 4969

At any rate, thank you for the oxygen/virtuoso driver. Hopefully this
can be solved. The card does seem to be driven fine as the PCM sinks
receive their audio without complaint and any multimedia player I use
starts output.

Regards,
Tony V.

--=-PpAK187Tebxz/2ehrleP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAksJiMEACgkQp5vW4rUFj5pbiwCbBh5l+JS320pNkSSi5pUu9rfG
JmcAnjX1xkyZAIWmHRxv7oUqgedGxr9Q
=Ovjk
-----END PGP SIGNATURE-----

--=-PpAK187Tebxz/2ehrleP--


--===============2841368433718074410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2841368433718074410==--
