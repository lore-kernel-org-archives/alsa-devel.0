From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: tas6424: Add support for the
	standby pin
Date: Mon, 23 Apr 2018 16:35:53 +0100
Message-ID: <20180423153553.GI19834@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-3-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510961045112970897=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9435C266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 17:36:33 +0200 (CEST)
In-Reply-To: <1524218684-19752-3-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0510961045112970897==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline


--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:04:43PM +0200, Jean-Jacques Hiblot wrote:

> +	- standby-gpio: GPIO used to shut the TAS6424 down.

All GPIO property names are supposed to be called -gpios regardless of
if there can ever be more than one GPIO (though the framework does
support the singular, I wonder if it's not more helpful to just get the
spec relaxed here).

> +		dev_info(dev, "failed to get standvby GPIO: %ld\n",

Typo.

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd/VkACgkQJNaLcl1U
h9DvMQf/WlAalw9VVpnJyOR7ezVpFT7BAS/zA4+NemWVT8DS0Juwk3kD/1mFjnFJ
RuJECYe1tPHFv8a2/6rqMrD48zBfXG/YcGpKm0SF05ZA9/f1r8UTNdDJMiM4IHvh
rfCJLGBraGX8TOuEZ2j8mmGBj7ToV3MXQ2Zq1tANd7mZKZ+WH+3nhl37IP7tu0t8
V6qEGKK8Aklh6+fk/zWXwrnVtIJzFqXGUx7GZepahm558nSilomVSJ/+nTN0N8iH
6RsGMJpDtfyf68fL5amN3z+ZHu9/FYCVIKICFoFRHxMqK5U3cc3ucSrCyOHGTNew
rdfB+RVfHbNwCQq8QNeAQU/QYwuN2Q==
=yJSP
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--

--===============0510961045112970897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0510961045112970897==--
