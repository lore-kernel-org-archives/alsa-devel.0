From: Mark Brown <broonie@kernel.org>
Subject: Re: Can we re-use dw-hdmi-ahb-audio ?
Date: Mon, 18 Apr 2016 20:01:00 +0100
Message-ID: <20160418190100.GM3217@sirena.org.uk>
References: <87inzkv9z4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tuifNR376H9qoyoc"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87inzkv9z4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tuifNR376H9qoyoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2016 at 09:08:24AM +0000, Kuninori Morimoto wrote:

> I know we already have dw-hdmi-ahb-audio.c which is based on
> normal ALSA style, but I would like to use it as ASoC.
> I'm thinking that we can separate this existing dw-hdmi-ahb-audio driver
> into "common parts" and ahb "specific parts", and share common parts with ASoC,
> like below, but what do you think ?

> dw-hdmi-audio.c		: dw-hdmi audio common function set
> dw-hdmi-ahb-audio.c	: dw-hdmi audio for ahb,  using dw-hdmi-audio.c
> dw-hdmi-soc-audio.c	: dw-hdmi audio for ASoC, using dw-hdmi-audio.c

Something similar has been done for other things like the PXA drivers in
the past.  It might get tricky to work out how to instantiate things
though.

--tuifNR376H9qoyoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFS7rAAoJECTWi3JdVIfQ1qkH/i/DALbvB0WBgI81/yu//tgz
VBIiNkqM5EBvmNDHw7rx6I3JQIy1FHO4ZUKCSMslXu4wUE/l6cgWN4AVqC3V6//F
auF/T6vscyIvQQiqdEskAgmOBkHxtDGcRq5qwqbSo2pdOvQIPYC3dGAoZtI91fnL
YvW/99jxQhMYtpgQwXrdRgW0n9oA0xQoYvroEUdp1jqwzMm74qyJUzBBfdtPSqPS
8ScYFeAISRC49h8X28AEK8FJBh3+LHrEiyJ4l4bozalEbIbOf9kCjbjGKbY4Y/vk
8fTbb2bZHbUOyPloEMIM9zzD4oSMYHKib5KFMbRnw8dRv5IXpq3TnAmDki0ZmSo=
=1+ZL
-----END PGP SIGNATURE-----

--tuifNR376H9qoyoc--
