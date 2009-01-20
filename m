From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Tue, 20 Jan 2009 17:33:24 +0100
Message-ID: <m2d4ei9bu3.fsf@gmail.com>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
	<m2iqoa9jem.fsf@gmail.com>
	<200901201526.51060.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0901201718390.8466@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5124561192712040297=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 434C410381B
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 17:32:14 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPJWN-0004hv-Us
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 16:32:11 +0000
Received: from ppp-196-234.21-151.libero.it ([151.21.234.196])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 16:32:11 +0000
Received: from flameeyes by ppp-196-234.21-151.libero.it with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 16:32:11 +0000
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

--===============5124561192712040297==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela <perex@perex.cz> writes:

> Note that front and surround devices does not support automatic sample=20
> conversion. Use plug:front, plug:surround40 etc. devices.

Using the correct format, front:IDX should work with two channels sound
files, and it doesn't, nor surround40:IDX works with four channels or
surround71:IDX with eight channels.

[I'm using IDX because I have it on :1 rather than :0]

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkl1/NgACgkQe2h1+2mHVWOIigCaA6iXWprEy2clWsvD1wvdVcYz
Q+sAni6S/lUWF02IO9MqyqjhoyvIfq5Z
=yhdD
-----END PGP SIGNATURE-----
--=-=-=--


--===============5124561192712040297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5124561192712040297==--
