From: Tim Blechmann <tim@klingt.org>
Subject: Re: [PATCH] alsa: lx6464es - initialization fixes
Date: Tue, 26 Jul 2011 09:13:52 +0200
Message-ID: <201107260913.52185.tim@klingt.org>
References: <a5e69d2bc39aa8f0a29acbcebc4992a84089e662.1311618842.git.tim@klingt.org>
	<s5hipqp37ud.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2494171225589843231=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 09251103877
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 09:13:53 +0200 (CEST)
In-Reply-To: <s5hipqp37ud.wl%tiwai@suse.de>
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

--===============2494171225589843231==
Content-Type: multipart/signed;
  boundary="nextPart262335634.ZafsR3p0Jj";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--nextPart262335634.ZafsR3p0Jj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> > this using this fix, the driver is usable with non-rt kernels. the card
> > initialization is moved from the prepare to the hw_params callback.
>=20
> I don't care much and will accept the change like this (after fixing some
> issues below), but still wonder why moving to hw_params fixes the
> issue...

well, i suppose, i am the only user of this driver anyway (at least nobody=
=20
experienced this issue, which i have been seen on multiple machines). doing=
 some=20
more tests yesteday evening, it seems that this patch fixes the startup iss=
ue=20
only in about 90% of all cases. my guess is that it is some kind of timing =
issue=20
in the communication between driver and microcontroller. most likely becaus=
e=20
playback and capture devices are started separately.

unfortunately, the error code reported by the uc is not specified in the=20
documentation.


> > -	snd_printd(LXP "allocating pipe for %d channels\n", channels);
> > +	snd_printk(LXP "allocating pipe for %d channels, %lu period size\n",
> > +		   channels, period_size);
>=20
> Please don't change the debug message to a normal message.
> This would appear way too likely.  Even I think snd_printdd() would be
> more appropriate there, since snd_printd() is enabled on most distros.

will prepare a separate patch, when i am back in the studio ...

tim

--nextPart262335634.ZafsR3p0Jj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iF4EABEIAAYFAk4uaTAACgkQMLNj2qIwZ4UdeQD9FrRNWoI9Tz9n87eqvWL8cDj8
7i0AXNGVv52NcpV6vnIBAIPRbUZQA+iqhPImR7j80/6ORLjZ0NTZHAezyPlOK58e
=sjwO
-----END PGP SIGNATURE-----

--nextPart262335634.ZafsR3p0Jj--

--===============2494171225589843231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2494171225589843231==--
