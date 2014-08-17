From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: edma-pcm: Include edma-pcm.h
Date: Sun, 17 Aug 2014 09:31:28 -0500
Message-ID: <20140817143128.GJ14537@sirena.org.uk>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
 <1408285102-24538-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5165252984836973005=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C40C42650DA
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:31:52 +0200 (CEST)
In-Reply-To: <1408285102-24538-2-git-send-email-lars@metafoo.de>
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


--===============5165252984836973005==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
Content-Disposition: inline


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 04:18:17PM +0200, Lars-Peter Clausen wrote:
> edma_pcm_platform_register() is declared in edma-pcm.h and defined in
> edma-pcm.c. To make sure that the function signature matches for both
> edma-pcm.c should include edma-pcm.h

Applied, thanks.

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8Ly8AAoJELSic+t+oim9Gg8P/j8AVEHFriN0jT4c4+yzZZ37
BTxCL2CMxZgWhnBZWG8UPQKH0moU9CyAAn73u/H5bLs1toLX6R7he7koLQv3ht5c
8CTG2Gv/V9Xw0Kjj9jEgAfBB3/f8GHIJbKHKh73+yeyogQJPmq04ScSNJN5qvDDE
yCvfPtbHFpfsWXYNVeLZwVB27DW4mfkVUAvTzK4dQ/WsuSkpwZbbTh42xukJfHhl
4N4vJwx5OlxUNroVjMF/Q969Gye5HN8Rpv5nDRWxeHBtKk7jVqcGGXBvvcrwU1RL
z3XXDc/ci+Wb41UUefseC/g9MVpZYcBK/JUFUD2SMvXVNgOv17x8po6vlqrT9Bvp
hiSKYq8C6uigV/MsaTXYEAikBWG1oiJVVspt1/kUG56LzbQaeg5BCtmI/9OuM942
5NP0EXOGqQRS5O1EA6/QMWgg+isZVJsqzvGS6zATkWU2cNsfLSCFvH14iDsCmv9R
di+osuLuYWqz4f1NizkLcpuuBK1ErL3t7DnRiaiMQRUITD0AchusgPNHtc4xoQ8r
6usFaXfmR7uh4I2RL6mjXtqQ3uWfL/580VpPF38K4MBQPmfj9K5ZZiNYHsP25UtV
IcOaUXAGknVjLfiIq5GiVAqIvTwWngBvjYcwNCrbDgyHojV42x+s/qGx+2bxNx+W
dva6IHgePrVViYkgr7v8
=AXO+
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--

--===============5165252984836973005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5165252984836973005==--
