From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/17] ASoC: dmaengine-pcm: Make requesting
 the DMA channel at PCM open optional
Date: Wed, 17 Apr 2013 14:19:21 +0100
Message-ID: <20130417131921.GD13687@opensource.wolfsonmicro.com>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1500510884644541433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1AF922616A0
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:19:23 +0200 (CEST)
In-Reply-To: <1366046404-8759-2-git-send-email-lars@metafoo.de>
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


--===============1500510884644541433==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2013 at 07:19:48PM +0200, Lars-Peter Clausen wrote:
> Refactor the dmaengine PCM library to allow the DMA channel to be requested
> before opening a PCM substream. snd_dmaengine_pcm_open() now expects a DMA
> channel instead of a filter function and filter parameter as its parameters.
> snd_dmaengine_pcm_close() is updated to not release the DMA channel. This allows
> a dmaengine based PCM driver to request its channels before the substream is
> opened.

Applied, thanks.

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqFSAAoJELSic+t+oim9JSYP/R5dbNj01Ihn5q1qsZ5ve0/k
Pc/JU6MR0DXX12y6qtNlPHH/XtajjnSEU+exW7jRvDv7fDxsvvD7q18s+Do35XJD
/fX9H3gukhl7/ZtmSNIDeCEM6mGd6DIq+ArfSvxZtYMamews0I5ofKBTG6+MDLa8
l/df2epX+L8xeIW5BJ5+Sg0kibPQJQSJL0vwscaf+tbUSC4PLnYmdhjoVn67hG3L
zc+vdVHWcsKNBk7jAQNn+kFmVkHmA+2U/S/Q5sZ8MtiTZi+fE3kj4OOz5Y50fa6H
XmG3/GJqYqglIkos9Z1hStPQnXLDqdfZ0Alc4hshK7TG/sGrPjdAjjaofIG2JJVu
G+Htpoy8PMsRlWMeAaEMDgaxK9lqHs5B9ZOhg2ewHvmz4PkHCddjeYO6NaAbc/nQ
2aHxOnIguKvunmM1TNkVVOaRmtnUi8OuYXnZ2uD5+tNEpjsh/f0LP/nWFx7UtQpk
75HH5Ve0NdIAt5wWub8LAbosLAQvYCesOXyvadEQ52ds6b8SnZrMwjllsVFH10rU
xLkxoAqmU66KrgKcAGfn4G3iic0o5jnbTh/KmPx8Ahsc2slg0T/E8gYMR9GeSmJk
tLUKAr1qFF0g+jGZd6MpknIkpy3T4GEqxFGg2GDY80LgLpdRO0D7uFQ+TepJ62nL
vR6qHBkvH3mr9xHJ21OB
=7/YU
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--

--===============1500510884644541433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1500510884644541433==--
