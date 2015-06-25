From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Thu, 25 Jun 2015 15:29:08 +0100
Message-ID: <20150625142908.GN14071@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rW2A8dyr+BRtDLGi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558C0067.2000401@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--rW2A8dyr+BRtDLGi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 06:21:43AM -0700, Arjan van de Ven wrote:

Please fix your mailer to word wrap within paragraphs.

> wouldn't it be better to use the mutex_lock_nested() and co to
> explicitly express your hierarchy?

That was one of my original suggestions - one of the problems with this
code is that it's very much been presented as "here's the solution", it
took a long time to even discover the problem they were trying to solve.
I don't know exactly what the issue is supposed to be here, AFAICT the
answers were about lock classes not about subclasses because apparently
it's essential that we use lock classes.

--rW2A8dyr+BRtDLGi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjBA0AAoJECTWi3JdVIfQNmkH+wZvSaOj2SxY52WTAZm+csIK
48c3UVCejgS5M5BzztEM8jp24c0FCMspXQp7J9M5sADGP4tBCJglNprOrErdtK9a
JLu1l6UraKpx6BtBcuNCJccXP3O9B49iesr8XM5qD81KmxqKGQupBpM8jlEeV8Dm
fsweJf0Q5RpnjvAPpMM5N8lMgwpCwTTnXR8sdyC9sAJSAovwjDiSd8tQF91ufg1K
qWfvo1F68+97df2UtyUTFO5yFlblqrqDwvFbUuj+42vnkW8nFKCAnM9EH9ybnyKQ
y9Nc3NOh4Av0LZY815mAmqtUsevhX7FnFO/AVoTlzT0UGzyzLsvKOSC2Dfcpblk=
=gvZ4
-----END PGP SIGNATURE-----

--rW2A8dyr+BRtDLGi--
