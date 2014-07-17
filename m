From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Disable AIF TX/RX before configuring it
Date: Thu, 17 Jul 2014 20:42:15 +0100
Message-ID: <20140717194215.GH17528@sirena.org.uk>
References: <20140716121029.GA22222@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U/fatWn3w9i48dtV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140716121029.GA22222@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: perex@perex.cz, tiwai@suse.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--U/fatWn3w9i48dtV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 01:10:39PM +0100, Richard Fitzgerald wrote:

> If we don't disable the AIF TX/RX then we may fall into a
> situation where the new AIF settings are ignored by the device.
> For example, this problem manifests when switching between
> different sample rates.

So, what this does is momentarily disable the AIF when reconfiguring.
That will glitch any running audio, making me wonder if the driver
shouldn't be returning an error or at least complaining if it has to
reconfigure instead.  What's the use case where this might get
triggered?

--U/fatWn3w9i48dtV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyCcUAAoJELSic+t+oim9hiwQAJizNsa+8f4DamujnlTjXFA7
rrC2kPZz0ICCV/qmok3MWo0uRC4oVZabUDQ7Q9FKpWDyr4if7OzCYPGJuBM07CMg
qNYq/+5WQ1dI5Er6CPrVAaZ9n4icdgfqAqLAFZLnOWACasiw2f3LD/w0ROhMyZ20
mgrmUst3OBiiJ2PJ7i4gzZIu+fOXlKeJd2Du4SIOpqrenrfhra5YJxsXap/F/NT6
+tf1N0AmyEo7363X3FUVFYpi+nFyhKBRwqr0JLn8cbjCCFTcCyfrS29VNnx7VFDC
/ljgUW4eQRT5ShTE356soYn+VqkEEZfdOzyxSbwZIo1suK6bXCN6xpI/bZIsmE/k
GdGM1SvwPsS4f2d5WRHDMn+kFe7dqt7Ss60VatALNxxMTdIZJYIo7Js7i6vVYWdp
leihBTFRR0otf60T9zzxgcrAORe0OVPbucHqfVkY3h5lFcJIM4aBQ5lYuL6/gZDa
rFwK8FHdrdB94RF3B/n3hqAcAGVW4/BAUTM7c4aWJzOyOMha6ABo70f1FLwMEnls
6LN33sk6vuiONKmMPnDYQy4RBXj2cZTUfCxUeORXwcao6zr/7s8HNF7PX45+FIrd
PPwtv3YGI2AZpol5U+fsiwYmqwg778bWRyKfbKX6/iosWNUXmpZIGE1rcAcN9rl/
XSMNL7bSUxNmznqiZ09o
=lu0+
-----END PGP SIGNATURE-----

--U/fatWn3w9i48dtV--
