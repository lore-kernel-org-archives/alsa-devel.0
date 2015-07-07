From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: Use different lockdep class for each regmap init
 call
Date: Tue, 7 Jul 2015 13:13:48 +0100
Message-ID: <20150707121348.GD2887@sirena.org.uk>
References: <1435725839-33173-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435725839-33173-1-git-send-email-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2015 at 12:43:59PM +0800, Nicolas Boichat wrote:

> (this also applies to all other regmap_init functions...). We do not want to
> document the lock_key/name parameters, so we could either leave it like that,
> or move all the documentation to regmap.h, in front of the respective macros.

That seems reasonable.

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVm8J8AAoJECTWi3JdVIfQ38gIAINklA34YMCQSAo+85mpchrA
zC1v3/qB6GGeZpL66CZkkQRFjB1J2XaF9ksiJubxMOD0VyxzqfSlE2zOGZKuW6uR
oX7pVSzHFxpgd+dWhaXiCyW1Jgokhz6y91802FAyCbbwQRpIjelMdUdu+3O8LDS8
VBujG2UD0ttMtIwi/TOUj5I2+NcC3zgKf+NDREbgT+4uhmY79Nq7NDxnLNkb0Wts
+PxWxcH3Q2ZMpaXZqNn8IPUJg6gobdAJS60VnaZ5XBvA5LqaPeBJl4EbhdC2O7xC
VGVtji+FZS6uNvRiMEOEvQ6Kzc31GvzilJsI5Pc+SpoOVQWOcY8C0YItJ7eKhvE=
=e/uH
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
