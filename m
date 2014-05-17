From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFT v3 3/3] ASoC: core: Add support for DAI
 multicodec
Date: Sat, 17 May 2014 12:46:21 +0100
Message-ID: <20140517114621.GV22111@sirena.org.uk>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
 <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
 <5368C67D.4080506@metafoo.de> <53766FDA.2080500@writeme.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8843091626146510946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A2B26168C
 for <alsa-devel@alsa-project.org>; Sat, 17 May 2014 13:46:53 +0200 (CEST)
In-Reply-To: <53766FDA.2080500@writeme.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sinan Akman <sinan@writeme.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, Fabien Parent <fparent@baylibre.com>, Benoit Cousson <bcousson@baylibre.com>, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8843091626146510946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ClNI7qcIuZbdM87U"
Content-Disposition: inline


--ClNI7qcIuZbdM87U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 04:06:50PM -0400, Sinan Akman wrote:

>   I have a related question. I am trying to put together something
> that would "bridge" a spdif rx into say ssi tx on iMX6. I am just not
> sure how this would fit into the alsa model. Would multiple CPU DAIs be
> the recommended model for this. In this case I will follow this
> thread and try to extend/use that multiple CPU DAIs idea.

Ideally we'd be able to set up a route between the two DAIs and then
have the framework arrange for data to go from one to the other.  There
are hardware limitations in being able to do this - you either need ASRC
in the hardware or you need to be able to ensure that all the clocks are
synchronous.  Right now you have to bounce everything through the
application layer.

It is a somewhat different issue to the one Benoit is trying to address
though.

--ClNI7qcIuZbdM87U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTd0wFAAoJELSic+t+oim92foP/jvXWuktHi8SPWcVuSGDY/MY
aL/9v0FKPIGO4Oo5Gl04nuiUQIeuEbWlioWdPHt9R7NKa6j2kDcFNZvgRDpSwGTt
nlKsSjKwPaydA7rNUN1BOv81/H2xwd3QyTsfE9mRK8l8HP0jCxPZ6bDdrqmLgGm7
MlOQXjfO4ZfacaVk6xgAEwvocqNdLztR0d5UFwPZLvgVw20golNRYlJg34NUdk7b
ltzxmGCmEVk2+UDW7X+wlr8GqYmD0REi61nQgOyfyIjWpU/SbrD5JRgQjBEmeWrP
rcNxYEt6JiJyrHKg3UyRy71hI80Z4HJPgVwZTk/w3Sj0AmeGlEiZlkESLak/AhKQ
zSGRrZQLtal1cEBGRPwU3en1jit6P/3kfYMT27KSDR4iFtz8C8jIsi32W4ARCQvQ
NPkv+dMiGjGLLULm/mTPKfRer8kx9UJc2igLGo9cpKR7rJQJb3PH5uZJIuUcTRE2
1RMUQFgg5ctmI9S2LAjRUWN6CkvKkvLH8vkiEMfYcdTE45Zj/9T7LQ18zj2kRlTY
7hkUITB/QPUiMpR/a/0Uy1O+5Fffy81Um/4kwJ/HNY/Hxj7PYmovBk72uo8OJPt7
EqkSvlzPrekJdm2lDlFuHdU1DTwy0utMdP3xBW6eRmZQ7k8JXFs9rHExZGdrAcou
PAm+7IY8QFBrOCP6erg1
=tr4f
-----END PGP SIGNATURE-----

--ClNI7qcIuZbdM87U--

--===============8843091626146510946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8843091626146510946==--
