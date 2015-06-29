From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Mon, 29 Jun 2015 15:19:40 +0100
Message-ID: <20150629141940.GD11162@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
 <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
 <20150625160817.GT14071@sirena.org.uk>
 <CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
 <5591414D.6080802@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5591414D.6080802@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Arjan van de Ven <arjan@linux.intel.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 02:59:57PM +0200, Lars-Peter Clausen wrote:

> Maybe we are just over-thinking this and should just add one key to each
> regmap instance. That solves the issue without requiring the any user
> interaction. The only downside is that it might impact the performance of
> lockdep and uses quite a few lock classes. Its probably manageable right now
> but could grow into a problem as regmap adoption further progresses. But
> maybe we can leave the hard work of figuring a better solution to our future
> selves.

I thought the issue with that was that all lockdep classes need to be
allocated statically?  If we can just do something that scales with
regmap instances I'm not sure there's a big problem, even if adoption
increases we're talking about something that scales with the number of
devices in the system rather than the number of drivers using the API
which should be a lot more manageable.

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkVP8AAoJECTWi3JdVIfQP1cH/RzAfNsfVMrvAPuD8BmIxRJi
7ai6y5Ua6/FeyjWjaKOaX2YWUfQlXtxSDR+vaWOhtvgoPS8XgYp6pRfjVoMUC70B
8jybTlM3n5Ax9cK+vYsPWIfZ4pfqZ/EiAAR8Y7g4q4aHmHNISTabEtI8XZngQ9hw
33fxB3YbvLsEMX6+TVwhtV1JFMwlb4QfciNFHFqZYVy5dGzLvrxSNFgzUiqrHhij
ZGH9uaRrAQHFkpBO3b/aO3yypKSJdTVy3MJNg3lLhQqrIt0Lkvi2c9xNDKzLAtMT
I1V/cebF5aibvwrvG0b2NUSco0/r9ya3LKbfvCYEwRQ0DG2zOKX7ecn3j+0KVp8=
=vNSx
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
