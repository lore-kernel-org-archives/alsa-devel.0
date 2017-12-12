From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: sun8i: a83t: Add I2C device nodes and
 pinmux settings
Date: Tue, 12 Dec 2017 09:32:02 +0100
Message-ID: <20171212083202.3ivypgnv77bncz4a@flea.lan>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-4-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="djt56wq4zuvaltzd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212081148.9194-4-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--djt56wq4zuvaltzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2017 at 04:11:47PM +0800, Chen-Yu Tsai wrote:
> +		i2c0: i2c@1c2ac00 {
> +			compatible =3D "allwinner,sun6i-a31-i2c";

Same remark than for Mylene's patch here, you should have a per-SoC
compatible first.

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--djt56wq4zuvaltzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlovk/4ACgkQ0rTAlCFN
r3SuwQ/9HMs5ndmdkc7kFEH5K+vYoMadaZUr8yPd2nj2BGVmsYZmaA0eCRR2/l5y
eLgY16c909u+EnPMDy8D/a9sFCtoNk0L/siAmtTiJO0wdRxtQibwBpkOp3yBX6ay
6m3z3QEkffOcxMBXLHAkbbgxEQa83I6J/1B9UR9wJshVW3+z12N50aOG1oge15pd
JCrEToMnwxk0gT+1OFPQkr/e2AFZ/c8bWzz1Ra9smpK1qIT008TlI33XoN2aKSan
27fniDnzL8u2tHZDA+N3X9M9t0vDpoF+l2wYMRq5oCLzvVETEviHdfWGYFAR8r7r
lOdvw99nYMcmrMhrcKKx26DGpFLHuBOO80aH2tR0xGKcyJ6uapSxjyzZwQON5nvM
VB1934M+veLDODTLH0dM64vKWwlefEN0ZMeoQzITpR67aH680oxKyGWLn3Rngf+5
BeL/jzR+dfao2PZ/vwiETBMkGDqsS83KAh6Z+mAgplt64EWEorC/NAYL0a/ij6j6
eU71Ut/SnMWpOvJxeFhAHIm350GP9FZVzvUJeHFWQtX52Br1P34Zp36Sn5Wyj/mX
RB925TcEh/AIUNA3edmM91wDlpC9HP4Fg/AiOWPg/+MEo9TVJ8bh0e/3vBl5iQVc
pmnNPDh7kxtkjZHGvXMVtiLTU0L6xH6k5Ig0kIFvg4PtZCOzpZg=
=ytJO
-----END PGP SIGNATURE-----

--djt56wq4zuvaltzd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
