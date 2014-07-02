From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Wed, 2 Jul 2014 20:42:52 +0100
Message-ID: <20140702194252.GN410@sirena.org.uk>
References: <20140702183841.7c964832@armhf>
 <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QGBKWVSgmlsIyJ+t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140702195154.47d6f6b4@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--QGBKWVSgmlsIyJ+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 02, 2014 at 07:51:54PM +0200, Jean-Francois Moine wrote:

> I tested this CODEC with both DAPM and DPCM. If the audio subsystem
> asks for streaming on both I2S and S/PDIF, only the last call is served
> (this depends on the order of the DAI links in the audio card creation
> table).

I'd expect this to return an error for the busy DAI rather than just
silently ignore it failing to start or (better) implement some control
to let the user select which of the DAIs is active.

--QGBKWVSgmlsIyJ+t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtGC5AAoJELSic+t+oim9tb0QAJt+FzWAKa03Dm0MUFuXQ2DN
no9KhfaolUNuxddftKE0sacoTgbDZNBMmNQ0HcIc8IbdDOPHscw4VplNB8Iie1JK
aatHjwpQ98DWVlFAv7PZDp3dhOc/1TkUTwQCJkw6XuUMiodexdDEUn+aGw9Rn2Lu
pSBZXr3lQ/GnHj/P2L2wqBeuMXB+6jokh6mzi6djQrjCtu0/BeznrOmWEVtagUMM
nqa0lM+0ek1c4oznGvs9qhSBsBNTUt7YQGns6VMsVTqgnE2/ukIaezM2wbuMUH3n
unhGNok+CO07nJeFj/TAoHBPZhFsyIQdFJJVFu7q/TdP3dPFGc0yquQt8fuTavZM
PN9daXR1sUBUHO0LEiKrei0Q7E7tlWTLbIudHFLTduuIkJiry15xDE5XmXvDdH5U
kdpWpJDBaaocK/c3WGgCQ5/BKuvmUfsfRozCWU5a+PcZ0V2kcMAgi7zWCJte25Uf
bWlgGLQnh2qMLBKypIAoNMakEx5RThZEOqebJoRH4oOuPirXMiGn2GbvBF+uqa5W
gP4vw787P/WbJsEq8PTJnNSw0Sk+sQ+q9l2OpJkuxv4gVsFLjNN2Igi77I8XtpQ+
5HknLAsmKqvMXQRUfAxeTog+y5jFtBrQ4wMxQm6Gbzr9Unq1hXWO83kwcNeGzno/
aHO3BAG3Q9pHezd5dkyx
=0sKu
-----END PGP SIGNATURE-----

--QGBKWVSgmlsIyJ+t--
