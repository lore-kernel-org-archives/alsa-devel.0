From: Tim Blechmann <tim@klingt.org>
Subject: Re: hdspmixer broken for 96khz
Date: Sun, 3 Apr 2011 11:39:41 +0200
Message-ID: <201104031139.41395.tim@klingt.org>
References: <in74oi$qce$1@dough.gmane.org>
	<20110403081606.GG28811@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7068152075261529932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 55030243D4
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 11:39:48 +0200 (CEST)
In-Reply-To: <20110403081606.GG28811@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============7068152075261529932==
Content-Type: multipart/signed;
  boundary="nextPart1502144.jOXhR4X22Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--nextPart1502144.jOXhR4X22Y
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > the updated hdspmixer doesn't work for 96khz any more. the 44.1/48 khz
> > versions are drawn correctly, the 88.2/96 khz version hides all
> > controls, so just the menu is visible.
>=20
> I've seen "both", a *working* hdspmixer at 96k and all hidden controls.
> The latter could be caused by wrongly initialized or restored presets.
>=20
> Can you try to activate the controls in the View menu again? Maybe even
> the shortcuts work: I for Input section, P for Playback and O for

ok, after removing my old hdspmixer configuration file, it seems to work. w=
ould=20
be good to have a more robust behavior, since the current behavior is quite=
=20
confusing and people may have rather complex mixer setups, which they would=
 need=20
to regenerate.

thnx, tim

=2D-=20
tim@klingt.org
http://tim.klingt.org

The price an artist pays for doing what he wants is that he has to do
it.
  William S. Burroughs

--nextPart1502144.jOXhR4X22Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iF4EABEIAAYFAk2YQF0ACgkQMLNj2qIwZ4WwCAEAz8awheq3id3ECb3XbM0j4Snf
O472o0jFaaKa+6hYtM8A/AsXOBXDp+0Ue3JwAK67GvRxdeUKTQbQUSnPo88HltKy
=2iQI
-----END PGP SIGNATURE-----

--nextPart1502144.jOXhR4X22Y--

--===============7068152075261529932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7068152075261529932==--
