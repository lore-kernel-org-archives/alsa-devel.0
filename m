From: Pierre Ossman <ossman@cendio.se>
Subject: Re: [PATCH] Allow ioplugins to override snd_pcm_delay()
Date: Fri, 26 May 2006 14:31:13 +0200
Message-ID: <4476F511.4090705@cendio.se>
References: <4476CC83.8080103@cendio.se> <s5hk689q8h5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0072466906=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 152A0177
	for <alsa-devel@alsa-project.org>;
	Fri, 26 May 2006 14:31:19 +0200 (MEST)
In-Reply-To: <s5hk689q8h5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0072466906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDF0F3785AECF4C82F819A7E1"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF0F3785AECF4C82F819A7E1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi Iwai wrote:
>=20
> The change is OK, but please remind that the API has been already
> public, so we need to keep the compatibility as much as possible.
> This addition will break the binary compatibility.
>=20
> First, we need the increase of version number
> (SND_PCM_IOPLUG_VERSION) if we modify API.  If the version of the
> object is older, either reject or allow it as compatible.
>=20
> One way to keep it binary-compatible is to append the new method to
> the end of the callback table, and check the version before accessing
> the new method (and handle as NULL for older version).
>=20
> Could you rewrite the patch in that manner?
>=20

No problem. I'll have it fixed later this afternoon.

--=20
Rgds
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


--------------enigDF0F3785AECF4C82F819A7E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdvUU7b8eESbyJLgRApnnAKDCR5SRLnUyXnvSt3ybjPDWTufl+gCgxIVO
YRcOyEbAiKk0c9mt4R5f7eE=
=0Pgf
-----END PGP SIGNATURE-----

--------------enigDF0F3785AECF4C82F819A7E1--


--===============0072466906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0072466906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0072466906==--
