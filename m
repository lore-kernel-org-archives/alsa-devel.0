From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 5/6] ASoC: sgtl5000: disable internal
	PLL early
Date: Fri, 6 Mar 2015 20:15:51 +0000
Message-ID: <20150306201551.GZ21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8194432443107405203=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A3BD265E20
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:15:58 +0100 (CET)
In-Reply-To: <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============8194432443107405203==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XH/KETVr6lXMy7LH"
Content-Disposition: inline


--XH/KETVr6lXMy7LH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 03:54:32PM -0700, Eric Nelson wrote:

>  static const struct reg_default sgtl5000_reg_defaults[] = {
>  	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
> -	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },

Again, you shouldn't be changing the register defaults table unless the
defaults don't match power up values.

--XH/KETVr6lXMy7LH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gr2AAoJECTWi3JdVIfQLyoH/AkqTCCsWKpLJVgbdB8FVvQ3
83+BpVCtwym+y6qAySwkiDl+tor5i5O40H5+VlJ2VjI2PR30O26Nq1Z2b2+oLkIZ
9okRmCOC28LMoK3QR5vKBVsH3wrRhjRaf51DSQNEXuFLQzik9MeQ6gw/A/+5Ajry
hVw8xJjpysdgoT/PaGWsZywi7aO1Yf/uawsh0K6GMBb3b6zj7cbJCDpVJ6fTrEKa
+JVs7Ewgscawh0GCvDgxYA6MOReIue/EvklRmNaJ/NTavbtj+++L2vPcM/Ayti0h
HqJ9avx0HRuc+8zGG5qenoIue6J17JbhPgn/QDLigc2jjIiuINGITLrDgVTR9r8=
=awr/
-----END PGP SIGNATURE-----

--XH/KETVr6lXMy7LH--

--===============8194432443107405203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8194432443107405203==--
