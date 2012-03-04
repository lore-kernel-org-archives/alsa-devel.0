From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/20] ASoC: imx: initialize dma_params
 burstsize just in imx-ssi
Date: Sun, 4 Mar 2012 13:26:27 +0000
Message-ID: <20120304132627.GA3083@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5238356200410738342=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D1B224586
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 14:26:31 +0100 (CET)
In-Reply-To: <1330788001-10158-9-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============5238356200410738342==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 03, 2012 at 11:19:49PM +0800, Shawn Guo wrote:
> It's not necessary for imx-pcm-dma-mx2 to access imx_ssi.dma_params
> for burstsize initialization.  Instead, it can just be done in imx-ssi
> probe function once.

Applied, thanks.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU218AAoJEBus8iNuMP3dKNYP/iKeUETLQ5LlVVMi4b0VfUhl
UPH+z1qMA0HilKuV5SbhEVlJwWkBavheb8+gXK+HLjbY7bngdJX9N+VZIlj7Wff7
PJC1a+YL0yCWkpTH6UEtWnEbP/Vl99fwRySbnTQLCNZnXKIUZ8hkFSlgO9iFweYO
QtiSLn8MoUNXag9CcWtG5SijMOzjJL3wsSjtmviWEfC2BJMh3DeR2KsAK+Tcg581
RxarvAXNTobvO8xaIYRpVrwvPJJNJKIsCGvcIVxxoZqnls2aIv/4/OV7884wo25e
ywA/OYunrhvv35GnkSnxZBNwzagn402I0JbxhVhtyHmaIaoC5TVuzdRhSSgssdaH
vxpPJenzwPIPZWoe3Ofh/Otvnq2UW4Us/NwGKYLm2jYWDDPgjmI/8ClorD6LaS7S
Upr9U40m/ZCXxNhRksh5E5rKyBadb7O4lzYTFhMrC8waPP7VKhUSAesQd6d9sS5c
5Dd7mTWuDirEStEZvssPOprhws1r3Xj1nuf329MGKp4+so7tr1BDct0+j5hlyQT/
n/y7lQStIQLPFDGUYIBxgy0KKApwVdokdVVlpKqGDcFCK2Z4z2VY73Sx5wIjOTkq
3dkZ7IBGIhJi6QYcBWrj4ceGAqXUUnodtNcO1hU4zF49itxNmn/vZDUaStaDGlNo
83gYnPLN0QIBN1oEhPD2
=rHv2
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

--===============5238356200410738342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5238356200410738342==--
