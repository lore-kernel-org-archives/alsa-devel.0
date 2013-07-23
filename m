From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: kirkwood: extend the kirkwood pcm/dma driver for DT
 usage
Date: Tue, 23 Jul 2013 13:57:56 +0100
Message-ID: <20130723125756.GZ9858@sirena.org.uk>
References: <20130723104641.6ee0b9ec@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B5JjOzmn0Nsc+m1x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130723104641.6ee0b9ec@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree-discuss@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--B5JjOzmn0Nsc+m1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 10:46:41AM +0200, Jean-Francois Moine wrote:

> +- compatible: "marvell,mvebu-pcm-audio"
> +
> +Example:
> +
> +pcm: pcm {
> +	compatible = "marvell,mvebu-pcm-audio";
> +};

This device has no registers or other hardware - this looks like a stub
device which shouldn't be visible in DT but should instead be created by
the I2S driver - look at how most of the other DT platforms using
dmaengine work.

--B5JjOzmn0Nsc+m1x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7n3RAAoJELSic+t+oim9dNUP/3IjP2kD7nXYhF3Q+lf0c6yP
s82/82I90Meg63GFu5XbnLEDrWxzkRC0OivNLNuQ3sOZ4U1szve8bA2mqtNMPY8K
CHVTV8U73mf1YrbeDr1MvfR7VqzQ5gBwCejOweX+7ufJ/0n9wibVyJziPohqGAU8
Y6JNHakNpeK3QxjikMwoysl0WnkES6qRumMmq4Z+S+dgn91Th9WKU6ioBZY49Lzv
W2gJ9HHMB2IKxkBd/KxFCSxqZfZepLOFPCJZ46uSzeL7Z8tBY7kf1nsmZWZcKeWY
QE00jpFl7Ccn0bhYMg+Cli6oJzQ5b32aWvTCSpU07AsmDXqLZDDRvJJMCcSvwkd6
21/mAyDJGNaNNULaYK6rm9XdAqzV2K6w0AFsyCl3VM7TQuVancA74+JoIcyBk5DC
UWoDS4Oi4Ya4Cjudp/wBvV+HgjNWlbvn40NcoOa+2gjPLp++d4SP3APmeHMMUi3/
w2OXJxgL9mmOrfeCfG6B+1Ab7xuCH+0y+KG+MALpqQrbZqqGP81fPzzNsN8gB3I6
YqXunumiH/9GhKttzlDpT282dMm63abv1VNF1qH/bvL+VPYZrDFOIt9uOdXp3Cav
bPF6Ey6JOEG/iNItBKuYkz41tMsay2aBn0c0eJRtEcG1n0y7PtL3Q6cD/OjIqCPG
qA/4F9rH7LpxqJuUXmKZ
=EhT2
-----END PGP SIGNATURE-----

--B5JjOzmn0Nsc+m1x--
