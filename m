From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/17] ASoC: Add snd_soc_{add,
 remove}_platform
Date: Wed, 17 Apr 2013 14:18:52 +0100
Message-ID: <20130417131852.GC13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4264243690295277721=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DAC8D26164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:18:54 +0200 (CEST)
In-Reply-To: <1366046404-8759-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============4264243690295277721==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2013 at 07:19:49PM +0200, Lars-Peter Clausen wrote:
> snd_soc_{add,remove}_platform are similar to snd_soc_register_platform and
> snd_soc_unregister_platform with the difference that they won't allocate =
and
> free the snd_soc_platform structure.
>=20
> Also add snd_soc_lookup_platform which looks up a platform by the device =
it has
> been registered for.

Applied, thanks.

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqE1AAoJELSic+t+oim9McEQAJRGHo2XIHO+AaX7WjGz5zbq
YzGGwUvbIEfz890HuAAtNY1fb5ji2crqOmOq3Goy4gIJFlQVlqz7LxtgBd6IkGrV
90/ydKDOns+TR8mUYpOTJ1+JfSn+7NEzxHpYXe8iQZ8tqYGsY8BU14cyaPg1xYq/
/nxLlpX8m4XBYDpwz4XrCNJ8HkG9W4D2QPtzJ1I/LmslIwidbjPgjBFsfwQCcNsJ
rTI9nwhQFO51l8GWF5mWNhEx09+2KqKHIiZmpV7L4kYrh7fIIixq6yqtHkW0WTi8
L0ZJPEBMAxcT9B1onPOcguVqaETTnBBOnUa+1vcvGVxysXUCpZb1XKu6nClt8BLL
QW3v0uFwBu0dM29PdkSATd2cNuFwSMskzlWBNSSqtFeL5Hny0I2pUEXH/nkIl/ZO
MdRDI/kdpPjctCaQE/HyJXEWKt+z3vO25B03fa2i9iNg8A4Wse+1fTryE0LocSnP
8NbdKB7SarTUxTxVlaGp4OzBQLcm1D/1VEUKn9Fe6yQq679WP7OKf0WLrW9Sm8aT
aLWqapWczYphPrvWYzmhx78CH0bqL5za04AFBJN1KTdk2B4DxVv0YJ9WGh0ua6U2
TYyk2S6pdmm5NHehlG6Q65SU+pMnw2QlZmeckQz01eaOaQFFf+maJLD9RRS6JI0x
RdOCOTv5Nn7s3xGUrBos
=1f7x
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

--===============4264243690295277721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4264243690295277721==--
