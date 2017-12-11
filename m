From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for
	UniPhier AIO driver
Date: Mon, 11 Dec 2017 15:16:29 +0000
Message-ID: <20171211151629.GD9854@sirena.org.uk>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
 <004801d36e57$ea1940d0$be4bc270$@socionext.com>
 <20171206125817.GF1827@finisterre>
 <001501d37261$7ea89d10$7bf9d730$@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6698725748950181796=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A815266EDD
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 16:16:37 +0100 (CET)
In-Reply-To: <001501d37261$7ea89d10$7bf9d730$@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, vinod.koul@linaro.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6698725748950181796==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2017 at 06:21:58PM +0900, Katsuhiro Suzuki wrote:

> But I can't find how to use/map this DAI in machine driver or Device-Tree or
> something. I think that it's same as PCM DAI, am I correct?

Yes, that probably makes sense from a binding point of view.

> I read compress-offload.rst, but I can't find how do I test it. It seems aplay
> of
> alsa-util doesn't know compress audio formats. Should I use PulseAudio or
> Android HAL to test compress audio APIs?

IIRC tinyalsa has a compressed API test application - Vinod?

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlouoUwACgkQJNaLcl1U
h9ARPQf+PMXnrKIL23fYeyj1KTSHQe5hA6zsx76EfW6KwhDKOc22W/xWKGahKiSi
88aMs8o/qIofpPSH9NZOfgSmnXOCMqRK38T9sW0WHqIugRc7UKBh93PV4/xjHR1w
U4PfJVBeTDoHx81oOhtRyuAKV1Pt8n2EIutk+Xha12tCqzpRPrXr26WeQt2NXBrm
Y3d1kcjugs9VOUlciPlboMZnXfWaVUzelvWM6FYW+oN4B9BxCKs4uuR3O8Cs92K9
3I7GZkwMcowhcdpS5G5+5xXi3yPlCiC4+miyymITMvvjpi37wNLlf7NdP6ENnE6/
LRWeMtupwTX1HhiRN2/2sqV/Vt2JUQ==
=oCvC
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--

--===============6698725748950181796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6698725748950181796==--
