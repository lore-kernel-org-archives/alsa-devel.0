From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/14] ASoC: wm8993: Use
	devm_regmap_init_i2c()
Date: Sun, 2 Dec 2012 13:05:49 +0900
Message-ID: <20121202040548.GM17981@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-14-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7159691541576092361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0011D264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:05:53 +0100 (CET)
In-Reply-To: <1353930587-12907-14-git-send-email-sachin.kamat@linaro.org>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7159691541576092361==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:46PM +0530, Sachin Kamat wrote:
> devm_regmap_init_i2c() is device managed and makes error
> handling and code cleanup simpler.

Applied, thanks.

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutOTAAoJELSic+t+oim9gngP+wRa7cfd6dPLZ4nWWHYksmLH
u1Cqhu9Z59Z6uMQ1pIZZHLedQZbKyPNXI9530a75JPL2MV3ZtsTZj6f/lYJdshzy
unvTURZ3fDn0kOmnHT4ctA/NJnuDXGHirAGwJRYCGmN9Pw9b8iN43uYndl+Ay1e9
rOfqnsBubFlL6CulPFFGVqI5v5jV6UdUT8qz5lTT8O9xlckyVlBTU/DUT9MKHo7M
W/eoHj+cStVv3JLwnIzZ37blEIGonRYZpghZMCcix9R86SmnFAgAR5QT/T1UbS7p
mML1Xq9NVthyHcRbI66M2yi5a8SGY0dMdwQ4U/oGRzuXZpaeAX/nTsfsMUp1u1g6
UAVzilbCdD3Rt1JmNrXI0j+Tau1dt0AY9ll0f7IyLc5nbqgBsQqXiysU5BBUhM6z
QHVXr5LJNbuzYE3aRj/aPJ9sjDL6UDPAaMP05vD5X/CeyuHTG+UeeJwGWPHd6icu
2xicGIpM178Fx/V9hqQc08x1kPDx4IRKDFNlW4ZL5VBUuN4m/gzp5ks/PpXQO7Tc
hb8B27EJgx8gu5LKuKJpL5P/C8THo4AD9mwPhenUseddil8HbknpIlUmSkwuBQB7
pguwQU00cjseUZX9amXbOM9uXy1UHQzVhdPdky2xJz6iaWbh0acMaAxIU1RoYlif
YxXdhFBUBZGkvws1IoWJ
=35A9
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

--===============7159691541576092361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7159691541576092361==--
