From: flameeyes@gmail.com (Diego E. 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Tue, 20 Jan 2009 14:49:53 +0100
Message-ID: <m2iqoa9jem.fsf@gmail.com>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201339310.8466@tm8103.perex-int.cz>
	<m2ocy29lyw.fsf@gmail.com>
	<Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0528532787090415563=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id DD87D1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 14:48:43 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPGyC-00065Y-LE
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 13:48:44 +0000
Received: from ppp-196-234.21-151.libero.it ([151.21.234.196])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:48:44 +0000
Received: from flameeyes by ppp-196-234.21-151.libero.it with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:48:44 +0000
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

--===============0528532787090415563==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jaroslav Kysela <perex@perex.cz> writes:

> Do you have seen M-Audio Delta 1010 ? The problem is that we have hardwar=
e=20
> that can be used for surround output, but alsa-lib configuration files=20
> cannot describe the restrictions in detail now.

I thought that was an ICE1724, rather than 1712; I was mistaken, sorry.

Still, as they are the devices are non-functional at least on my card,
and I'm ready to bet that the same would happen on the Delta 1010 given
that the number of channels is not coherent (you try to open surround71
as 8-channels and it'll fail because this minimal card has 10; if the
1010 has the same amount of channels, it'll still fail).

Maybe there's a way to describe different ICE1712-based cards with
different configuration files so that the surround device appears only
on surround-capable cards? Or let the user decide whether to load them?

Having them present and failing is not really nice.

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkl11oUACgkQe2h1+2mHVWNixgCfU0W6MDdWA+pT/HbIscy0swid
gKsAnAk9Tph2qYuhECa6BJB+laHfaMYu
=g6wN
-----END PGP SIGNATURE-----
--=-=-=--


--===============0528532787090415563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0528532787090415563==--
