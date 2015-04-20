From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tas571x: Add DT binding document
Date: Mon, 20 Apr 2015 23:03:38 +0100
Message-ID: <20150420220338.GZ14892@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <20150418111622.GD26185@sirena.org.uk>
 <CAJzqFtYBvNAgwROZ09MGanYOyyF0EXEL7W9ZF4eAhprQVquNcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3Rhqlz/9+3FgEet"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtYBvNAgwROZ09MGanYOyyF0EXEL7W9ZF4eAhprQVquNcQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--t3Rhqlz/9+3FgEet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 02:18:56PM -0700, Kevin Cernekee wrote:
> On Sat, Apr 18, 2015 at 4:16 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Apr 15, 2015 at 02:42:19PM -0700, Kevin Cernekee wrote:

> >> +- VDD-supply: regulator phandle for the AVDD/DVDD/HP_VDD supply

> > This is clearly not correct - if there are three separate physical
> > supplies there should be three separate regulators requested.  They may
> > all resolve to one physical regulator on the board you are working with
> > but that might not be true on other boards.

> In the "simplified diagram," TI shows a single AVDD/DVDD/HP_VDD supply:

> http://www.ti.com/lit/ds/symlink/tas5717.pdf#2

> Page 20 also suggests the use of a single 3.3V supply for AVDD/DVDD/HP_VDD.

> But this combines a number of separate pins.  On 5711 we have
> dedicated pins for:

> PVDD_A
> PVDD_B
> PVDD_C
> PVDD_D
> AVDD
> DVDD

Yes, those are three separate supplies that are typically tied together
- it looks like PVDD has high current draw so is tied through multiple
pins.  I'd not be surprised to see systems with AVDD tied to a separate
pin, analogue supplies often benefit from low noise supplies separate to
digital ones.  Indeed if you look at the pin descriptions the analogue
and digital supplies even have separate grounds.

> I didn't see anything in the datasheet suggesting it is OK to have
> different voltages or power states on the various supply pins (other
> than the special voltage on PVDD).

That's more likely to go wrong if they're not controlled separately than
if they are since we will only be able to turn a single supply on or
off..

> I can add as many regulator entries as appropriate.  What do you recommend?

Have the driver accurately reflect the hardware, request one regulator
per supply.

--t3Rhqlz/9+3FgEet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXe5AAoJECTWi3JdVIfQJgEH/3XwKBmnmaNw54q05rOQXXjv
Oce9mCa1X+oRlxKMEVog9KkeumKCEiq2PSsKBk/exNYdG+/NZzK95X3HAJ+IYe6m
AjYpQeU9L3n0mn7iJxilOIaHD+9Psp+yubK7imMg00FHHQoHQyKcTOamtHd1x9B6
uzriV9YlyNTGh3qWR6+FYHZEpyqJsTSLpi9VeZ9yjM0zm5G4GXKrmiCnDRdBVEIN
LVwwRqIleFceqkw8yThh/5C58hyQoB0dlvOYp70jX0JXvt3Lyoqe7G+hUzapb1Bz
tAyLF46gMJhhR464IiJd/k13nNZ1KXivdbRQV1rCxqwPspRxpKfp1D9XBAgP0Ho=
=b85K
-----END PGP SIGNATURE-----

--t3Rhqlz/9+3FgEet--
