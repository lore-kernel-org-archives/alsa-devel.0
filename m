From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add missing mutex unlock
Date: Fri, 8 May 2015 11:24:28 +0100
Message-ID: <20150508102428.GY22845@sirena.org.uk>
References: <1431078610-4150-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0710428575764144269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E74265AD0
 for <alsa-devel@alsa-project.org>; Fri,  8 May 2015 12:24:42 +0200 (CEST)
In-Reply-To: <1431078610-4150-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, dan.carpenter@oracle.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============0710428575764144269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hW1WQCDE3DZPNFmE"
Content-Disposition: inline


--hW1WQCDE3DZPNFmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 10:50:10AM +0100, Charles Keepax wrote:
> The is a missing mutex unlock on the error path in
> snd_soc_dapm_get_enum_double. This was introduced in commit
> 561ed680b764 ("ASoC: dapm: Add support for autodisable mux controls").
> This patch adds the missing unlock.

Applied, thanks.

--hW1WQCDE3DZPNFmE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTI7cAAoJECTWi3JdVIfQGwcH/jecfuGQWmEQ2fB50shMu9zq
w670WAxTuMhHSz1D+JH7ob3nBvKx+YmS2LHXqFInyoyQLUfBrNyLFt3HxZetc9o5
1VknLwEB0BMoqtrenz+zzCcxWAJ1ZPBnK9u0E1SwaFJ5bG9ai2dru9tdLRcLxFlG
yVFkL/Nt0uL2bxhfrXtFJXiTHzUzeq1rTH+x2+PDSIa6JV+xkYXvKhQX8LWIFkYp
C25XFiUAC/72O76+BfXOS1LTsI5naKpQ6USgnOohlBlZWNZ7wopSMnnPS76ooITO
YlNAl3k9zsrFbX3TmS+fYivr0UD6QG2IsszFPP4u8ANjrXylxBJSosAMLWNiFSU=
=fFCO
-----END PGP SIGNATURE-----

--hW1WQCDE3DZPNFmE--

--===============0710428575764144269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0710428575764144269==--
