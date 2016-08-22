From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC PATCH] mfd: arizona: Add gating of external
 MCLKn clocks
Date: Mon, 22 Aug 2016 18:41:04 +0100
Message-ID: <20160822174104.GT22076@sirena.org.uk>
References: <1471627036-19465-1-git-send-email-s.nawrocki@samsung.com>
 <20160822092233.GN21682@localhost.localdomain>
 <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BfbbJsf3thGkpLcA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d47e7106-037f-b40c-71e5-099ee30874e6@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--BfbbJsf3thGkpLcA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2016 at 07:22:47PM +0200, Sylwester Nawrocki wrote:

> I got suggestion from Mark not to request the main MCLK clock
> in the machine driver.  But even if gating of that clock was
> added to the CODEC driver I would need to get hold of it in
> the machine driver to get rate of MCLK.  So I thought about
> exporting a helper from the MFD for requesting MCLK clock or
> specifying MCLK clock back in the sound DT node.

No, the immediate suggestion is more about the requesting bit than the
management bit - once the DT is there it's set in stone.

> If we provided an interface like:

> struct clk * arizona_get_mclk(struct arizona *arizona, int id);
> void arizona_put_mclk(struct clk *clk);

> the machine driver would need to get hold of struct arizona*,
> which is not that straightforward if we are given on CODEC
> of_node (it can be a child of I2S or SPI bus).

We could add an interface for the machine driver to retrieve a clock
=66rom the CODEC as a transition measure...

> Then how about specifying MCLK in the sound node and using
> regular devm_clk_get()?

This is what we're trying to avoid?

--BfbbJsf3thGkpLcA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXuzkuAAoJECTWi3JdVIfQ+ogH/RkINbYh1MMX/6ZsDUXWVPwp
c7FHVNpWGHqzmO/o461fi+vuM6aaPlhCOH6z9e3I7c2HsUUB5jEGSLZeGnzv2KD5
isdYSgW2R4PKm5TOiOtG+2gDRzgEm7rOIC3mpjTmtcq+F1k2a3zBvkel1is+kjZ5
pmiqwvTRj9HIxJwjSiE9uIig+3cLoMbWHJa/98lZpJckH6KCy//B38DiM8PrJKAf
u9s65aMxBqWFK9UPhHX/Wd3VyvhnBAodZVqmhF2L+xIrxM1/OjVC8PCA0h1GAhxn
9K28tJho+HJu/2vZ48ATz0K4m9IQyxE/WieaC/luRzf36wmMsLgRuMNqtXagNpI=
=hw3q
-----END PGP SIGNATURE-----

--BfbbJsf3thGkpLcA--
