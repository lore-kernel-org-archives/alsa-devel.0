From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: tpa6130a2: Use devm_* APIs
Date: Mon, 10 Dec 2012 00:17:53 +0900
Message-ID: <20121209151752.GE6511@opensource.wolfsonmicro.com>
References: <1354878146-28222-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7721827001085349869=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26FF626262D
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 16:17:59 +0100 (CET)
In-Reply-To: <1354878146-28222-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, tiwai@suse.de, Peter Ujfalusi <peter.ujfalusi@ti.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7721827001085349869==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 07, 2012 at 04:32:26PM +0530, Sachin Kamat wrote:
> Converted to use devm_gpio_request and devm_regulator_get APIs.
> These are device managed and make error handling and cleanup
> a bit simpler.

Applied, thanks.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQxKuYAAoJELSic+t+oim9UnEP/i9KAySOupNlv8lEnwJ9Bn87
uTsDHQfYUHAFyQS/E4xODg0crSFt8i0N6gUqHx3ARhFZxUiN/eMZvNzZ4iOi+ezi
qh/gY17dTlz5egPPUzv7qgK7ld0cCetqKxiX1ww8io9Gr/c3Pz2502GD1n4J7Wbb
tR2+ShKapnUUxIvyKBguLG6Qq+UTuOYPHn9HwLpFszByk7giC7u0E1JiWhgLL/Il
cq5RffZG0/MKZFaWB6OX/WYMJrULnKLDj5aCyfxwA5WeLBccSTaVpbrpaU3/ZCXt
4G6XnVGN8QBPGIymaANi1zhHhh8A3aUBK1Oa+M/5gWD9hlTv5gRKeVDHAys9Ym5f
1uqZKU6aSemPR0FtyOfVfU8QCxWY1z+N4+kymmB8dMqX9dp3eVabA3YUVlMSSKNj
kbAK6lJl+wy6R4vrYefE/bIZIV81turghXU/J0Fg6wwDkuX6toxLyBYQtY2iWLOt
NCxE6FScNhTn7Z93LhpUeBeSbI6zkh7SUyNarBdIJd8JBjhg3RISiuFQ38cc16o1
zy1ol60h0AQof1HqEX27Skc51MBLF083hZ9D8X8HI9tCoEAUXUX2j2pTx/OvHlfa
nytL6TOSiFAm5LqbW3kFFa/+Dg/qOeid0fboNgmzhHNf8c3kggEcupPV/GENLdIi
hxfm1I9wQJdvU7fBf5PG
=wa6C
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--===============7721827001085349869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7721827001085349869==--
