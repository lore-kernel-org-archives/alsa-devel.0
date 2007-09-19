From: Mathis Hofer <mathis.hofer@dreamlab.net>
Subject: Re: Routing multiple signals to one output
 with	ice1712 (Delta 66)
Date: Wed, 19 Sep 2007 11:39:24 +0200
Message-ID: <46F0EE4C.5050007@dreamlab.net>
References: <46F0DFEC.802@dreamlab.net>
	<200709191043.59764.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3918876040555390334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailer.dreamlab.net (unknown [195.50.232.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F4B510380E
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 11:39:29 +0200 (CEST)
In-Reply-To: <200709191043.59764.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3918876040555390334==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig193E00EB005D351E327FF926"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig193E00EB005D351E327FF926
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi Alan

> What you are talking about is really mixing the streams in addition to =

> routing.  Envy24control basically gives you all the hardware options of=
 the=20
> chip.  The ice1712 (=3Denvy24 chip) includes a hardware mixer which can=
 be=20
> routed to HWOut1 and HWOut2 using envy24control, but not to other outpu=
ts. =20
> This will allow any inputs and any PCM streams to be mixed.  Note that =
these=20
> mixer settings can be controlled from an external MIDI control surface =
also!
Ok thanks.

> I am sure there are also software options.
So when I want to route (or as you say mix) multiple inputs to two
stereo outputs I have to do it software-wise, right? Is this possible
with alsa or do I have to use jack?

Mathis

--=20
DreamLab Technologies AG
Monbijoustrasse 36
3011 Bern
Switzerland

Tel: +41 31 398 66 66
Fax: +41 31 398 66 69

PGP Key ID: 2462240B


--------------enig193E00EB005D351E327FF926
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG8O5PVOkwMiRiJAsRAgAMAJ9gFiri8wUeqVnkQwj8tlP1yve0NwCfVfDD
ccarc2bA70BJwB7lKIvMYC8=
=hW0T
-----END PGP SIGNATURE-----

--------------enig193E00EB005D351E327FF926--

--===============3918876040555390334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3918876040555390334==--
