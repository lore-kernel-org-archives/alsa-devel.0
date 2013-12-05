From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Enable SYSCLK provisonally
 before fetching generated DSPCLK_DIV
Date: Thu, 5 Dec 2013 14:59:52 +0000
Message-ID: <20131205145952.GV29268@sirena.org.uk>
References: <1386148936-15899-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5432564367062998923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B2178265550
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 15:59:54 +0100 (CET)
In-Reply-To: <1386148936-15899-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============5432564367062998923==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="30GLzS1nLAWfoGxm"
Content-Disposition: inline


--30GLzS1nLAWfoGxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 05:22:16PM +0800, Nicolin Chen wrote:
> DSPCLK_DIV can be only generated correctly after enabling SYSCLK. But if the
> current bias_level hasn't reached SND_SOC_BIAS_ON, DAPM won't enable SYSCLK,
> which would cause the calculation result from DSPCLK_DIV invalid since bit
> DSPCLK_DIV will be finally turned to its true value after DAPM enables SYSCLK
> while the driver won't calculate it again for the current instance. In this
> circumstance, a playback which needs non-zero DSPCLK_DIV would be distorted
> due to unexpected clock frequency resulted from an invalid DSPCLK_DIV value.

Applied, thanks.

--30GLzS1nLAWfoGxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoJTlAAoJELSic+t+oim9UZEP/2FcnXlhFvjncBUU9rMwUPxi
RMRFzuZO0A1+LTxpBx6WiivJmCxVd4PKSPnMi77yfx4904Ht1LvvAihtZSFBODEH
KT8FvCwFC+27eYPsjeMrOOUVEqh8GHVM+tRgnXeNr+MafGe9eDAEomgq/e7WI3+u
JiJPPEEB6iyzPwGUZkR7ybvWcVKAfNIFiZF7TXJq5q5OD8nlYzsRf3ZC8wPUuOnU
nTq13KHmHcRyHIBF1gO0u8DmlFEL6rqgIqQEAwz8D3Qs4bL3zOHi0RTRz8D6LRl0
3VmT1FgNzjFoyDK9K+TjT4bGMqZAtM2K3W6pSdvJ1Ye4gMht2upoc2GBtNklFQw5
m0dsPimYNJh0bZSzyBpXE+RALnNxBmsT6CzgBkKCgdl1g8X+K9IMFf9Plop50xS/
cFZJTzAyKK9mBJdbbDj44OKS1kKYsm69TnYdH4sY5PmfbRuDZ4rBprEyZYmYaSw+
Noc6tpKegLCnayDMuzIEk4PrYbG3pMM/fqdGSsjhy/LXAcd603bYUxLERVcbFvMO
G+9sCmaetcogfHlH9+F7PhmL8BnNZnBxZpvkuOVEFZlo2hbsMeh8vmYNjfuWhAdg
Ns39HqZ09SHqb5PmSN+4H+8GUL2KUF2ifVeI/2Qm2t9rt7TBCTz379kwxNy/HBN/
v/ICpVf1d2oG7+1JaLuZ
=rU0S
-----END PGP SIGNATURE-----

--30GLzS1nLAWfoGxm--

--===============5432564367062998923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5432564367062998923==--
