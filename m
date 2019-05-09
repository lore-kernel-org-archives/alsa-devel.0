From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: request GPIO when device
	get probed
Date: Thu, 9 May 2019 11:33:36 +0900
Message-ID: <20190509023336.GU14916@sirena.org.uk>
References: <20190508162223.75322-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1773904902100778053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CAB2F89674
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 04:33:42 +0200 (CEST)
In-Reply-To: <20190508162223.75322-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, dgreid@google.com, tiwai@suse.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org


--===============1773904902100778053==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="InWnmNMQ0pNZrrCy"
Content-Disposition: inline


--InWnmNMQ0pNZrrCy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 12:22:23AM +0800, Tzung-Bi Shih wrote:

>  static int max98357a_component_probe(struct snd_soc_component *component)
>  {
> -	struct gpio_desc *sdmode;
> -
> -	sdmode =3D devm_gpiod_get_optional(component->dev, "sdmode", GPIOD_OUT_=
LOW);
> -	if (IS_ERR(sdmode))
> -		return PTR_ERR(sdmode);
> -
> -	snd_soc_component_set_drvdata(component, sdmode);
> -
>  	return 0;
>  }
> =20

This function is now empty so can just be removed entirely.  Otherwise
this looks good.

--InWnmNMQ0pNZrrCy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzTkX8ACgkQJNaLcl1U
h9DVJgf9GTiFrwdkccDRNoaxGziPUqbdzWANJ1sQ2MzOCWL9SHFm61yVSTmVfbaS
NGyrM10kC8EJA/KorEgW81EmIaARLRFkBHdzZQ2tckGyLE+wbiEgzAnw2+ZdeQRS
BnE5AMNy1kJjCtQhknVv634Jd/T1SorWC6qOplcmmD+xVsomfhJDha4p4FT80q6M
Z5Bes1DZx5XiThcJnEAuN48kbcnnIVEjv6TDvjT5Pg67I+BhgmqLs5pDR6Wd8JjS
Pl3w7xRTjdeObpH8eQGiV9EVWV27tdwHQ1T6BShBGoiUaGZaMjVNuEstIlhvTLDw
IuynYxZtPHz/EU6GR0cLLFiHiccQLg==
=25px
-----END PGP SIGNATURE-----

--InWnmNMQ0pNZrrCy--

--===============1773904902100778053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1773904902100778053==--
