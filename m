From: Michael Gerdau <mgerdau@tiscali.de>
Subject: Re: [PATCH] aplay/arecord - Add support for IEEE float
	32-bit WAV files
Date: Wed, 6 Feb 2008 15:03:28 +0100
Message-ID: <200802061503.47269.mgerdau@tiscali.de>
References: <711f7227eb13715f8a4b.1201991392@am2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5585518974938069137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp11.unit.tiscali.de (smtp11.unit.tiscali.de [213.205.33.47])
	by alsa0.perex.cz (Postfix) with ESMTP id C101F24468
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 15:04:14 +0100 (CET)
Received: from noname (91.3.100.117) by smtp11.unit.tiscali.de (7.3.122)
	(authenticated as mgerdau@tiscali.de)
	id 47975B550036869F for alsa-devel@alsa-project.org;
	Wed, 6 Feb 2008 15:03:58 +0100
In-Reply-To: <711f7227eb13715f8a4b.1201991392@am2>
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

--===============5585518974938069137==
Content-Type: multipart/signed;
  boundary="nextPart13984420.Za01R8f4Vj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart13984420.Za01R8f4Vj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> +/* WAVE fmt block constants from Microsoft mmreg.h header */
> +#define WAV_FMT_PCM             0x0001
> +#define WAV_FMT_IEEE_FLOAT      0x0003
> +#define WAV_FMT_DOLBY_AC3_SPDIF 0x0092

Does this mean "copy and paste" from M$ copyrighted work ?
And if yes, wouldn't that imply a copyright violation committed by ALSA ?

Just asking, best,
Michael
=2D-=20
 Michael Gerdau       email: mgerdau@tiscali.de
 GPG-keys available on request or at public keyserver

--nextPart13984420.Za01R8f4Vj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHqb5DUYYhyuxDQc4RAgYqAJ4tWBVtbH76yVEnKNAkaScCeCcQ0QCff7/1
9MXtF1dVwvM0HoPmkELB1z8=
=FUH5
-----END PGP SIGNATURE-----

--nextPart13984420.Za01R8f4Vj--

--===============5585518974938069137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5585518974938069137==--
