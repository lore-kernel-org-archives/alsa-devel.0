From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Mon, 29 Jun 2015 15:22:15 +0100
Message-ID: <20150629142215.GE11162@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
 <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
 <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
 <5591414D.6080802@metafoo.de>
 <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANMq1KAmV7f2f8zhL+VVdpL3AeQKe8RB5nigmZDwrn=JbWGh9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arjan van de Ven <arjan@linux.intel.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 10:03:09PM +0800, Nicolas Boichat wrote:

> regmap instances are kalloc'ed, so they cannot contain the
> lock_class_key, which needs to be statically allocated (in .data).
> Another option would be to preallocate a bunch of lock_class_key in
> regmap.c, and pick from that, but that's terribly hacky...

Honestly this is all starting to sound like we're having to jump through
too many hoops for lockep (and other APIs are too from the sounds of it)
so we should be looking at lockdep here.

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkVSWAAoJECTWi3JdVIfQ6VIH/1NYT8QroxC9HT9F2D29bDMN
guOaxsKtuEEjdNuB3ZyfOB88J5JgcCSOtb99HYTPdyTg1k66wSCwdP0g75X2OoUr
p/jfVDCQFf1fTz9bryAik3yvDA0Qq5OpKQh9yVcZokixsHGvB8hrmL2umotFhLsg
Elw4rizQ5vOpsuFlwi+TjYMTekycBlpSobwHQW/KrBd68hpA/aI+PddCn00GjOJS
BX+EpYXOKZUT5XCfIvMv9WraqY6y7CXgvJeMKytBFd/msI7lYa4B1250wL2XD6S3
ut9N0Wnz4PIOK9ZD2yzbumDInapqUjeWR1Tby/WmFBNn5cF7UO+9HUvffWiW2s4=
=uO83
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
