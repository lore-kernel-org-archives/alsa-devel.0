From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: sh: Fix dma direction type
Date: Sun, 17 Aug 2014 09:34:33 -0500
Message-ID: <20140817143433.GM14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0587230226048329143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F1F52650E7
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:35:13 +0200 (CEST)
In-Reply-To: <1408285102-24538-5-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0587230226048329143==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wAI/bQb0EMvlZCHl"
Content-Disposition: inline


--wAI/bQb0EMvlZCHl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:20PM +0200, Lars-Peter Clausen wrote:
> dmaengine_prep_slave_single() expects a enum dma_transfer_direction and not a
> enum dma_data_direction. Since the integer representations of both DMA_TO_DEVICE
> and DMA_MEM_TO_DEV aswell as DMA_FROM_DEVICE and DMA_DEV_TO_MEM have the same
> value the code worked fine even though it was using the wrong type.

Applied, thanks.

--wAI/bQb0EMvlZCHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8L12AAoJELSic+t+oim9qYUP/Aodm6h6ZTO6+0WdpgZQT0rf
QOkYlGf6ZkaX+VOefrmWmAT/uJmPxq3xQFmgtloI1nq1UFdfAi80XwhNlK8toyNA
nQGnMy2Yp1HpaDkPmap3UkgexPnv+4vgxe1q8K//7IbuFh+2fdy1u5LI9oAoNEKW
oMt8lS6W/V+CLg69yQPSnD1GvcLu/aOO7maQdqnS2MSmgf9fjP0xSq+4HhpIcJo8
njHDJ2grLT5OOa6Kp3SfGGxqnPTYAGGKeCuEEifumibSleTiwCheT9xgvuZWPoMi
XWycuME9L+UZUnXzmp4enfwpRJ+Qv21sTXWPblkmSLCGbhyvCQxVQlPGLmzIFYsY
p1CiuCs3mwZG5AKV21eZQERrsZr1uSEQJmS4o7szqk/tXJOP0ewPlAI0coJeS6xr
JE4aOqmSK1sQtbobdj3H07kApSqDDbCu/waCNmGeQXm2gvzyI3xGShTXlkG8rBHT
QT24BbYUCnCRyE9gqD9EtyfQ5ZkZmWJjvdoKoMmuBJCHlLl+UTxpGk0YAyZ/pJPu
OXxFvKpLkCc249Pc1tvEL4ptSLXnsE70gUaGCfJtUZgAQe8RHirvB1hnDKcyZPLp
qDCG0XdM09LzJP7tgt1aaqAUBHuutBqeE36gX6czVQvkOvywbwXEDoWyoa9SaEwP
+ygqNLLqd/FGVr5DxXMY
=RTmu
-----END PGP SIGNATURE-----

--wAI/bQb0EMvlZCHl--

--===============0587230226048329143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0587230226048329143==--
