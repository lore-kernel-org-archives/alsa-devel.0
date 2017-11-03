From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
 polarity
Date: Fri, 3 Nov 2017 12:45:26 +0100
Message-ID: <20171103114526.hjjmkkmkbxmotkpo@sirena.org.uk>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3101102084896156274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A9911266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 12:45:28 +0100 (CET)
In-Reply-To: <1509628982-9767-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3101102084896156274==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5spdrecq4kxrklyt"
Content-Disposition: inline


--5spdrecq4kxrklyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2017 at 02:23:02PM +0100, Sergej Sawazki wrote:
> After checking the code and the datasheet, it seems like we are handling
> the clock inversion (SND_SOC_DAIFMT_NB_IF and SND_SOC_DAIFMT_IB_IF) not
> correctly.

This doesn't apply against current code, please check and resend.

--5spdrecq4kxrklyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8VtUACgkQJNaLcl1U
h9BFzAf/YwTIE7EGthiB0r6sQiN1t6VheaHdNgY6QfS0hO3kn5HE1uTOJ8+luDqH
QbAzEGDfU3Z8kKSjY3a5c/Nbz4Uw0ja9fyWS4pFQlQEvetHyVHVnE9U7fvLbFYVS
iyvhYIu+p1vCpTxZiik4ffgfrcm0/kOirD4zNm2iEVWWyI6QinalTCs8A/N8G38p
/Mae5YUo33bfjvD4XeJh/gaZO/EiA2vU+tTx6kZ5aaOKzbxKghRAxJs34mBPaSwb
rrCv2rHNRn2rL0VRktXJlqkdpJrtloUME/s4KFQWOVOvaEUjod9XXr8CaIeDgqsM
88UTShmmbUmgbc3pTUzef3SF3hbBKw==
=bBfg
-----END PGP SIGNATURE-----

--5spdrecq4kxrklyt--

--===============3101102084896156274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3101102084896156274==--
