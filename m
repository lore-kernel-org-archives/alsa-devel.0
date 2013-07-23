From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 13:34:44 +0100
Message-ID: <20130723123444.GW9858@sirena.org.uk>
References: <20130723104615.3696f1a9@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6363902104921371270=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FDB262626
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:34:50 +0200 (CEST)
In-Reply-To: <20130723104615.3696f1a9@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============6363902104921371270==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+hGRuEBnBrDfOHI9"
Content-Disposition: inline


--+hGRuEBnBrDfOHI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 10:46:15AM +0200, Jean-Francois Moine wrote:

> +	np = pdev->dev.of_node;
> +	if (np) {
> +		struct of_phandle_args clkspec;
> +
> +		priv->burst = 128;			/* might be 32 or 128 */

The comment says this needs to be variable (depending on what?) but it's
hard coded.

> +		priv->clk = of_clk_get(np, 0);	/* internal clock */
> +		err = of_parse_phandle_with_args(np,
> +					"clocks", "#clock-cells", 1,
> +					&clkspec);

As others have pointed out if you need to change the clock get code
there's something wrong here, DT should be handled transparently by the
clock API.

--+hGRuEBnBrDfOHI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7nhhAAoJELSic+t+oim92m0P/AtxA5KzgTvL2JcRGSatCCch
RGRuSa2aJ9Hr7priDpX2DM9tmyFCorGq3lNYuPorq949aR1au/i05cFXdKgF9qgB
Csz8aNTXZHg+isoQs1K+8fzew761s629mydAfJrEqXhu8uOHXDPwjEZ8r/OHZjLB
9SBcQLw1E35m4xCEwDNoYuCboatKf5oL9Zdje3KZv3j5YyX/7pEeWlXEaE7etlGb
gL7eQ+GMqgMYX2RKU2fx95piusn6kSs1kITs0jg4BMutPfNIxcVeaW0P9P08tHlc
gTVTvvLhJkl3XrcUk3GcnV0c9DLH38GmDYUhFn08RBa6V4Uie8wxrOQXbVYgNQS7
jIZa+vGo6VoD8kCkf5C60kBorS49kZXe4lNlKv5dKyXeN+Y5BbiERBgHcRtN+5s2
tdEax1pm3Q6pQ5tGdzRY+WAZ24tvnDs2LvowPYvtx2iqvwT2vf7/Hq3RDPfBW9FE
eDoIB2BM1XeZBQG+E7ZPCR+WY/F0UtpXKoPacHzLqBTx5vhM/aIPb/HTwYfK/ILL
xMjhpoaQMNV6AD7DRbrjmnoC+KmNR4IcjGASkpiVqhNGbkkKLFIh7KErPWwNpihT
vwbFpQhhBkVyUAS4HmrYHe1pGMSMYmLndD3hwDjnYQBI2cOPI3NWvWvTsi2uzKJj
MinYAGpE6Wl9xtsWYC54
=n8yr
-----END PGP SIGNATURE-----

--+hGRuEBnBrDfOHI9--

--===============6363902104921371270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6363902104921371270==--
