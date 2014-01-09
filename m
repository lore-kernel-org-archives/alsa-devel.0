From: Olivier =?ISO-8859-1?Q?Cr=EAte?= <olivier.crete@ocrete.ca>
Subject: Surround sound not working on ALC887 based motherboard
Date: Thu, 09 Jan 2014 11:53:34 -0500
Message-ID: <1389286414.4661.13.camel@TesterBox>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1709955698466014986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by alsa0.perex.cz (Postfix) with ESMTP id A2830261AC4
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 17:53:40 +0100 (CET)
Received: from TesterServ.TesterNet ([135.19.19.22])
 by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MZ50026Q89DTF40@VL-VM-MR003.ip.videotron.ca> for
 alsa-devel@alsa-project.org; Thu, 09 Jan 2014 11:53:37 -0500 (EST)
Received: from [2607:f2c0:f00e:4a01:ca60:ff:fee1:1511]	by TesterServ.TesterNet
 with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)	(Exim 4.80)
 (envelope-from <olivier.crete@ocrete.ca>)
 id 1W1IrQ-0008Dh-VY	for alsa-devel@alsa-project.org; Thu,
 09 Jan 2014 11:53:37 -0500
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


--===============1709955698466014986==
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-EM4TOlNbUagebjaOA4jr"


--=-EM4TOlNbUagebjaOA4jr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a Asus P5G41T-M LX Plus motherboard which is ICH7 + Realtek
ALC887-VD, alsa only lets me access the first 2 channels (stereo), but
not the 6 other ones. It works fine in Windows.

Trying to run this after killing pulseaudio fails:

$ aplay -D surround40:0 -f S16_LE -r 44100 -c 4 /dev/zero -v
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 44100 Hz, =
Channels 4
aplay: set_params:1239: Channels count non available


Output from alsa-info:
http://www.alsa-project.org/db/?f=3Dfe378d28f0dbb5a427b005d20866a762fd37d31=
a

--=20
Olivier Cr=C3=AAte
olivier.crete@ocrete.ca

--=-EM4TOlNbUagebjaOA4jr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlLO1A4ACgkQHTiOWk7ZortJ6wCfdUoYYN0rQnzx+ZLWnOmQe272
dz4AnjG5SnP13TBQSeeN3Qn+bdBtJ41L
=4jc/
-----END PGP SIGNATURE-----

--=-EM4TOlNbUagebjaOA4jr--


--===============1709955698466014986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1709955698466014986==--
