From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Thu, 25 Jun 2015 17:08:17 +0100
Message-ID: <20150625160817.GT14071@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
 <558C1824.8020204@metafoo.de>
 <20150625153325.GR14071@sirena.org.uk>
 <558C229D.4090409@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvTiEWYgUls3zgj3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558C229D.4090409@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Nicolas Boichat <drinkcat@chromium.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--vvTiEWYgUls3zgj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 05:47:41PM +0200, Lars-Peter Clausen wrote:
> On 06/25/2015 05:33 PM, Mark Brown wrote:

> >It depends on what you use as the key for the nested locking stuff.  If
> >you assign a key per regmap (casting the pointer to an integer, using an
> >IDR or something).  I don't know if that creates problems for the
> >locking code, I'd not expect so but then I'd not have expected the
> >problem in the first place.

> The maximum number of subclasses is 8 per lockclass, so a IDR that
> increments which each created regmap instance wouldn't really work.

Oh, fail.  Yeah, subclasses just won't work at all here and we need full
classes.

> And while on the other hand we probably wont have a hierarchy deeper than 8
> nested regmap instances it is not trivial to figure out which instance is at
> which level.

Yes, indeed.

> >As far as I can tell we're likely to end up needing a key per regmap or
> >something similar.

> Since the number of lockdep classes itself is also limited we should avoid
> creating extra lockdep classes when we can. I think the approach which
> having the option of specifying a lockdep class in the regmap config will be
> ok. The only case it can't handle if we nest instances with the same config,
> but I don't really see valid use scases for that at the moment.

Oh, ffs.  This just keeps getting better.  I hadn't been aware of that
limitation.  We still have the problem that this needs to be something
users can understand rather than something that's just "define something
here in one of your drivers if you're running into problems with
spurious warnings" here.  That's always been the biggest problem here
(once we got past the "what is this supposed to do in the first place?"
issues).

--vvTiEWYgUls3zgj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjCdwAAoJECTWi3JdVIfQfJ4H/1NYHi8ECacwj+s1/Lxb2hpt
COpjDcifZ5bIcJwXr4h+CNpIKSVMp0cVkyzmsuI9n0wLIUIOfMnJLOl080PwcpMZ
szf8BNFdui3O1qO4dq1EsRJIjiOlGncczvrL2p/RR3RlozHHXaKh/TVrgviFU41T
zavipqd4JjjQC1UXnVfYWwceT3I5GpCf6MtbirOntzbXMJDlj0IcDP/VWfoIAgU4
h7hMJ/pC64ODUadC7XKAlxVczXCiO2SqwFwzY/yvknwQeSfzu+wLlMCpfkuIkHD0
khGL5qm9awCg+nk8kelksK+IDIwVwMs/vRc7Ig5nU8zvvvGf4KtV7wWxBoao0nE=
=5wXs
-----END PGP SIGNATURE-----

--vvTiEWYgUls3zgj3--
