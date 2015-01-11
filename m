From: Rumko <rumko@rumko.net>
Subject: Re: [PATCH - alsa-lib 1/1] include/global.h: missing
	struct on FreeBSD
Date: Sun, 11 Jan 2015 12:17:31 +0100
Message-ID: <1974835.OcM2UqamNN@nu-athena>
References: <54b0f97b.ca51c20a.1b71.ffffc3db@mx.google.com>
 <s5hd26l4no7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4118267445617597843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id EC951260439
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 12:17:38 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id em10so9690346wid.5
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 03:17:36 -0800 (PST)
In-Reply-To: <s5hd26l4no7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4118267445617597843==
Content-Type: multipart/signed; boundary="nextPart3360538.0FCp203BRE"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3360538.0FCp203BRE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sunday 11 January 2015 11:27:52 Takashi Iwai wrote:
> At Sat, 10 Jan 2015 11:04:59 +0100,
>=20
> rumko@rumko.net wrote:
> > From: Rumko <rumko@rumko.net>
> >=20
> > On FreeBSD, struct timespec is not accessible through <time.h>,
> > but through <sys/tiespec.h>. Add specific include for that header
> > on that platform only.
> >=20
> > Signed-off-by: Rumko <rumko@rumko.net>
>=20
> If you give your sign-off, please give the full real name.

Sorry about that, was just following
http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Develo=
pers
It specifically adds the -s flag to format-patch as instructions for ge=
nerating=20
the patchset.

Should I resubmit without it?

> thanks,
>=20
> Takashi
=2D-=20
Regards,
Rumko
--nextPart3360538.0FCp203BRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlSyW80ACgkQxV3ce2RZW709BQCeI3nl9ip4v7B27gk09iReTxwq
Af8An2xNZ0IzaFWx7co1vSXKbL1YDBx7
=Ld50
-----END PGP SIGNATURE-----

--nextPart3360538.0FCp203BRE--


--===============4118267445617597843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4118267445617597843==--
