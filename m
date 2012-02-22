From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Wed, 22 Feb 2012 15:04:56 +0000
Message-ID: <20120222150455.GO7340@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120222132107.GD7340@opensource.wolfsonmicro.com>
	<20120222133207.GD22562@n2100.arm.linux.org.uk>
	<20120222133939.GK7340@opensource.wolfsonmicro.com>
	<20120222142236.GF22562@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0276607714529392007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46F10104091
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 16:04:58 +0100 (CET)
In-Reply-To: <20120222142236.GF22562@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0276607714529392007==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xn9xNsWbHJd/50IB"
Content-Disposition: inline


--xn9xNsWbHJd/50IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 02:22:36PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 22, 2012 at 01:39:39PM +0000, Mark Brown wrote:

> > Well, Vinod seemed to also think that dmaengine ought to be able to cope
> > with emulating this and I really don't see why it shouldn't be.  It does
> > know the capabilities of the underlying driver and it gets to look at
> > all the calls going into the driver before the driver does.  If ASoC can
> > interpose itself I don't see why dmaengine can't.

> Have you ever looked at the DMA engine drivers?  It's a total mess.

Not in enormous detail, no.

> Even something as basic as the DMA engine driver assigning a cookie to
> the descriptor is implemented in each driver in their own unique way.

> Completion of DMA descriptors is a similar thing - every driver implements
> this in their own unique way.

> The only really common thing in the DMA engine drivers is that they all
> share the same API.  Nothing much more than that is shared.

Plus they're going through a common vtable and accessors which is the
main thing here I expect.

> So, there's no way in hell that I want to see any more stuff pushed down
> into the DMA engine drivers until we have a proper DMA engine library in
> place to stop all this idiotic code duplication throughout every driver.
> Especially if it means everyone will be implementing their own cyclic
> emulation in their individual drivers.

I've not seen any suggestion from anyone that that's a good idea.

> So, there's a lot more here that DMA engine stuff needs to get fixed than
> just a simple "layer on top".

Well, if we can't do it with a layer in the dmaengine code then I don't
see how we could do it in ASoC either, presumably the issues that block
doing it in the dmaengine core code would also cause issues doing it in
ASoC?

I'm not saying there's nothing that needs fixing in the dmaengine code,
and like I say I'm not too worried about carrying things in ASoC if the
dmaengine code is intractably difficult, but I'm not sure that the
issues you're rasing aren't orthogonal to the issues with emulating
cyclic transfers.

--xn9xNsWbHJd/50IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRQQRAAoJEBus8iNuMP3dTw8P/3KDQbiqeEwhAGkqaRmojYUv
nVxzFobPN2Ncuq+4R47ud8uBcadGC+bhrdHmRcNj7hRyS7nQp3SVk5WUnMBtvkxq
x7oPlhnSOdth/bs641UHwGmpWeSlE3XPupUvKnAEMd/Y6MhqftGMsLDSss7n3NMK
UNTJ5XPQ1qnNBLqZ7RSTF27Oe0ljoC5sLTisYmNMmhEgghAzIB48e0DIyHl69bBG
IHeJxDYWcsEkkiuOoxcLuEyyOGoFSpFQBj+Fz7rhlhLsVCXA/1U6F07eAtXa5WSr
tgMGbMPiMZ0qNJMpDZ9GdW/cMYNNi2kLSvgMnFScVS/fPn8/o4z6OcCrCX1Gyw0y
n2MGEuQJl5tZAg3rSoleYw65baTAg2CK8BvTZfnlabKMwOCChALWDdrGAFQsuvWi
Q1m9G5DRmOnf+kHrLPUR6he2KMWyWfIOWCv2+3EZO5nbP5wlt/kgNcWAuW2Mjsda
jsJ0p4aQKcYInoC6a/9juccEJcUwX9JUNWDRNJ8sQn+EmRQUw8kG0K/XZluFxm+4
+Fv7AuMy9SQe9Tnixz7cVkyWYd4wMpt706cZCgTrOhBef3CIk3r5xPrbFgawCjPp
osvCMqY4tdYX70F7ADk8IzQDGCQWWahz50E938OTgshBKUE3GCCQWtrTSii3NkqT
zOXvIR3g/+L5XFMr4+jo
=8teR
-----END PGP SIGNATURE-----

--xn9xNsWbHJd/50IB--

--===============0276607714529392007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0276607714529392007==--
