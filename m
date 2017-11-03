From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: wm8741: Fix setting BCLK and
 LRCLK polarity
Date: Fri, 3 Nov 2017 18:46:13 +0000
Message-ID: <20171103184613.gm6ya5qbmtsgs7zu@sirena.co.uk>
References: <1509734068-9693-1-git-send-email-sergej@taudac.com>
 <20171103183729.xhngptij3qgarf5o@sirena.co.uk>
 <320c629f-ac63-8c7b-19c3-8655756c86f7@taudac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7896777189336343363=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63A70266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:46:17 +0100 (CET)
In-Reply-To: <320c629f-ac63-8c7b-19c3-8655756c86f7@taudac.com>
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


--===============7896777189336343363==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnrrvaparmmas44s"
Content-Disposition: inline


--jnrrvaparmmas44s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 07:42:14PM +0100, Sergej Sawazki wrote:
> Am 03.11.2017 um 19:37 schrieb Mark Brown:
> > On Fri, Nov 03, 2017 at 07:34:28PM +0100, Sergej Sawazki wrote:
> > >    (3) 11 =  inverted BCLK, inverted LRCLK <-- Fix this

> > > Signed-off-by: Sergej Sawazki <sergej@taudac.com>

> > Is this a straight resend - you dropped Charles' ack?

> Oops, sorry, forgot about Charles' ack. I have created a new patch,
> made sure it applies and resent.

Just to be clear when you say it's a new patch you mean it's the same
patch but rebased?

--jnrrvaparmmas44s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8uXUACgkQJNaLcl1U
h9C/eQgAhSV1RUEcHeTWCw3ZjAPRhvjudwW88D9iqNxrRvkSjobs2SQBs8sM0j7a
d3VeRldTa+O1XVIbDgAEKqctDVqZfiKfvhdB8DSncTHFqyKnu3PUuvUVv4ocRkFd
aDjlx8dOlr0H3PAShWMKVKqrOno7C79Fwe1ogZjbuus0dN+57e8vuaYo5ijxe20/
QV9I473t5SYv4Yl1mNbRvu4sCiDz1V0GfngaO+S6TY/MvbWDPoUeWkLkan+IMVA1
fBjenVoBlMddGF2k7Z1zv9SpIJNqTAUArCHMuqCz2s1g/d9eaPER5bXPjfLAs6B9
1eu27aaEYwYAKs0QwJqLApZBwDlcpg==
=tNgT
-----END PGP SIGNATURE-----

--jnrrvaparmmas44s--

--===============7896777189336343363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7896777189336343363==--
