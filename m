From: Tony Vroon <tony@vroon.org>
Subject: Re: [ALC262 patch_realtek.c] Add Fujitsu
	Lifebook	E8410 to quirk table
Date: Tue, 26 Feb 2008 17:27:15 +0000
Message-ID: <1204046835.20866.27.camel@amalthea>
References: <1203950877.6897.7.camel@amalthea.dyn.pbo.linx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5910763947266319686=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ACCC24358
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 18:27:43 +0100 (CET)
In-Reply-To: <1203950877.6897.7.camel@amalthea.dyn.pbo.linx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5910763947266319686==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J/9jZaZTBMl2VElZcxmU"


--=-J/9jZaZTBMl2VElZcxmU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-02-25 at 14:47 +0000, Tony Vroon wrote:
> Could you please consider the following patch for 2.6.25-rc4.
> The BIOS autoprobe doesn't do a very good job setting this card up.
>=20
> Card details:
> 00:1b.0 0403: 8086:284b (rev 03)
>         Subsystem: 10cf:142d
>=20
> (and verbose codec information attached)
>=20
> Regards,
> Tony V.
> LINX sysadmin

In case additional information is required: http://pastebin.ca/919171
And as this diff may end up in the mainline kernel:

Signed-Off-By: Tony Vroon <tony@linx.net>

Takashi, could you please let me know if you require further information
before you can apply this?

Regards,
Tony V.

--=-J/9jZaZTBMl2VElZcxmU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHxEvzp5vW4rUFj5oRAjAiAJ98xvU/wRaZxdHUYi4IRrUQg3ewVwCeNI8i
VdpqnPXYpZtf1nvQPuSC4jc=
=Zm2N
-----END PGP SIGNATURE-----

--=-J/9jZaZTBMl2VElZcxmU--


--===============5910763947266319686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5910763947266319686==--
