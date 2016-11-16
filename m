From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 01/14] SoundWire: Add SoundWire bus driver documentation
Date: Wed, 16 Nov 2016 17:59:29 +0000
Message-ID: <20161116175929.kf7lfkcnqjdhasjk@sirena.org.uk>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-2-git-send-email-hardik.t.shah@intel.com>
 <20161114141548.GL1575@localhost.localdomain>
 <20161115142914.GN3000@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgw7jizuamgbgtoi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115142914.GN3000@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--dgw7jizuamgbgtoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2016 at 07:59:14PM +0530, Vinod Koul wrote:
> On Mon, Nov 14, 2016 at 02:15:48PM +0000, Charles Keepax wrote:

> > slaves register to that. This also has the nice property that its
> > easy to create devices that sit behind other buses, for example
> > here we might want a SoundWire master that sits behind a SPI bus.
> > But you seem to have gone in the other direction and have the
> > master sitting on the same bus as the slaves.

> Since the controller on our SoC was enumerable, people went with this
> approach. In this hindsight that may not have been the best choice.

Doing buses properly isn't an obstacle to doing enumeration, indeed I'd
expect it to make it a lot easier - just have your driver for your
controller do the enumeration at probe time.

--dgw7jizuamgbgtoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLJ6AAAoJECTWi3JdVIfQ2VMH+QE9m6hKCzVw4UWGR7O40Zm9
R5r5VdB3nSLv2z5rhNlp/yuy0JLWR94lJ1vDWIZLbXClQ1IFq2U9LYiuDwvK4GCH
51fcyFBlifKuhepeBEhlOlra02Dph4nf52XqL8nBbb2QdObfe/SMG/EJZWgt6/Wc
w0kj3/gZAbDTaWnycGr/ewQGMjN4xnFDu7H83QQPDR+xYFdj8jM6xv4PSZCVW2uc
zC6Qlq8BXrk1EboOaEu146gzH2MlMWte6Cev+ZwKG2uYoNpLaZ9ZbnRfEpowmYbO
AJ5ZEpXedxBnP1kboQkiIQ/Ki39BccRyOYXTYyIjBiRWc2MGOVHn3cthiIEWYk0=
=ayun
-----END PGP SIGNATURE-----

--dgw7jizuamgbgtoi--
