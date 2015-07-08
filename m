From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regmap: Use different lockdep class for each regmap init
 call
Date: Wed, 8 Jul 2015 10:37:08 +0100
Message-ID: <20150708093708.GM11162@sirena.org.uk>
References: <1435725839-33173-1-git-send-email-drinkcat@chromium.org>
 <20150707121348.GD2887@sirena.org.uk>
 <CANMq1KAD95JWkP6MbVck2bSZwHpz09CRYfZmUi4N0RBrF6zK-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYX8XqlwBJQgDxCD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KAD95JWkP6MbVck2bSZwHpz09CRYfZmUi4N0RBrF6zK-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--zYX8XqlwBJQgDxCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2015 at 11:32:42AM +0800, Nicolas Boichat wrote:
> On Tue, Jul 7, 2015 at 8:13 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Jul 01, 2015 at 12:43:59PM +0800, Nicolas Boichat wrote:

> >> (this also applies to all other regmap_init functions...). We do not want to
> >> document the lock_key/name parameters, so we could either leave it like that,
> >> or move all the documentation to regmap.h, in front of the respective macros.

> > That seems reasonable.

> Which one? Leave as-is? Or move the documentation to regmap.h?

Move it to regmap.h.

--zYX8XqlwBJQgDxCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnO9DAAoJECTWi3JdVIfQ5IwH/1WFmQCfkF63peJVljQMEslm
Z6+1Zo6J85uHqdD8p05ZAF0T44NgxOlYA9yOSzMhsaQUZ/dymOzz7wtujzaA3hzB
0yonULp94UOUWv2iOF4tujPN50CIKpZWsin2yUtjxssA9f37VGwFcymVG/QLn2H6
y2qzN5xTwW1RFT6kZ7ADXc4fd0zc72zR1ybQ7BXjM/aDu5fTO73+CkdU9APRmIcU
kgvysx+zPQEBeaHUtZzjNOYIrNt7Run1qhKIPEynubwN531/UYrt6c3pJVaXWedS
ShkbNZPKJH9y3DytmyQU4dxZVpI6Ptwo+yRCdwav6r83ba4pLLEALNZt2Sb+xWE=
=0L0Z
-----END PGP SIGNATURE-----

--zYX8XqlwBJQgDxCD--
