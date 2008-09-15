From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] ALSA: HDA: hda_local: Less magic numbers.
Date: Mon, 15 Sep 2008 13:16:15 -0700
Message-ID: <20080915201615.GH6035@curie-int.orbis-terrarum.net>
References: <mailman.1.1221386401.30073.alsa-devel@alsa-project.org>
	<200809142340.m8ENeAHC016054@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7574214394068691862=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EB1812446B
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 22:19:56 +0200 (CEST)
In-Reply-To: <200809142340.m8ENeAHC016054@turbo.physics.adelaide.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@alsa-project.org, robbat2@gentoo.org
List-Id: alsa-devel@alsa-project.org


--===============7574214394068691862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2008 at 09:10:10AM +0930, Jonathan Woithe wrote:
> Shrug.  In my opinion the above patch simply reworks the explanation,
> shifting the "magic" from the PIN_* definitions to the AC_PINCTL_* define=
s.
> One could take things one step further and replace the PIN_* defines with
> AC_PINCTL_* references throughout the code, but this would make the code =
far
> more verbose and harder to follow.
>=20
> At the end of the day I'm not fussed either way.  Having said that, I don=
't
> really see the practical advantage of the change but if Takashi et al thi=
ng
> it's a good idea then I wouldn't oppose it.
A quick glance at the codebase shows:

AC_PINCTL* long form:
patch_conexant.c
patch_realtek.c
patch_sigmatel.c

/PIN_(VREF|IN|OUT|HP)/
hda_codec.c
patch_analog.c
patch_atihdmi.c
patch_cmedia.c
patch_conexant.c
patch_realtek.c
patch_sigmatel.c
patch_via.c

Raw hex for AC_VERB_SET_PIN_WIDGET_CONTROL verbs:
patch_analog.c
patch_realtek.c (LOTS)
patch_via.c (LOTS)

The raw hex ones SHOULD be replaced, but the rest of them I'm not fussed ei=
ther
way. Takashi can make a decision as to which variant is preferred, I don't =
mind
doing the cleanup.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkjOwo8ACgkQPpIsIjIzwixwTwCeOgM4rkHgAyW6g5P5796YBAyN
U5wAoP56vSkXBY7SPfFWO0bxz0ZzpIl+
=oaTg
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

--===============7574214394068691862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7574214394068691862==--
