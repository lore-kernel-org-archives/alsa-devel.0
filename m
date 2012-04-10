From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tegra: convert to regmap
Date: Tue, 10 Apr 2012 23:04:47 +0100
Message-ID: <20120410220447.GW7499@opensource.wolfsonmicro.com>
References: <1334085365-11189-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0419375492535732330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D826103D92
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 00:04:50 +0200 (CEST)
In-Reply-To: <1334085365-11189-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0419375492535732330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XQSDX3NWE02rtiZq"
Content-Disposition: inline


--XQSDX3NWE02rtiZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 01:16:05PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> For the Tegra I2S, SPDIF, and DAS drivers
>=20
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Mark, this depends on the regmap->ASoC git pull request that I just sent.

=2E..which would've been much better placed here so they don't get
misplaced.

>  sound/soc/tegra/Kconfig         |    1 +
>  sound/soc/tegra/tegra20_das.c   |   99 ++++++++--------------
>  sound/soc/tegra/tegra20_das.h   |    3 +-
>  sound/soc/tegra/tegra20_i2s.c   |  149 ++++++++++++++++-----------------
>  sound/soc/tegra/tegra20_i2s.h   |    3 +-
>  sound/soc/tegra/tegra20_spdif.c |  177 ++++++++++++++++++++-------------=
------
>  sound/soc/tegra/tegra20_spdif.h |    3 +-

It would have have been useful to split this into three smaller patches,
the I2S and S/PDIF changes look good but there's one funny in the DAS
driver.

> +#define LAST_REG(name) \
> +	(TEGRA20_DAS_##name + \
> +		(TEGRA20_DAS_##name##_STRIDE * TEGRA20_DAS_##name##_COUNT) - 4)

> +#define REG_IN_ARRAY(reg, name) \
> +	((reg >=3D TEGRA20_DAS_##name) && \
> +	 (reg <=3D LAST_REG(name) && \
> +	 (!((reg - TEGRA20_DAS_##name) % TEGRA20_DAS_##name##_STRIDE))))

> +static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
>  {
> +	if (REG_IN_ARRAY(reg, DAP_CTRL_SEL) ||
> +	    REG_IN_ARRAY(reg, DAC_INPUT_DATA_CLK_SEL))
> +		return true;

This seems a little too obscure for what's normally a very simple
function.  REG_IN_ARRAY() in particular seems odd, what's the array in
question and why do we need to do anything more than a simple mod to
check if the register is correctly aligned?  Some comments seem to be in
order at least, or just expanding REG_IN_ARRAY - there's only two uses.

--XQSDX3NWE02rtiZq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhK54AAoJEBus8iNuMP3dzSkP/2RSMwlM5vZmsfhevicyBWNn
IEk72yXrRWxWw4uh1TfMo8WS+WH17w4KtK1A8QvT2VahYMgxSIx9CmyUIbeT1q9T
5//9flb4Hi2sV4xDNXR+svTXxykiGLYFgnaKmosjNscaaSJP9HyVBuW08vfjZvac
QQOpfYbVwWR8h5Q8kfDhCItg4jG4U61qgI4ytHLzmMtVom9nglQ7Sm5r/saA5FYU
ymjl7gNMl2tLKvzY3u+IwP8tSv8hD6sSm6bE0NUvrF1egkzcKE7iz6RDD57N6sKS
zLdFT5Pq0IXzLNpr01HUM05iOYkRdLuS1AKp2l44B4oZ4SQdhwUUVJeGHeET6WcV
4lpiZr9J3GSATOLF48Gx2zQ9xRq7qoYA4fD7fPnTka6Irz+Ax07fkA+DIJMxQ2hF
4px6a6rjEyJM/qmguIq5PScmyLwTFPx2IwU1Fy1N1E1D6qGuLeGkR8p5dkjsn330
IGyilXkIP52bG+NcrRHVqroA5O05GyVMaU1BwseUWWoPZOR55Fj7aSJ0Ustzb/0V
wR0zrHXBcWOhJMzUUVWx0wzZsT6vHZPvawFNxeeJ1scfJwqy2Qij2ZfQNCMUFGQ5
lvHaVLdnHbE3vwQDLMznucb6eDtxjYi8g3pzhFkexC8Zz9md04xwneP1bW++5yTG
IL+OykDKQEayoDTV55sc
=PE5b
-----END PGP SIGNATURE-----

--XQSDX3NWE02rtiZq--

--===============0419375492535732330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0419375492535732330==--
