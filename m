From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Thu, 8 May 2014 09:00:25 +0100
Message-ID: <20140508080025.GA12304@sirena.org.uk>
References: <536B2C9D.9040807@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0897383107383320895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0B4D2654BE
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 10:00:43 +0200 (CEST)
In-Reply-To: <536B2C9D.9040807@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============0897383107383320895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Vu7+jDAWS5Mpjaz"
Content-Disposition: inline


--7Vu7+jDAWS5Mpjaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 09:05:01AM +0200, Lars-Peter Clausen wrote:
> On 05/07/2014 09:49 PM, Mark Brown wrote:

> >My first thought would be to extend those so we have callbacks when
> >required, to be honest I'd forgotten they weren't there already.

> But that's just the normal ..._EXT() controls with custom put/get handlers.

Hrm, yes.  That's the issue - I have never really differentiated between
virtual and external enums here, the external controls are (as far as
DAPM is concerned) also virtual.  To be honest I'd forgotten that there
were external controls in DAPM, there's only one user.

> >Right, to me that's not actually a register map at all since it's
> >missing so many of the assumptions that back up register maps.

> Well there is a register map, there is just no linear address space. It's
> more hierarchical, but you can still map that hierarchical addressing scheme
> to a linear one. I think what best describes HDA is object oriented RPC. You

The non-linear addressing isn't the worst bit, I'd say the worst bit is
that the read and write formats for the data aren't consistent with each
other.  That's really the fundamental assumption here.

> have your objects, called nodes, each node has a unique identifier, called
> the node ID (NID). Then you have functions, called verbs, each verb has a
> specific ID. A node can support a certain set of verbs. And each verb has a
> verb specific payload, which is the functions signature. Most of the verbs
> are some kind of read/write register functions.

Yes, it makes sense as RPC (and hence as external controls as I have
been suggesting).

> So the address of the register in which the amplifier gain is stored is the
> NID + It's a amplifier you want to access + whether it's a input or output
> amplifier + whether it's left or right amplifier + amplifier index. You can
> map that onto a linear address space and in the regmap read/write callback
> do the mapping to the appropriate verb payload layout.

It is of course always going to be possible to map any set of settings
onto a register map, the question is if it accomplishes anything to do
so.  Once you're talking about having a mapping function like that
which understands the contents of all the registers it sounds like the
contortions to fit into a register map are more effort than is being
saved and doing nothing for comprehensibility.

> >>the same data). In a sense this is similar to devices which have registers
> >>with different sizes, we also support these with custom regmap callbacks.

> >But those are only breaking that one assumption so they fit into the
> >idea of a register map much more readily - it's really only the physical
> >I/O code that actually notices anything, all the cache and other
> >operations can carry on uninterrupted.

> This is one of the reasons why I suggest using regmap. You probably still
> want caching, you probably still be able to sync the register cache, etc. If
> you don't use regmap you'd have to implement this on your own.

So how does HDA handle this?  We can obviously keep recording settings
in the same way as we do for virtual enums, writing them out shouldn't
be so hard.   The cache code isn't going to buy us much if we have to
write things out control by control anyway, it essentially just boils
down to a fancy list walk.

If you really want to reuse regmap having a write only regmap internal
to the driver (not presented to ASoC) which just remembers the last
value written to every NID/VID combination might work and at least
avoids the ugly bits with trying to convince ASoC there are registers
since you don't need to worry about reading the data back and can just
pretend that read values match written values since we never look at
them except to write them back out.

--7Vu7+jDAWS5Mpjaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTazmWAAoJELSic+t+oim9eWwP/1nRsxtTpJ+4LnfKDNpCBEew
NQeyHqwjMZPh7tXcT4GbLpo06qdXuoTEskR557J6UV4btO6yb9SNEnYjJnTrFwOM
EHecazLsNFkgAckifnVeNfqBuaazTbNWKOmBaTjfpop9rZSKoEVJKUtYXs/RUwfR
ZxZEw76+S4e59ZFjuP3BJtUYf5vJkZ1GSciJhuIV5uiAoTCmBtL5wZ9dl4aphvkf
k68x6o1pjEulNpzFhuGheRjrrA4T5x69W/vU1reXlu5fdAYRyeIptQB1sePcSq90
AJDtpOWVPDTdhQZn0sQLYg8M76RRvVq3FLaCeDXc4CFHqly5kKLr2GFNrhl5KAQD
0SfT5CEcN1FQeoiTRhybxPsp5SWjLpeWxRXsRxaaE6GF5FcRwS6IgsJ8icuwSgKX
kkVnGQipmuu33hcHDIUC7/AbUghFwTWh9KdmM5jpHiGon0JgxaMRGXBTrcx5EO6i
S4wnhUDsR4pcqkbhi/daSBcdFwuuIc04KyUBI8iOPpxho66h550LuJX7SBjWmoZx
LdqL2+EsUXRLrfSBMwfcJjRDyeR98rVQVYAGHlnFWvRuUyvqVqO+acaldwqgOs00
8K0vE0wsWMYUt9whpHVAKnBlVwQSToljcxIKnBKylc3RzTIEiBPn0dFNJfZ2YprP
TAxpjDONI8Sw8KEennMb
=8/Ux
-----END PGP SIGNATURE-----

--7Vu7+jDAWS5Mpjaz--

--===============0897383107383320895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897383107383320895==--
