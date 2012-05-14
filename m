From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Mon, 14 May 2012 13:11:28 +0100
Message-ID: <20120514121127.GR31985@opensource.wolfsonmicro.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
	<20120511130816.GB3960@opensource.wolfsonmicro.com>
	<4FAD33D3.3050104@ti.com>
	<20120511203425.GB29835@opensource.wolfsonmicro.com>
	<4FB0EEAC.6060204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657289781152041515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B4101040B5
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 14:11:31 +0200 (CEST)
In-Reply-To: <4FB0EEAC.6060204@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0657289781152041515==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="562f9N4fbIs+fPrJ"
Content-Disposition: inline


--562f9N4fbIs+fPrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2012 at 02:38:20PM +0300, Peter Ujfalusi wrote:

> The child (or drivers for the functionality) only needs small update for
> compatible_of, and new chip access wrapper.

At the very least anything that's using interrupts through the device
core will also need to know how those have been wired out into the chip
top level, and of course if anything happened to move about in the
register map or there are any changes in available functionality (which
would be unsurprising, perhaps an additional line output or something
for example) those will also need to be dealt with.

Besides, if that's all the function drivers need to look at they can
just look at their parent node instead of looking at the child node,
problem sorted.

> You might be right that the resulting dts section for the chip is just
> represents the current MD stack, but if I want to prepare for the future
> this is the way I think is the best for us.

Again, if I could see how this supported non-trivial reuse I'd be right
with you but I'm just not seeing how this would allow reuse on another
chip without rework of all existing device trees or what it hides about
the chip top level.  The code changes to drop the child nodes from the
device tree should be trivial.  This in itself seems to me like a clear
sign that the abstraction in the device tree isn't actually providing
useful generalisation of the chip.

I'm just not seeing anything in the device tree that abstracts the chip
top level from the function drivers; if there were then it'd be very
much easier to see a general use for this.

--562f9N4fbIs+fPrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsPZMAAoJEBus8iNuMP3dOBMP/j2mtOSOwgKhpO21TdiUc+G+
FoOLxGYPrkwnQkdYZHvn21Tqq/YcFcv8AyBGuRHnNCXb0/FYaI1R3NE2XLR07qMS
r0fSD0DMAJbAjKnKcC24RwQpZ7fMNic7zFT4iowHAChjdfIDR73HFCIu9j/kgdur
QzwJfgVdEbfnffZN6N6ingb4JIhgKVH3NHKtIvnnBuRgzT0PRzInyGJ8gf5jN3Ui
42OC9CcYOs6xCLdA5TbvtPLbUvA6NASC7Z4GgGmv95v48dr1mm60yCbsvQ6x8ftN
Mnoh9DC/6FWvhvn5wkiWbriNBXy4Bqgx85PqbWyj3WjtR3KLRrBGK3n+Uealuj9r
GQOBGbmhQckVvMbgGXc/Mljqdns75GKYvK5fugOcGeHfpwjEpuUsWX1NS52HvYLE
FAkwWe+J4dF2l5AAbsoN2/V7zHoYK1gHOFXI6u85TqZTdIGMVccrVIRgtPEpR9+R
ryTiWGtfSxUPBEjzQ+QtFRljRU4rYBkaUDFFT6cXswZDHpSMvty3eB1BuAt+EtR8
+zw8ajO5SJUrqE5VlZ7pGVBPuZfoakpzvu/JIjhtJxSS5aVBXQU3wsNCKSnxPjSs
b93PUbNeEPbxh+RzIkcuY5azknc7cUfT2L/mywa0+5bWR/N6jg2eMtueOH4hE/Xw
yVMDoUIz13YOWSffdxxG
=hZwn
-----END PGP SIGNATURE-----

--562f9N4fbIs+fPrJ--

--===============0657289781152041515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0657289781152041515==--
