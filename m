From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: alc5623: Cleanup bias level
	transitions
Date: Mon, 24 Nov 2014 18:06:13 +0000
Message-ID: <20141124180613.GQ7712@sirena.org.uk>
References: <1416746872-11513-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6102350568783964234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9500C26514A
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:08:17 +0100 (CET)
In-Reply-To: <1416746872-11513-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6102350568783964234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LqInKle6vr1NBc7W"
Content-Disposition: inline


--LqInKle6vr1NBc7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:47:50PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner. Also remove the manual sequencing back
> to SND_SOC_BIAS_ON in resume as this is already handled by the ASoC core.

Applied, thanks.

--LqInKle6vr1NBc7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3OUAAoJECTWi3JdVIfQr6AH/3u5c2VaJwldn5g4Qu7jB8fQ
ujN+hF/jzfvwwT8n6IH78j0NsrHddc0IHlUjGe2v/7DnTo9LGg4Gum4x5UiBcC2z
r5f/SAC4pgk/F04l5vXpZOllTOn33sPhp/+ca/f15DO76C9w5mzRsck2wo5VS1CN
aBGLCdRnELTueDZ16byhLAWU11dbc29VJjlrACfJ47+qNqEpjNylzyUuaqbMgkfC
R1f4u+gY24gzx5cMYgnU7qof46VYS/7P1TdIRYYpY0K3b3G110HAu08JhJyloRQB
8oOQx2q4DmMI+8Q2VSfW2c1pLoaCkbIptbwrkXYcuhbjbry7mkemIyc2YvEf2JM=
=OCQj
-----END PGP SIGNATURE-----

--LqInKle6vr1NBc7W--

--===============6102350568783964234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6102350568783964234==--
