From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
Date: Thu, 21 Mar 2013 17:47:31 +0100
Message-ID: <20130321164731.GB15926@opensource.wolfsonmicro.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net>
 <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <514B34AB.1080107@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7460244331955712977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BC2D265F8C
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 17:47:33 +0100 (CET)
In-Reply-To: <514B34AB.1080107@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7460244331955712977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 05:26:19PM +0100, Lars-Peter Clausen wrote:

> a second step. The first step should already help us to get rid of a large
> portion of redundant code we see in PCM drivers today.

Indeed, factor everything we can out into common code and then improve
the common code in a single place.

> There are some other drivers which don't really depend on runtime filter
> parameters, e.g. tegra, which doesn't use a filter function. So tegra can also
> easily make use of this new generic dmaengine based PCM driver.

Tegra's DT only these days anyway of course.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSzmYAAoJELSic+t+oim9KsUP/jnGWhq2rW7SsDjWQVgIfBZA
viQPqB62DPbRwid1GFrBMvEyz8QTuixS7s56FP5JWjEkkX6Aq6rVWfq6U47o75yE
KsykPyckawPLsE7eNbSMMX8X4CbvvUFV2WOtto5ZSCFfXJl8bFPtX6nfdH+rHvSG
PKEVXHBCvAzdnsWY0qYrU+Fp0pX+vIPsd7YuvuUfWBXjGH+wIiUxFloRZ/3o/X9O
NxKM39+7T/6Gfa4o829QQ01WIyxnfOIA6vKcZ3nmFJuX7Pfxj/AQsqdvlcALfJdk
FHkmCv6ib4p1H1efz6g6HinqfAHKucQ1IDxpihrQBK6AVoV95D/MQikx2R+I8VU8
aB79fQiJbz0nl6KKhx8O60w8nLu8BC4mA/2Wvby8ocEPYYSjvNbKWqH1+HpE33uh
+GAwY+W6LEE4vZAOR8pAVhWo3c0RPX1s3ohYuDXFZEvfUG8Oiy6qF84JOSKYyIG9
4RSPBedGnUgC6FcwnTZ3jxNOZNAFO3WrvSg2pRPp7ewKpvLFTQyRiSf1GqQHus8d
w9dFoNWR1Un0pEW+m9yoJdQrJZz70Xt7b3b8EWa62CXIH29NXe7Yu36IFeh8NQaa
G9naA7Xm+8dEtQkQ9j6gQQTd31YYky++Np32notbd+ast4F0ougKpGhSDNoSYxuZ
aQjd9YBB7LYaToK8NhIj
=N9tr
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============7460244331955712977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7460244331955712977==--
