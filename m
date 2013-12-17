From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 01:59:39 +0000
Message-ID: <20131217015939.GM3185@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2824468063415938534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 563552607C8
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 02:59:44 +0100 (CET)
In-Reply-To: <20131216112910.GB30671@S2101-09.ap.freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============2824468063415938534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1WqHV5/jCvFSwawE"
Content-Disposition: inline


--1WqHV5/jCvFSwawE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2013 at 07:29:12PM +0800, Shawn Guo wrote:
> On Mon, Dec 16, 2013 at 03:31:29AM +0000, Li.Xiubo@freescale.com wrote:

[Deferring probe in non-DT cases]
> > Where should this special handling be dealt with ? Is here or regulator_get_optional()
> > will be better ?

> Anyway, this is another issue which should be addressed in regulator
> core, IMO.

It's something that the platform needs to address - the core has no way
of figuring out what devices might register in future if the platform
doesn't tell them.  With DT we can do that because you can't create a
device without providing information about what supplies will be made
avaialable, other systems may be able to do the same thing.

--1WqHV5/jCvFSwawE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSr7AIAAoJELSic+t+oim9IM0P/3q6WHiKyumGhl53BNuz3aTf
ZBT9cVIO2KgWbm9huhWHJ6H8Xs8dMpNQlQ+0qaWkH3eLBhPYaBQJuuuxVD6n9IgX
AtpDDp0myOSfPw90OsBiBs9pAZ1X+xGSoxf8P4+yuoEG+aJ9xwGhB+sYzjqfoyL0
5QaYb2s7Zlhe9qlMoAlkesst0UndL9LyI9tbvlZnyaYs0rjipcKYhURudUdkBAex
yxdxtcrUr/Uq4L6Wp7aVceJsPobJq8OChM+7TH3ziBp57yahriBdsbIMzprIpGLm
ea/Vy8OEz4hYLvHxcb+E5OR0Sau05kJxzDcpQTQLau4duI50kUHFQxy/SO6Ab8gf
4IgCi1NEpLBB1A6sjGXY47kE+4rXWUUtit2FtVmrBHlO+ozWiQUObGO17/OBimNj
hcaHIlexdPry/W4z4cCC6n8h8XHkL7vQKHbE0CNAilI/XwVci8CSvizkkJ3nyq9+
8U2ZxHAIKtOVGnb+dIAnaJhmXKwDWgAowU93rn0aYvOHz7P9i6CoSHg44mo8djzj
ronct36HAihkyHoPe1qiGOOjxHGpJF/vFoRzOCJFCPFzd/s7AzkLtdWUAPr0tjCq
tN5r1b7xbYgDSLem1FIuk2J3iiJvz4qn7LyaHchn8cbTozc7HewATUnqzW6IWR7I
HoiwkABRb8WBBg1en/Ux
=t1Rx
-----END PGP SIGNATURE-----

--1WqHV5/jCvFSwawE--

--===============2824468063415938534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2824468063415938534==--
