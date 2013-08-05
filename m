From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 00/13] Adding SPDIF support to
 kirkwood-i2s
Date: Mon, 5 Aug 2013 16:03:09 +0100
Message-ID: <20130805150309.GM9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <51FECB7A.6010208@gmail.com> <20130805115947.GA9858@sirena.org.uk>
 <51FFA348.2010503@gmail.com> <51FFB267.3030107@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6018556900844301716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AFE0265020
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 17:03:14 +0200 (CEST)
In-Reply-To: <51FFB267.3030107@metafoo.de>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6018556900844301716==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VAqhKxW7H0hfWX4"
Content-Disposition: inline


--4VAqhKxW7H0hfWX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 04:10:47PM +0200, Lars-Peter Clausen wrote:

> In my opinion having different bindings for each board is not a good idea.
> Having a common set of property names will allow us to factor out the
> parsing to the ASoC core instead of doing this by hand for each board driver.

Yeah, that's the idea - right now there's blanks that need filling in by
the machine drivers so we do have them but once those get dealt with the
compatible strings can just be moved over into a generic binding.

--4VAqhKxW7H0hfWX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/76qAAoJELSic+t+oim9fQEP/j515o08FqlhMh3LvYsyFpr5
AtozILb2/9rrm82kT4bTJE4lCCF1VBQeTKjhecVERzm8W5oe2Qu6H0g1NnF4zJUP
71a3LH2pT3ks4hEfKPRYnKmh5Bed/5faSm3m0xeozOgVY1Yviae6rhneKZSLsDaV
T2dZFIf0ZS6AO+VRv67ui55T3PfwwaCZwPjRaMtButZENzyEYBdxeJSqu5fksUsj
qXQfnnfK3vySvdWA6wJMj7l2uN7PkTa5H9/UWwyBNdPitQwx7/1tb2YT5PfyrvaR
DM1JCd4wAHUJI6PPguXKkIi2WBzduw5rJ4Bryo/GHYX2WHM3en1Ps/fiTvFopGGO
0eJgKa1n0WdkcBTgWM9pxbFj+FocUKEdvyMlyi76lo6Mo8ggr+lDeaNloe9h2gna
4tpbA97r/9DuYt6/nIY4zkO3v6U3Hy4FsUrhqurjNttYFlOhFrQzZFotoExrk481
ouiCmGRfFgGTLIR7BuKpH1VNNN1oHWdzeASSftKDUvFDu2o+Y0Sbpe9loGHxXuvh
hZhYrlLgHs7nm4Nd1dvagygsJ1IwwNc4vrme0AfAUks4eNYX5AXU2Zg6XNud032z
e/X/9dAgixNlUdtQzMKUHLVsCA6s0dpHbsh+cNvncBG/WI42NGNKmSREyBQ580Sq
WTK+Fy3HUruFxucMBlXb
=P8Ey
-----END PGP SIGNATURE-----

--4VAqhKxW7H0hfWX4--

--===============6018556900844301716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6018556900844301716==--
