From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Fri, 11 May 2012 21:34:26 +0100
Message-ID: <20120511203425.GB29835@opensource.wolfsonmicro.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
	<20120511130816.GB3960@opensource.wolfsonmicro.com>
	<4FAD33D3.3050104@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8386821220796326483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 703111047AF
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 22:34:29 +0200 (CEST)
In-Reply-To: <4FAD33D3.3050104@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8386821220796326483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2012 at 05:44:19PM +0200, Cousson, Benoit wrote:
> On 5/11/2012 3:08 PM, Mark Brown wrote:

> >This binding doesn't do anything to move towards that goal given that
> >the only information it includes about the contents of the chip is the
> >name.

> But it does not have to expose everything. And what will be your
> definition of everything in that case?

A useful binding that abstracted things sufficiently to allow multiple
devices would be one which contained some information about the contents
of the chip.

> >Writing the name out in separate CODEC and vibra nodes really
> >isn't going to accomplish much to promote reuse that can't trivially be
> >achieved by parsing the name in the MFD driver.

> Maybe, but... so what? This is not because you can do it with MFD
> that you cannot make it more flexible with DT.

The issue is the tastefulness.  Just looking at the binding it's
immediately clear that the only thing that the extra levels of
indirection are adding is the removal of the mfd_add_cells() call from
the MFD driver which isn't particularly helping anything and is
basically Linux specific.

> Preferring to hard code that in MFD is similar to keeping all the
> static C board files we are all trying to remove. It is possible,
> sure, but there are now better way to describe HW modules than
> hard-coding that in a C file.

Sure, but this binding doesn't do anything like that.  If it said things
like "there's a PDM speaker driver with register map X at address Y"
then you'd have a block you could easily pick up and reuse when defining
another device but it doesn't do that at all.

> Moreover, there is not an unique way to describe the HW. So for sure
> we will cheat a little bit and make some assumption about what the
> SW will really use. But otherwise you will end up putting the full
> RTL inside the DT node.

This isn't a "cheat a little bit" type thing - it's really not talking
about blocks that are likely to reappear elsewhere in exactly the same
form on a device that's different enough that you'd be able to add some
useful reuse via the device tree.

With CODECs the IP blocks you see are generally things like audio
interfaces, mixers, PLLs, amplifiers and so on.  New devices that are
meaningfully different to software will generally be some new
combination of that sort of stuff rather than a straight clone of the
chip top level which is what this binding is talking about.

> It is very similar to the discussion we had for the clock tree. For
> sure we can describe the full clock tree in DT, but that's huge and
> useless. So we are taking some assumption and expose only the ones
> that have to be exposed because dependent of the board or needed by
> the devices.

The difference I'm seeing here is that the split in the device tree here
is at such that it's the equivalent of having a single device tree node
for the entire clock tree of a given OMAP model - it's just completely
redundant, it's not adding any additional information beyond the top
level information about which chip this is.

> It is up to the driver owner to assess the level of information he'd
> like to expose to DT based on the number of chip variants that
> already exist.

This code handles exactly one chip and looking at it it's *extremely*
hard to see it as a useful abstraction for multiple chips.  There's also
the fact that with things like this where the chip has to be hooked up
to other pieces of the system it makes much more of a difference than it
might otherwise since it's much more externally visible.  In this
particular case for example we might want to split the clocking out
differently as the generic clock API comes along, and there's extcon
too.  All of which should be entirely Linux internal things.

> Both formats are valid.
> It is just a matter of flexibility / personal choice / mood of the day.

> The important point is that this is not a black or white kind of
> decision, we can be in the grey area and use a little bit of both
> approach.

If I could see how this would allow reuse I'd probably agree with you
but I really can't - it's immediately obvious looking at what's there
that all that's happening is that a bit of the Linux internals that's
not particularly great as a generic abstraction dropped straight into
the device tree.

Plus there's the fact that from both a device tree and a code point of
view it's utterly trivial to not land ourselves with this in the device
tree, it's just registering two devices and using a different of_node
for reading properties in code and removing a layer of indentation in
the DT.

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrXfKAAoJEBus8iNuMP3dWkwP/0TVzYti23mrKbb/SXLI4JE8
z5cCd1aNzr71cGNbZM7MjjePoOCFDlvSl8Y08smfmQutaEjvWzursfhRu6djawpT
Tztd0CZzON5x/Z+3nFRkvmkg9eNfUatHN78LvviY0wXDlManjqs/MEpcnqiX4YJX
y0cjJbUIL6peATpAOMlsdzjYBTS+9CduHovTTE+F23HGsxYEnHk8Yla9Ud2J4nAY
5vXvn6aLnElupdKs+4mqGBZBO7VGcsCRyOf2cZd4mxiv9A4oQ8A/64VX/TDSz1qr
5lulMH/U09QKBWgqaG/AgY4kH1wTZ8gbDwmGbXy+QHpOZsXWhE827F650mXx3MPd
RiLlvJmw1kuz+vj/YLrJeCUqizX0lx2T1rA9lLUHX0kCkEFY30Ug1/lzGpnr1dVi
BE556ipry9XnUkRowHzU9OnFuNQNM2JrUr35XVJJeJVCmzUGT/FbcLrTpr4uCaAw
H8ODSSokjlmPYUEpzMXvDHu1eDEMk69qudYQHgdy6yu5vXqw8Zg9EKTtc7ZIyksJ
YEKDMolNZdBXfvn4nGuFGijjT6AF6jTNSpiiyklEEM+nvR7yLX9AAK73CmkOsFyz
34PpAVz0oynXeRPEiXIl4PE28k3eYbpe+S2poIuDs4UGztunjnaXS5S24KI0kNRu
vO+O0G/eMfWEl/oKA4Lz
=jLZ4
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--

--===============8386821220796326483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8386821220796326483==--
