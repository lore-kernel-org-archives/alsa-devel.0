From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: reduce standby power
	consumption
Date: Mon, 28 Mar 2016 20:05:44 +0100
Message-ID: <20160328190544.GD2350@sirena.org.uk>
References: <1458619025-28306-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6454652095316614641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8094D26066B
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:45:58 +0200 (CEST)
In-Reply-To: <1458619025-28306-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6454652095316614641==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2016 at 11:57:05AM +0800, John Hsu wrote:

> @@ -1116,6 +1116,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>  		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
>  			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
>  		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
> +		/* MCLK not changed by clock tree */
> +		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
> +			NAU8825_CLK_MCLK_SRC_MASK, 0);

I'm going to apply this since I suspect there are already similar
assumptions in the code but it does look like the issues Ben raised with
one of your other patches with confusing sysclk management and overall
device power might apply here.  We can't rely on people changing the
clock configuration in lower power modes.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+YCHAAoJECTWi3JdVIfQtwgH/37zDwy2RHz7TjPEN8QNCNxl
LGBLWseie+h6dHN9LPmuR0M18W5hxa3Tfpv+UdqrKCTh8CZ2qPBTYyALI9mICIas
yjJPjBXCNzxaNTyanc4yuAWaodl4sKycOYfvttL4pnYiwv4pC0Qcbc6iPyyFPgBf
ex2cb2iojV2GVRcGldYKPRpyoAogmk/R+1qxPTh5n9nwz39sfD36v+vs9kNP27zK
R8nwhi+lJwFX9+ccL3RA5iSrNuxa1uQzEV8aFmznBy3p8g6+9aW6CwggqpY2kzAO
V36BaHdcjJ0ggHC/Iar+ogOZen7M4fmGJCbZ39/2OQYt3nEV/k8LOfXOVWiAc3k=
=Lago
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--

--===============6454652095316614641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6454652095316614641==--
