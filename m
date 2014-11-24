From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/32] ASoC: wm8960: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:29:17 +0000
Message-ID: <20141124182917.GK7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-17-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0852225337699435362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FEB2265611
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:31:22 +0100 (CET)
In-Reply-To: <1416746269-4935-17-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0852225337699435362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BGXdj9oeR8eUT83d"
Content-Disposition: inline


--BGXdj9oeR8eUT83d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:33PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--BGXdj9oeR8eUT83d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3j8AAoJECTWi3JdVIfQ0kEH/ipaZeJjzZrG3yD964zT1D5A
6x2xLrPv97sismkhekCdq9NVYBeL/lquR8ikVMm8/wNLlSrLKeDi1pgKSRndg8PL
Oa94xQGF+ZFhKbZ1C32M+SOgsfPCYFAWXocDP2aALSAjFg40Di2HBdaT3xohYmyp
MLLJpuPCUhKpdFWFH1z9foJ3Vb+z7cx4IkISNEUF9l9hoLJoEa68enFq/SlYevmA
I0eqeqwLVLWpJQgGCfxPJnOZZANEL2w3cTsIsYgwWV4NeEpsF3zh2n4EfAuoRWTz
1EsXBBrC5fr9xfYl00Sj1rMu7aZIRDDOOEwuIKWt4YxnUpo7Lm0LiDRAXTFpqk4=
=Az7f
-----END PGP SIGNATURE-----

--BGXdj9oeR8eUT83d--

--===============0852225337699435362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0852225337699435362==--
