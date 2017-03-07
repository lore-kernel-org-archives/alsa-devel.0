From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: dio2125: add dio2125 amp driver
Date: Tue, 7 Mar 2017 13:36:53 +0100
Message-ID: <20170307123653.jg7jqe4sft2pqycc@sirena.org.uk>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <20170306174451.24406-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5631692076765131265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B9F1266AE4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:37:01 +0100 (CET)
In-Reply-To: <20170306174451.24406-3-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5631692076765131265==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3zht5fsd6afpsqth"
Content-Disposition: inline


--3zht5fsd6afpsqth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 06, 2017 at 06:44:50PM +0100, Jerome Brunet wrote:

> +	gpiod_set_value(priv->gpiod_enable, val);

You should use gpiod_set_value_cansleep() so that the driver can work
with all GPIOs unless there's a specific need to have GPIOs you can
control in interrupt (which should be the case for anything you're using
for DAPM control).

Please submit an incremental patch fixing this.

--3zht5fsd6afpsqth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli+qWQACgkQJNaLcl1U
h9CnXwf/QaBOS0M8G9dC7mC3HvfJkfX+GTk4G3UmPM3r3DCDqWa7rGp7EVPhauEY
1aObtb14lRtXkkeSpwUz2YdWutqCaUiuXMUG6GH8f/vgksuVEB7E9hWqDshEHS1L
+orTapscEMicncx700BdQ3KTS1CWBgPd24wgTjWH6bb+GJQscZvmDkWtzvCWhDme
TS1W3dE50pPQapvprTNOqreJHsT5njeU85FA2zuzyt9JDqV4rbe92C4TYE1os/b3
3ipTkX/LqgPF2K3rL3wAaG7YC77xWEBFWdy3T+ZwvVZcscZzvpgbqx6YCEMJf11w
e+7hiQZ2mYFL6QxQlnVsjJBKJi7bYg==
=o9ai
-----END PGP SIGNATURE-----

--3zht5fsd6afpsqth--

--===============5631692076765131265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5631692076765131265==--
