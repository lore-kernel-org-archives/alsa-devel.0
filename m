From: Luca Bruno <lucab@debian.org>
Subject: Re: [PATCH] ALSA: hda - Add quirk and model 'vaio' for
 ALC269-based Sony Vaio E Series
Date: Tue, 6 Apr 2010 14:47:06 +0200
Message-ID: <20100406144706.8d12c144.lucab@debian.org>
References: <1270216442-5632-1-git-send-email-lucab@debian.org>
	<s5hiq87h5j7.wl%tiwai@suse.de>
	<20100404133802.25104e02.lucab@debian.org>
	<s5haatigt0t.wl%tiwai@suse.de>
	<20100406122136.c38ce959.lucab@debian.org>
	<s5heiis7u16.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6873467252675632461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.unstable.it (host-93-93-202-11.planetacomnetwork.com
	[93.93.202.11]) by alsa0.perex.cz (Postfix) with ESMTP id BD2CA103830
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 14:47:08 +0200 (CEST)
Received: from localhost (host252-192-dynamic.21-79-r.retail.telecomitalia.it
	[79.21.192.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.unstable.it (Postfix) with ESMTPSA id 59E8F12006F
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 14:47:37 +0200 (CEST)
In-Reply-To: <s5heiis7u16.wl%tiwai@suse.de>
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

--===============6873467252675632461==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__6_Apr_2010_14_47_06_+0200_ttgNuxPgUniIpO3Q"

--Signature=_Tue__6_Apr_2010_14_47_06_+0200_ttgNuxPgUniIpO3Q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai scrisse:

> Thanks.  And what actually doesn't work with model=3Dauto?
> With the very latest driver, both mic and HP auto-switching seems
> working.

Mic was working, but got no sound via internal speakers nor through
headphones. Switching VREF did the magic.

At the time, I tried various git revision till=20
http://git.alsa-project.org/?p=3Dalsa-kernel.git;a=3Dcommitdiff;h=3Dbcd10cd=
ee90866f7c03256a23bc77d7e3c976731
when I decided to cook up a quirk.

If you have a particular revision to suggest, I can re-try that without
my patch. Also, are the bleeding-edge drivers on kernel.org or on
alsa-project.org git?=20

Cheers, Luca

--=20
 .''`.  ** Debian GNU/Linux **  | Luca Bruno (kaeso)
: :'  :   The Universal O.S.    | lucab (AT) debian.org
`. `'`  			| GPG Key ID: 3BFB9FB3
  `-     http://www.debian.org 	| Debian GNU/Linux Developer

--Signature=_Tue__6_Apr_2010_14_47_06_+0200_ttgNuxPgUniIpO3Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAku7LUoACgkQRqobajv7n7PHsACdGkiyMEpaswwGT6LWgtcdGyKQ
ptoAoJg1Uqf7j69HCiaZw303HU+yMGII
=NXfT
-----END PGP SIGNATURE-----

--Signature=_Tue__6_Apr_2010_14_47_06_+0200_ttgNuxPgUniIpO3Q--

--===============6873467252675632461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6873467252675632461==--
