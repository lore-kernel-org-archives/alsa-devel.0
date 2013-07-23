From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 14:20:16 +0100
Message-ID: <20130723132016.GC9858@sirena.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6078538415879207188=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFB0262626
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:20:19 +0200 (CEST)
In-Reply-To: <51EE7E1A.3040301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree-discuss@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============6078538415879207188==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BxgRixwWt/z/BIGD"
Content-Disposition: inline


--BxgRixwWt/z/BIGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 02:59:06PM +0200, Sebastian Hesselbarth wrote:
> On 07/23/13 14:34, Mark Brown wrote:

> >As others have pointed out if you need to change the clock get code
> >there's something wrong here, DT should be handled transparently by the
> >clock API.

> IMHO the reason why of_clk_get() was/is mis-used in that way is mostly
> compatibility with legacy platform_data based setup.

I'm sorry, but this doesn't make a great deal of sense to me.  Can you
be more specific?

> As Sascha Hauer pointed out, clocks should be distinguished by names
> (clock-names property) instead of position and then use
> devm_clk_get(&pdev->dev, "internal") and
> devm_clk_get(&pdev->dev, "external") respectively.

> This will possibly also require to update platform_data and legacy
> users of kirkwood-i2s or have different setup functions for non-DT
> and DT.

Why would this be required?  The driver is already asking for multiple
clocks...

> Also, while ASoC API separates the audio-controller into cpu-side
> and codec-side parts, the DT should not. IIRC and as Russell repeated

You mean DAI and DMA here?  I already commented on that in my review of
the DMA binding.

> again, we mentioned to merge kirkwood-i2s.c and kirkwood-dma.c into
> a single file, didn't we?

That's been discussed several times but nobody's actually done it.

--BxgRixwWt/z/BIGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7oMNAAoJELSic+t+oim9APoP/jtvgM6DgcSjt1Sa1Pzs0zom
170jTSoL2kN1rzFWC1LE1tU/yIQ8FLyNTFuJ8vqfd/b8fG+9+RTGdjEVo+ZfIOPV
hm0Z9X8InDzWDUFuu9kpLCOUiLcbp0zm4725FAjuny0VpHOYsGefo1FJrzHwiF+3
Gq6VBRoUEXHmvSjFIWXlmUGT432kNVj7p0D0JCxLH+7xXED3qQ5AzLhvBgvA5PuT
dMPTYHA844S43ygOOXgsDcFiSoEPWhuhdunAqtndHK9Sw+hgpqYKE/TPboelXh2y
GmO1Hm3IwjkBQyEIGT+VC3xIg6UDzUii8WAP/CFk14vOtwVvj1mUX76dzoGqp4uL
KJNu/YWXaGPIiHfoLjxPBZ3nQ2X9inQCv6zipz7j+TTHUGQ0auG/w/obugpYi0Ds
+Ztds7XIWW20vQrs01PEl5+0pcGelkuAjzyV/9wvA0MIHq3olM8Y2uoksXpP0FB2
5pRKhCZNhBN1ZnPpzVSJPk90bWIK/F1rwxUDKjZBaS01T041w+8/REJqwbCZp83Q
WTZErvWeWC4BHoYBj51kRQxakIeJEsnefxm4I6N5rmcag/u4kY2EE1GdysfaaZBZ
BglqvhXZGMwxG83ywGpCeTqxs1UAfrjPBHq0putr+TG4oQLZImvvx+neUl+Ey95K
jrW71zFKLLP51cCKmHvV
=eadq
-----END PGP SIGNATURE-----

--BxgRixwWt/z/BIGD--

--===============6078538415879207188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6078538415879207188==--
