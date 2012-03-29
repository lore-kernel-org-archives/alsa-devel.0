From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Enable VAG when
	DAC/ADC up
Date: Thu, 29 Mar 2012 22:32:43 +0100
Message-ID: <20120329213243.GC4153@opensource.wolfsonmicro.com>
References: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1972591062522110274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7992104551
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 23:32:45 +0200 (CEST)
In-Reply-To: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1972591062522110274==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2012 at 12:13:02AM +0800, Shawn Guo wrote:
> From: Zeng Zhaoming <zengzm.kernel@gmail.com>
>=20
> As manual described, VAG is an internal voltage reference of DAC/ADC,
> So enabled it before DAC/ADC up.

Applied, thanks.  I applied it for 3.4 since it's basically a bug fix,
please check that the patch got applied correctly.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdNTyAAoJEBus8iNuMP3dw+gQAJdUTizemce44Rs3IG54TnEl
iULuMALFvJMSbAwvDXHQBgBVL4k4EXHGgoPDTyMAj/h3hOUZDZkT1vKhSeNX61To
OOmICtxDGXk6iQy3Se3W343OxBiJexOWGuPZbdjV/VyQiOha0ABl3G/D7TYrZxHO
SHOskco0jD1muvTAIhFfTioFsw4vViOjBZZOJSmfgPF9uGMakfp63v/4/40ik5IU
x0lRN5mWb4n/kagci+W3KPV6k7mS9taqNNvJDh0v9Ku9E8wEscKgEM04kFyR0lnJ
DFc3PaoFOgWd5LpgNJJZ7BSGusyq3NyIu+PA+z2UAG/nseOCIM04xlJj7sHxyBO4
SJGR3QfTyW9rIDaLBOPkMkd3Hx49BRxaoJpFc1knVe3FfJZwlKdTAdo7yQu+SXq5
fx61MRmttlxnVi/e6A0izVsHao2nGUSfmNmwUKiuB7F45j7EoL1T1IB4lLrYbMkw
tRtUkOt78Za2jhWsPzlZZPjqGifpV4/KFAIpjLUqkIzXBdJNMFBzjB6VBrZTmA7o
pj1ssj+5t6LzaqKX5AENUOy9UzAU4sixc8jbmqRG4VamPKv625SvxJsDok8hgw3W
jgkA2SqsmcWSmFBNtQQsM/eEx5KDYiBBEmTsygmMQV2MWwWpyhgA+5Qi2Zn4AAjG
F1R/qYRE0FEAPbmXNHtY
=w2yt
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--

--===============1972591062522110274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1972591062522110274==--
