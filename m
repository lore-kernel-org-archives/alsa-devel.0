From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Wed, 3 Dec 2014 20:13:53 +0000
Message-ID: <20141203201353.GN7712@sirena.org.uk>
References: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
 <20141009231042.GC18557@sirena.org.uk>
 <CAEUnVG72KL7iYGVgg8UMM6NyeSEe8vFADjFKzE4cLUUYwqTq5w@mail.gmail.com>
 <20141013080110.GE27755@sirena.org.uk>
 <CAOMFOmWJgceaLYbZ_yk_40eDrO7manNw9MEh0uDUH+_sW3GbCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3366365941564354504=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BCBE2604D2
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 21:14:02 +0100 (CET)
In-Reply-To: <CAOMFOmWJgceaLYbZ_yk_40eDrO7manNw9MEh0uDUH+_sW3GbCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.de>, Dylan Reid <dgreid@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, benzh@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============3366365941564354504==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JuJMKr6sBb2Uq5xY"
Content-Disposition: inline


--JuJMKr6sBb2Uq5xY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 12:10:52PM -0800, Anatol Pomozov wrote:

> If kernel solution is preferable are you going to accept Dylan's
> solution then? Or you think it should be implemented other way?

To repeat my original review comment:

| The usual thing to do with these is just to halve the resolution of the
| control by ignoring the low bit so that you get exact values, though for
| this device that does result in a relatively large step (step sizes like
| 0.125dB are more common).  I dunno, doesn't make much difference either
| way from my point of view.

--JuJMKr6sBb2Uq5xY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf28BAAoJECTWi3JdVIfQahEH/0F09f38SO8QgqBD9O7CbqHV
5VzfR3bBRKeW5jyev4SNfKS8tQ4o/TbeP0hPYzKkpaBiZ+XPLEBwjMnjaYOnpNUQ
ciEufkQLPKdhuS9O85ojEu3hHDDdwaX1E6/OpdyFWDSI0sOe8mDG3qOgUsx69G/Q
cyft430PAa7bcqN00gt+asOsfKLIOwsHzv/Mq03jZYBufcw7DrS4ZODEUz24wAix
lRrseGfEktms4LhaqKmbsOWyYx6oQlN6gou/oOmozlTB7sTj4H/d4tTFTIfIYcqJ
Oao4s9cWjdTn9JcNlJHDiBooZ5AqrqEPo5Magq0dJW0q9WmiHaeoVY2rh/RG9C4=
=V9Wn
-----END PGP SIGNATURE-----

--JuJMKr6sBb2Uq5xY--

--===============3366365941564354504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3366365941564354504==--
