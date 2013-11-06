From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Wed, 6 Nov 2013 09:53:38 +0000
Message-ID: <20131106095338.GG11602@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104161537.GI2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82875482@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2826641297338348364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AF7A2610CF
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 10:54:43 +0100 (CET)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82875482@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li Xiubo <B47053@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>, "timur@tabi.org" <timur@tabi.org>, Shawn Guo <r65073@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Guangyu Chen <B42378@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "oskar@scara.com" <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org


--===============2826641297338348364==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2013 at 03:21:49AM +0000, Li Xiubo wrote:

> As your opinions, should I move the four register writing operations to .set_sysclk/set_clkdiv/... functions too ?
> Or just add a clk_disable_unprepare() after them here, and then add clk_prepare_enable in one of .set_sysclk/set_clkdiv/...?

The latter.

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehGeAAoJELSic+t+oim9WUUP/Ax7GnAFra3plXuggkpCC7no
LSUiyDh4EDSRG7BgpC3qpaeJls0wMwMz0D6nM7Pj6Gx5VgLepd9L+LM0+GHKqir4
KtIJic+2QSCA30cbcY/+m6DPkL+ZNPQL9VqQnzSxUD+BHEZHhC8wvD/CW84Cud8c
vEQDukAQmvMF0HMn4djX+afFwbuLfDI90LiVvKqskRNuKapbQlx2QsZWajnsBcE4
MuLTtT2SClFy7Wd4FVUDH/FgrPrYVy9xAqWdd0uNSNLvhIACH0u1Y6/u9gZQHHx6
SzPid8xhjHvFMcninvghAHLyQqGITN1UFceddqscQaIVtIhC+GRAGGDFz29Ct56Z
xBy3HwCeESdJOBcMCqVyOZdqk9nuRtLDXe8cfgCHy+XELbZctb+PYJNig0IcscdK
oEomtNsNU0agV4QtKcbqeRIgJHy6unVy4l/2f/AbtczcNCSWj6JYEvSLibsnhNxh
syKetHrt5bsIa4Ki2ufhL3breEeRQ6Wj7X0hU3eZ7TA9o7jolcLNLU7W9a7Y8VPW
KZnxRCjcP3je3dgawJq4fw/e9IOWBjG5Dwtic29+bZc+cyjTX1jN+5qceDnA2Ubp
DdUXaRjYJ1ffFEF4KsH7Xyb0IzfiX2gaDTkiTNwoF6H2RDs0ZRo217unJq0pE6+Z
sVC8mJvgcTvmX1/5LqwJ
=AUrm
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--

--===============2826641297338348364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2826641297338348364==--
