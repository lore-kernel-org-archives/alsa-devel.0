From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 1/7] ASoC: dt-bindings: add regulator
 property to simple amplifier
Date: Mon, 26 Nov 2018 14:53:42 +0000
Message-ID: <20181126145342.GE9715@sirena.org.uk>
References: <20181121051752.18387-1-anarsoul@gmail.com>
 <20181121051752.18387-2-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3126214752291789202=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB1926751A
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 15:53:46 +0100 (CET)
In-Reply-To: <20181121051752.18387-2-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============3126214752291789202==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 09:17:46PM -0800, Vasily Khoruzhick wrote:

> +Optional properties:
> +- VCC-supply   : power supply for the device, as covered
> +                 in Documentation/devicetree/bindings/regulator/regulator.txt
> +

As ever supplies shouldn't be marked as optional unless they can be
missing even though they can safely be omitted on Linux.  This one's a
bit odd in that the name is going to depend on which amp is connected
but still it's probably best that we do that for consistency.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8CPUACgkQJNaLcl1U
h9CSnQf/ei8XI3hU6rX3a1kvgmThJ2WU1W/wq5DxE3Kp9FNn6A5Fy/4vycHKekXU
z4BgLsGYz0c/6jsbXiHpv0FbkcbJNlRS+zOfAlwIGRSdSBIySF/KVZPE8ArQRqKG
/aaP4XWbuu0uFxioBnmv88h9xVl8turpeeHcRtfffeLeIKMeXRS6fBu1Dd7N0TL1
iHyJGqhPylmwmrZ/6nXsWTlQDhn1Wv9tCdpff8ctpLOgFu47GNsPxR3fcsFQDOxw
l1zjAmP8AfykE553WWLlStl/iimIXMbrGb38cnoDDfHspDcIvhArKvjto5fnDp4s
W36SLi7mrVQJDOBOxOJv1KFalM+ruA==
=YGSA
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--

--===============3126214752291789202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3126214752291789202==--
