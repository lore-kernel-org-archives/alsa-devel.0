From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 8 Feb 2012 11:21:56 +0000
Message-ID: <20120208112156.GC3120@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3>
	<1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3>
	<1328698650.3955.13.camel@odin>
	<1328699820.21099.12.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8996184812084706082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EAF0103DF1
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:21:57 +0100 (CET)
In-Reply-To: <1328699820.21099.12.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8996184812084706082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 04:47:00PM +0530, Vinod Koul wrote:

> Possibly a .set_machine_clock_input callback which can be called from
> codec driver in .set_bias_level callback?

The machine driver has set_bias_level() callbacks of its own.

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMlrMAAoJEBus8iNuMP3dnkQP/ibXvSge84/vRqr1duD5bac9
pflITi/KsA9RQEyooJfve3YnTfj/B3biDtN7e0VjB8/V9Mgh1wmLisxpVH4LEX10
hFOlupM9+R+ydoYO2R0J3FVwTWEtB3VrxJNgR0CxXXRBc5H363wO1LJ1VdwT5TL4
fsvjBk4iGR5tpdYJj39Y3Zyqua2rkbxK254/afdsidcwn/Gg7BQtIH7r5vUw3lNK
EgJJd4D1hTvAktJYxFUiMK3ffk8uhPCWIWWa73UeYRK5pN2d4UEr8Mwn9t68el44
4vO8cT56c+58xddjtfnaA9SnPdHuMRvfdQaW9BKGxkq31RLHA7ycsLfy579ScsM6
DqGnbRvgEuTWjjYPDdRm/Q2MRZPVYoplTUD6Rgpx6G7d4neql3SKryRzLssmJJlM
ZnCCoh/k0LA6kSnyoTaqfqodTbMmYIy0tEthQJZv+fh3AAUxyPk4b6lkxBDjar/a
xTzRNQ3KvE49uCO7MaCyTYAoy3ZWNZNYAF5csNd9v1rR05F+UhzVhhiMJ52xNnaT
iyoK0k4rRfrj709VraWHNTRg2GTKecupXwSi1w4QwcdjOIiSN81OdL8Re7+fd+1o
3JeXOoJSBo0sXaN9xTZZNDIu18cLYhzo14NO6NhAHD/0hLn1nsXo26h8MBwimpPq
LJqJUHTxqxVGD/LBiAC0
=c55F
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

--===============8996184812084706082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8996184812084706082==--
