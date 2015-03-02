From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
Date: Mon, 2 Mar 2015 17:53:25 +0000
Message-ID: <20150302175325.GZ21293@sirena.org.uk>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106174521.GM2634@sirena.org.uk>
 <20150302134253.GQ4094@piout.net>
 <20150302140638.GW21293@sirena.org.uk>
 <20150302141940.GR4094@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DkvK86hs9Oj0yltN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150302141940.GR4094@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--DkvK86hs9Oj0yltN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 03:19:40PM +0100, Alexandre Belloni wrote:
> On 02/03/2015 at 14:06:38 +0000, Mark Brown wrote :

> > *sigh*  If something is a bug fix then please flag it as such; nothing
> > in your message gives any hint that this is a fix rather than just a
> > random cleanup.

> Well, I though this would be applied along with
> "ASoC: atmel: sam9g20_wm8731: remove useless include" which made it to
> 4.0-rc1 and was also a simple cleanup.

That's one line as opposed to an at least mechanically large change.

> It was a simple cleanup until all the machine_is_at91xxx got dropped :)

Which shouldn't have happened while there were still users.  :/

--DkvK86hs9Oj0yltN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9KOUAAoJECTWi3JdVIfQ5J0H/1TeC87tdJK5tL+QKNf9q1qZ
/SnY0724yh0nJ9Vk2iypQhjDBZU8d5FGSbsxRsZljUp8r3OVms3bHvmO2GEPzVYM
BvXGnVUcRmgdbqqXtAUEorDXtEwPjj01k886ChnALER+zcRTyN4Vynqkv9DJH9PP
t5rn6MBvRZHSv6Rv8CZmishq6FJ6S7SDEiFzDcW37GtpLsDfKvsIeLj7ZcYsMVPO
AM2bmHmV8HihePS93nZHPiBNF5VNjQ8rBEIyNuvMWeW5TQJfhTUZoxb3d7WyYM8Z
Dx6yMahClpjGZXsMFV2Udnn0pWE9BziBtOkIA6IuN59bbdNi+RZaINgcsz5TzpE=
=O8/o
-----END PGP SIGNATURE-----

--DkvK86hs9Oj0yltN--
