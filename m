From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/32] ASoC: wm8510: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:18:22 +0000
Message-ID: <20141124181822.GW7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7531773562135499160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EFCED26526E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:20:26 +0100 (CET)
In-Reply-To: <1416746269-4935-3-git-send-email-lars@metafoo.de>
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


--===============7531773562135499160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="36+Jv5wzUORg1Ut4"
Content-Disposition: inline


--36+Jv5wzUORg1Ut4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:19PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--36+Jv5wzUORg1Ut4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3ZtAAoJECTWi3JdVIfQJfgH/23WEXrnFnI7WqDr50+hLQPB
9OEq1yrvNyK3kPqwlBg2Ybi/sBMSviak7a1vd4dv85e6uFbCNKsXvqCJoCgj7G8k
cU1PISb8x51hM2r0onJkoVCc7tnFk0jzWSlyeb2kom22vJpzNOSuMOjw0isVd4LK
bfyfT2JRCJixfa6Hj3HiMuaHtlETSf2gzUYD9FPBnJ5WgrHlPopJ/KNWLoaJffBZ
lo+LKbq6Da6hGBcuZOeoxV/oDxYGEFAKVGkUx72KGgdK7l9rljcvedRcw9lrOdLZ
tTCIpoLCP9ezGK+XQFnQ9SxRZpqEXNzCp5uyxB3suF4uGspvW2q3hwC8akK8FXY=
=dX1d
-----END PGP SIGNATURE-----

--36+Jv5wzUORg1Ut4--

--===============7531773562135499160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7531773562135499160==--
