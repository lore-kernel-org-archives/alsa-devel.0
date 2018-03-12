From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: dma driver changes for BT
 I2S controller instance
Date: Mon, 12 Mar 2018 11:25:37 -0700
Message-ID: <20180312182537.GO2186@sirena.org.uk>
References: <1520836460-21809-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1520836460-21809-2-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1615718785222397510=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 60AC8266E63
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 19:25:41 +0100 (CET)
In-Reply-To: <1520836460-21809-2-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============1615718785222397510==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="da9oBGf5DLtF9ehv"
Content-Disposition: inline


--da9oBGf5DLtF9ehv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2018 at 12:04:14PM +0530, Vijendar Mukunda wrote:

> +		 * It has fixed mapping as mentioned below.
> +		 * designware-i2s.1.auto cpu dai will be used for I2S SP Instance playback device.
> +		 * designware-i2s.2.auto cpu dai will be used for I2S SP Instance capture device.
> +		 * designware-i2s.3.auto cpu dai will be used for I2S BT Instance playback/capture device.

I'm still not thrilled about this.  If we're hard coding names they
should be explicitly assigned names so that there's less chance that
some other change in the subsystem will change things.

Please make some effort to keep the code within 80 columns too.

--da9oBGf5DLtF9ehv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmxiAACgkQJNaLcl1U
h9Dh7wf9EyH1bBB++XkE2PBN+B7FC1Jv0s9K28NycW9/4ZrVGpIui7jMaBtrauFz
0vA4Y2YQgYHvy7KB5mwqtpuzmU0BCSkkiFKYYwqdKU3xMSE1GbkgUOfov3XM9tHx
EPu3UJKQ7BUOuEqkRuKEEl5pKcuP8IFPWl/J2tjGe5QdnrdkOeqxiFbiufg3/cJg
9UgibHyQqfMxXdyaqamm6A0G+iZVNfuoGBpx20sgqNjOJJ1/WmvgrzxjNLzY7Yyl
UvvKGxWYsCNlSnh9FYAFSOUF4UucIomobRMJe/8110pDWrriw4xRLXk8KAFwfWcE
2CYYvJ0pwuq0Nzkx1Ak7TlWLQy5WLw==
=g/9Q
-----END PGP SIGNATURE-----

--da9oBGf5DLtF9ehv--

--===============1615718785222397510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1615718785222397510==--
