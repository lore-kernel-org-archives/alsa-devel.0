From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
Date: Sat, 12 Jul 2014 20:49:03 +0100
Message-ID: <20140712194903.GB6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
 <53C153FF.4090705@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5112447770364698377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 21A882652E9
 for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2014 21:49:29 +0200 (CEST)
In-Reply-To: <53C153FF.4090705@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5112447770364698377==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 12, 2014 at 05:27:59PM +0200, Lars-Peter Clausen wrote:
> On 07/11/2014 03:45 PM, Arnd Bergmann wrote:

> >As a prerequisite for moving s3c64xx into multiplatform configurations,
> >we need to change the smartq audio driver to stop using hardcoded
> >gpio numbers from the header file, and instead pass the gpio data
> >through platform_data.

> This should be using the gpiod API. The gpiod API allows you to pass the
> GPIOs without having to add a platform_data struct.

OTOH that's a more invasive change that's harder to do mechanically -
I'm not sure it's sensible to insist on someone doing it for generic
cleanups (rather than actively working with the particular platform).

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTwZEsAAoJELSic+t+oim9x6gP/22izhe0AbUhtcwiKyqxVpPD
5w9UOVp3pfZ9O4xqy69vEjzsvkEg/hgaI9NCngugMfv3ejT9XclZ7yRehPCpT0hE
eGpDhQ5thlFzvRlYu+LcWmDWNUTlzhk7rxVugArQWLv9x8OeQjNPhGD3Kpk1Uz7w
E5ck5O8cZ024ICyDXqEgH5FMsSp+C1gBeQmN1QrzWjI85A4y+9vBk7wenHi4RhvB
BNhMMPCgARkYkV4kJ3n46sghMPIAXfa39w/VYJQXchwjVwLeLij2m/7ffR3ZGrqh
2/xSzY3fpBawpMYuWQ1YOPfF8xA0x4FV9oDeWfAqPxfB+Yhi8dYlfRtJ46Khq6W/
Uu/xv/Dl6UWj7EjVaZuj17u+d+0L36Y9PS8+MxsmyCvbh292ffSyK9DYieO3pXyF
AB8Ih9YDkjSVA1eh7mOTVCgMrIH6X/w2VkSDnFEUE8wbnK91Y0X2VTao11rc+SpX
+J17ITYSW2P6Nd+xX1bG6SCMJvxS0PLyf4r1fmStyBeOPsxK/pbbGVkG7tZSq5db
P2ABQ226J2aoIePh34JAgXnjzVX4DK7CsTcY/7JMQnkrQOUOdsvHJ5JWzV9oKz4n
xdiXd9OpjsOJce97UBoQDFDqxGPkshvXhhQnR2hdttiRYl/wjqmG/EVw8qkEqtCu
isR0ilNuXP6pTbhFfKnX
=RALO
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

--===============5112447770364698377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5112447770364698377==--
