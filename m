From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tegra: Add platform driver for
	rt5677 audio codec
Date: Fri, 26 Dec 2014 16:38:26 +0000
Message-ID: <20141226163826.GD17800@sirena.org.uk>
References: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1203379499492760443=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F30260423
 for <alsa-devel@alsa-project.org>; Fri, 26 Dec 2014 17:38:51 +0100 (CET)
In-Reply-To: <1419362942-26192-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, bardliao@realtek.com, ldahan@nvidia.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org


--===============1203379499492760443==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XmBYJ+PaUOdJeGy2"
Content-Disposition: inline


--XmBYJ+PaUOdJeGy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2014 at 11:29:01AM -0800, Anatol Pomozov wrote:

> +static int tegra_rt5677_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct snd_soc_card *card = &snd_soc_tegra_rt5677;
> +	struct tegra_rt5677 *machine;
> +	int ret;
> +
> +#if defined(CONFIG_MODULES) && defined(MODULE)
> +	request_module("snd_soc_tegra30_i2s");
> +#endif

What's this all about then?

--XmBYJ+PaUOdJeGy2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUnY79AAoJECTWi3JdVIfQ3AoH/iOPsqoBIsNNPKcCUwwkFsBt
+lL7koB+jicEEPHgKxFNhpCS19DCkrEv72sDnL54G0Irz2dhZYtv8zSe3qAzst5h
c5l+6FAuL6aJBgMOh5b8uKu6jICcDwEfGKWsYcnrARc0oWMO0UxMi3U3Q20/GqJc
EM9XObNo/EfjDxyo3ITaIAeqC9NSURWqkuPlfw3SalP6nXoMkI6E2onmtFvNZN4L
e1BrdTgd1FHwb/5K069wlyy71Sm+9/jZLD5jBur+2yPOVFP1rpcrKYg0HmBEo7pk
7XIYZV+gQwEAzdl/qVxac/6gsIwLgeHSKPwYxFk9RrEodJsMVi4xptjjzagnk1w=
=kz/n
-----END PGP SIGNATURE-----

--XmBYJ+PaUOdJeGy2--

--===============1203379499492760443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1203379499492760443==--
