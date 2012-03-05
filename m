From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] ASoC: Add dmaengine PCM helper functions
Date: Mon, 5 Mar 2012 12:41:41 +0000
Message-ID: <20120305124141.GJ3224@opensource.wolfsonmicro.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-5-git-send-email-lars@metafoo.de>
	<20120302135959.GG3230@opensource.wolfsonmicro.com>
	<4F54B1F2.70508@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1641035188006550525=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF3BC244DA
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:41:44 +0100 (CET)
In-Reply-To: <4F54B1F2.70508@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mika Westerberg <mika.westerberg@iki.fi>, alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1641035188006550525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Content-Disposition: inline


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2012 at 01:30:42PM +0100, Lars-Peter Clausen wrote:
> On 03/02/2012 02:59 PM, Mark Brown wrote:

> > Please resend the ep93xx conversion along with the tweak to the core so
> > we can get that working.=20

> I was at trade show for the rest of last week, without much time for
> anything else. I will submit the missing patches in a moment.

No problem, I figured it was something like that and didn't see any
reason not to get the changes into 3.4 - it's a substantial win all
round and the fixes are pretty minior.

> > It would also be good to update FSI to use this library as it's also
> > using dmaengine (the patch having been merged just before this one it
> > got missed in the updates I expect).

> I've had a look at the FSI dmaengine driver and it is not straight forward
> to convert. For one it does not use cyclic dma transfers so it is more
> something for Russel's patch and on the other hand the FSI PCM driver
> introduces another layer of indirection which is used to be able to switch
> between PIO and DMA. But as a result the functions the dmaengine PCM
> framework provides don't really fit anymore.

OK, fair enough.

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVLRmAAoJEBus8iNuMP3dk6QP/1FJ6IG1e01Ps0Qyj7rcgkU9
s87/X/G3ryr0pvdqjvWHGyYCAByBAqMWWeKkVXhgk5h1qt6G/aLBf1kKiwb7LHib
ushJZgHE7k+ixU2GJClUGfRjEZKe1jT9T9Z8kjgI0w4F41NYFdhkBAxEVqbonl3A
cyfhgC5s31chplzVb24TEWt0SHB1rg08v2ypTyyZsbsfIa5FVWs358EssOSS+pX3
L2dg5h4QUYMd6rPALu1mBY/KQr+xkbCJ5qS/A9JFG/9G1/myepc8d09JNdGtasxt
m2vkDPG0LVn3g6TimH0n4OrD+HIQJyiADhWUiYFZndLec5olcq9uz8sUuYKdT7Rs
YMxeZVmwKc7m5jEinf4FIjWzRy+Hg5E5drQ/DMFi0e0YOgH9SmhKAwtPrA/lKTez
lAK0J3z57KgLLpBLFILStdIG0aUBUuiDEcmeiCzGz7CRP8Ob5k6ELAAtuQWQHwmL
H6Mbsg/yogunz6Sy0LpTcnpj0kWqIcQ8P5ZB9tNKt7k8bhh6hkli4crTXrgEYmqQ
bpG4y/XVPlyiPfz45Uk9Sx4ezzC9jmaIVZoxidz0WqPWZB6vvjc+Km0KZyFkNOfu
rpTS1m3AqonoZ0XoWKz/79uzWeTG3HkZdNRHp1avS17ITdiVqTpxYZHG7aSBznL2
OwnmFfS1jORMN2ioqvTI
=1aTv
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--

--===============1641035188006550525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1641035188006550525==--
