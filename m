From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: kirkwood: extend the kirkwood pcm/dma
 driver for DT usage
Date: Tue, 23 Jul 2013 14:29:48 +0100
Message-ID: <20130723132948.GF9858@sirena.org.uk>
References: <20130723104641.6ee0b9ec@armhf>
 <20130723125756.GZ9858@sirena.org.uk>
 <20130723132314.GU24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3015126909963079066=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 174F8264FEE
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:29:52 +0200 (CEST)
In-Reply-To: <20130723132314.GU24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3015126909963079066==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OjlPywxCsLltMP9x"
Content-Disposition: inline


--OjlPywxCsLltMP9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 02:23:14PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 23, 2013 at 01:57:56PM +0100, Mark Brown wrote:

> > This device has no registers or other hardware - this looks like a stub
> > device which shouldn't be visible in DT but should instead be created by
> > the I2S driver - look at how most of the other DT platforms using
> > dmaengine work.

> There is no separate DMA engine on this platform.  dmaengine is totally
> irrelevant to this hardware.

The pattern for instantiating a DMA controller that's integrated into
the DAI is the same as that where the DMA controller is a shared IP
accessed via dmaengine so it's still useful to look at these platforms
to see how to do the instnatiation.

--OjlPywxCsLltMP9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7oVJAAoJELSic+t+oim9M40QAIpBsTnzY1l5HGweNibKYxph
iXzOXZvvKqWTHGN4+Nel1c7zlQIGV8xgxOCpvx/OVXDAUbcVzfA6Jj6cFvg6RQ1U
vomeUH5X7dnGKJRy9YEQjUEnAyFSE75MJDi2KcV7BcN6yXYKJ1H+OHbSMy+gOxJz
Ius7RVI9zL7J+M/3dqbiT7Gr+qVCrKCnHUQmQRbHfDdDc4rD12tcQDljZMlUGQlV
BEtLxkxhr4ST8Mq4PjcMbfF4Aqb4uXrR8sooai0ckmcPy14/VY3rKDabDTgWcGX7
8FREXHxkERgdzaFayUk8x2Mf+hUO4DnGsqyFBJ69lqJYd9+K7Qqlbj3IwYLaDrJE
X0xB7zAD+DrVCSFwdFftMRPy4bvXBEXwDcSy3EZeG/o2nInWVmXG6MPauzQ15nBD
7uJ45h8ZoVs8P4ZdR5le+R+kInAV8j7OTgvi2H7sEJjZwwls7LDxx62HOWOfeZSo
FcmpN65VuSjRzgR70sZ3H5/ErSQXhzk34Yzy4wv2JxPD7K7UUTScURIhCVQsiiXr
rlc6Vt02hgKLTmRymPaviWtqX4HF+Ujee6TNp5ZgREaqhYMSWWrVAjn/pDyM0Vuv
FxP1oeEbFH5Dm08VTcEfBawkaJxyoGH/GOgUGH4HLy+iYU9wYKVSsJ5m53zcXScn
QJOHoeqYb6zTy9mR9E0E
=dC3z
-----END PGP SIGNATURE-----

--OjlPywxCsLltMP9x--

--===============3015126909963079066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3015126909963079066==--
