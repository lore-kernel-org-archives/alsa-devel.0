From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm5100: match wait_for_completion_timeout return
 type
Date: Sun, 8 Mar 2015 18:49:02 +0000
Message-ID: <20150308184902.GT28806@sirena.org.uk>
References: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpUp1egui7PDlNtH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425812227-24172-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Axel Lin <axel.lin@ingics.com>, abdoulaye berthe <berthe.ab@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--lpUp1egui7PDlNtH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2015 at 06:57:07AM -0400, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. An
> appropriately named unsigned long is added and the assignment fixed up.

You are sending these to a very large CC list many of whom have no
obvious connection to the driver - please take care to ensure that the
people you are sending patches to are likely to want to review the code,
this helps keep people's mailboxes less noisy.

--lpUp1egui7PDlNtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/JmeAAoJECTWi3JdVIfQfscH/3EDzSwHC0Yy1HKnD4Z4Y+mK
jS+ae68ynhAo9WKtJZwQBRo/eR5pIEC9qac07Ke+e1Jhip0cskIQsCmHPggpd9No
QK9ljPCEoBtrCxPMMq4IFhemm8ZMWEnWX3Cfd3E6tShUS8r88TUQm1xVKLEGHK02
SQAMYUPiRTvomNRC/fGWnYev+zvMZ2FDypEchpxHBICcSH6AWEbdyO1pXBzWBRyQ
3lM3p+kFWw9YkXsIma6a9rF0AwEu6/O0SomMTeKlXYe4FRWc6mKpzSb2OnrX/LdD
aBs3FxTDlvSgzfPFOXJHxSZXCYHZ+jUPrRjWvO8HymiPCOOJz5j8oAa3DH5qSZA=
=+nR3
-----END PGP SIGNATURE-----

--lpUp1egui7PDlNtH--
