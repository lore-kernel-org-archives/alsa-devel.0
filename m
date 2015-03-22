From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:pcm512x: Make PLL lock output selectable via device
 tree.
Date: Sun, 22 Mar 2015 16:24:09 +0000
Message-ID: <20150322162409.GG6643@sirena.org.uk>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Howard Mitchell <hm@hmbedded.co.uk>
Cc: peda@axentia.se, tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 09:22:43PM +0000, Howard Mitchell wrote:

> +	if (pcm512x->pll_lock) {

> +                if (of_property_read_u32(np, "pll-lock", &val) >= 0) {
> +                        if (val > 6) {
> +                                dev_err(dev, "Invalid pll-lock\n");
> +                                ret = -EINVAL;
> +                                goto err_clk;
> +                        }
> +                        pcm512x->pll_lock = val;
> +                }

This breaks existing boards which rely on GPIO 4 being set as the lock
output.  This is very unfortunate since it's a silly thing for the
driver to default to but nontheless we should really continue to support
them - at a guess Peter's board is relying on this, and even if it isn't
someone else's might.

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDuyoAAoJECTWi3JdVIfQdgYH/i3lcuCGgadJbS33VOnhHEz2
MRrbFWtyfoQdu+NbR5qcd/i2qcP1JXpsKkCXKjWKuirX2wvQVvltJMkkVoIRVOmP
W888YowRDECARUSfzIJ+5C27SVFvDDn/u+tuovfDQMScHJYfLDWnKKGOJt3yCsmG
hOhs5lre87cJkV3llc1cuKGhTEfVP1SzfjlPLRUQuCsja/kYDk6CrbBfb2xk2QmM
BU2drcKdMeIIqvy5if1/F6tPz/cEp14GpuHxN4eVDahMU6rSaoj65zwkAnGIkSe0
dC2xVSp+Gc6gtwjv7cVciTHuoShws/0EzlhqfthhdM6zYVwmEEqAP0jUVAp2DPI=
=nseg
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
