From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: fix dependencies for wm8962
Date: Tue, 30 Sep 2014 17:45:10 +0100
Message-ID: <20140930164510.GF4273@sirena.org.uk>
References: <1950588.ErdGoiHh8p@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2482896558706019088=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1950588.ErdGoiHh8p@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2482896558706019088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
> The wm8962 driver uses the input subsystem, but is selected by
> SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
> resulting in this link error:

That select shouldn't be there in the first place, I asked Nicolin to
fix this when I applied the driver but he's not got round to it yet.

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKt4VAAoJECTWi3JdVIfQa3wH/0G+vRIB9pO6vlrs8/1XlkAy
AXmuhWvma5TR/qDxrgYbxirYRynG3JxM/zLcy+QiUzFgi0/7O9Y3IsI69cdrGbZe
7H5CcEEvwUnGIAMTxRfxRONj1+b6+u9HGF5cc2DMfIT60wnQFh4FxzrIk+gwV85D
vxgp4K+k9k0+8uzRNjFLlIWntIWR8KcV0PTM97Ta6AXwm07WK1r4uqtR+wOa3vfI
/Y5ldE+HPQBEkFppcWUEWDjvaBawT1Eo5GJ9TuGBMPcunM2huYh2dRNYU7JZUMVK
+qMgRy6Tf81QkIskeDJLQlUfiHYFdhmLUNM4f3Vhm8vDkMLrUjJ9M1RElxN7/Yk=
=0qwj
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--


--===============2482896558706019088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2482896558706019088==--
