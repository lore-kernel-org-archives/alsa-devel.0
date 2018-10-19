From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8822: new codec driver
Date: Fri, 19 Oct 2018 11:00:44 +0100
Message-ID: <20181019100044.GA5895@sirena.org.uk>
References: <20180928031002.16112-1-CTLIN0@nuvoton.com>
 <20181017185423.GG24097@sirena.org.uk>
 <27474a3d-515a-661f-26c2-108abcc69608@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5530335038738856293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6165C2675B1
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 12:00:48 +0200 (CEST)
In-Reply-To: <27474a3d-515a-661f-26c2-108abcc69608@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: AC30 CTLin0 <ctlin0@nuvoton.com>
Cc: wtli@nuvoton.com, yhchuang@nuvoton.com, alsa-devel@alsa-project.org, kchsu0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5530335038738856293==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 19, 2018 at 12:56:53PM +0800, AC30 CTLin0 wrote:
> On 10/18/2018 2:54 AM, Mark Brown wrote:
> > On Fri, Sep 28, 2018 at 11:10:04AM +0800, David Lin wrote:

> > We're trying to get away from using set_clkdiv() as it makes it much
> > harder to use generic card drivers without specific knowledge of the
> > card.  However in this case it seems like it's mainly choosing if we
> > should use the MCLK directly or the PLL and you should be able to do
> > everything in the set_sysclk() operation - is there a reason not to do
> > that?  If not then moving to set_sysclk() would avoid problems.

> The nau8822_config_clkdiv() will be called internally by
> nau8822_hw_params(), not link to the function point (*set_clkdiv) from
> the structure "snd_soc_dai_ops".

> If nau8822_config_clkdiv() need to simplify, I will remove case
> NAU8822_CLK_PLL. The reason is using set_pll() operation can also finish
> clk configure from machine driver.

Ah, sorry - now that you mention it I think I did see that it wasn't
referenced as an actual op when I looked at a previous version which is
why I didn't mention it then.  The current code is fine, don't worry
about it.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvJq0kACgkQJNaLcl1U
h9DMeAf2PO7+OmPRDO400vMpRdRlbp/Hc1i7L+cnYVR8OVwbkgYlHnoiIUOmOne7
LuC2xDqJtRQE5CcPdROFz41xfPxbuSbZtu4tNBFn3oVV1DGz8JG0ZdkS5Nd48TKY
GNxpih7UbocdciaanXQhoVNfs1s5DqkRHsaL8HH0irdzpvRSq1x+P5VPwfTFtOB7
GH1ooskwB5m+a34zEsFEMPQkmT8ReMBfu02/YhBdx5mzfdxq/LxJm5J/d9G8VLQ/
Ne2lSHlozO5sMNNEgco6OyUSwqNeTp59geXVJr7F/IeVUWMy4Ji2GA4xYj7FoDNY
e2OIweviwmJf2IIKn88S8eTjZ1Pa
=8WxM
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============5530335038738856293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5530335038738856293==--
