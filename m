From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock class key for
 lockdep
Date: Thu, 25 Jun 2015 16:33:25 +0100
Message-ID: <20150625153325.GR14071@sirena.org.uk>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C0067.2000401@linux.intel.com>
 <558C1824.8020204@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KMy4IPbjBvHJdHUq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558C1824.8020204@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Nicolas Boichat <drinkcat@chromium.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--KMy4IPbjBvHJdHUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 05:03:00PM +0200, Lars-Peter Clausen wrote:
> On 06/25/2015 03:21 PM, Arjan van de Ven wrote:

> >wouldn't it be better to use the mutex_lock_nested() and co to explicitly
> >express your hierarchy?

> That would require that the hierarchy is known in advance. The hierarchy
> depends on the hardware topology. Different systems will have different
> hierarchies where the relationship between locks can change and it will be
> hard to find a hierarchy that works across all topologies.

It depends on what you use as the key for the nested locking stuff.  If
you assign a key per regmap (casting the pointer to an integer, using an
IDR or something).  I don't know if that creates problems for the
locking code, I'd not expect so but then I'd not have expected the
problem in the first place.

As far as I can tell we're likely to end up needing a key per regmap or
something similar.

--KMy4IPbjBvHJdHUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjB9EAAoJECTWi3JdVIfQxt8H+QFdAj/+TyH/1KlE9WkHGYEK
s83rDdR0R4n53CsKHMHixuF+9iDD3plUqy2Vq7PnRkxYh8T/WY7z28Zo4Ch74W7n
DGRpDue1Ggr8k5TwjuE7g1bblBlTEDXhnhKsCns+cwsA/0JE4MiapF4FAPKzpQvp
IM4dlyNcEPnSXkexN6yLBcRVYf0RaaULnsxdC5SXNuVx6R7hp+1nBI6TglvDdd+m
seKrAAk69s3uIb+k34EJL0NCsC7hXC5e0fE35qShRCXOANRd6POo4RN9Kg2KkDVX
w5n9yfwGAc1D+vRlCIw1Ec+ydyINW8/P7pd8vhBD3AdpgS4uPA6tKg0jJMDrRPM=
=Ep0B
-----END PGP SIGNATURE-----

--KMy4IPbjBvHJdHUq--
