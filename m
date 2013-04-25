From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: imx-sgtl5000: Let the code
 clock be a mandatory binding
Date: Thu, 25 Apr 2013 12:01:27 +0100
Message-ID: <20130425110127.GR5019@opensource.wolfsonmicro.com>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
 <1366815286-31820-2-git-send-email-festevam@gmail.com>
 <20130425051654.GB1389@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6104170070558489610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6BFF26531B
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 13:01:28 +0200 (CEST)
In-Reply-To: <20130425051654.GB1389@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6104170070558489610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/rMgauiyHIRVABE"
Content-Disposition: inline


--J/rMgauiyHIRVABE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2013 at 01:16:55PM +0800, Shawn Guo wrote:
> On Wed, Apr 24, 2013 at 11:54:44AM -0300, Fabio Estevam wrote:

> > - Rebased against Shawn's tree and remove mx53qsb clock fix, as it was already
> > applied on Shawn's tree

> It seems that you expect the patch to go via my tree?  In that case, I
> need Mark's ACK.

Well, it's a bit late for ARM changes to go in so I guess it'll be
sorted out after the merge window anyway and can be applied to the
ASoC tree after that?

--J/rMgauiyHIRVABE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReQy/AAoJELSic+t+oim9PaIQAIX5zEA0a7v+jdKXA9UsLlHY
sVhITy5CJpQ8VV2c4zazdQNlYbMv6pEGQVORuXOUiBcMi8ukgUkj2yg83Prfyk0k
bMPkZeLwoVpDQTzvS12l1uYyQaHz/KDDq6h93EicjzQfjtPP2MiZxLQW408K4n3X
BS4OMsFbTOFHZZvtBvLT/qkyuHMJbc/GvAarWATE2RYTMCPcwO3yCgZ7IoShscVH
kkaCv1Rs9JqriZQ1929f4iLOpAbOUIS4aqNMwS+pv0HgpXlxoyt3k4erhRAvcONt
ceys6EYvG2sZzcfzpe+WmHNF7pdcfkDGQatxMbEn59csa4nvtgqLtBbsTFqKkMTK
9OFO0HX7mTG8WetbtVhMi4qL4BoriFKDLleZHGfvH6vHJLa7bGNKbVvMycQ2JjCW
gwIHikgzm5ZTPeSyI034of9OHe1HYSOFR3MYnieOLwSjM5A0+eB8LUc09+uBOAGw
WzY3QEm42hzlq2T+dqQ4SwIm5taP1yrPe7342yfpn8XIC2TDhD1/IY5CnGmN29Es
EoDMRKpii6Le7U5vVOMA5F1ZuOhqh/dFPVb3GVkdjryWknQCKZtL8jVrYm+IcnBA
bIXxmt/UfMj4GcjZoa0TMIr02kUgtn35N/zL3mGVPMnYKNbrsT4gGOUmQJnDqMSV
vj+Ee5lszHXw0AwDvK1M
=MSkE
-----END PGP SIGNATURE-----

--J/rMgauiyHIRVABE--

--===============6104170070558489610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6104170070558489610==--
