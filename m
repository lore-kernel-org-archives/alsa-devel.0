From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/32] ASoC: wm8974: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:34:07 +0000
Message-ID: <20141124183407.GM7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-19-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7004606352030059113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68359265703
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:36:09 +0100 (CET)
In-Reply-To: <1416746269-4935-19-git-send-email-lars@metafoo.de>
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


--===============7004606352030059113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4mwMARuvUPcmqDvg"
Content-Disposition: inline


--4mwMARuvUPcmqDvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:35PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--4mwMARuvUPcmqDvg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3ofAAoJECTWi3JdVIfQhv8H+wRHD9tVLsZEnloWAo3o273N
pM0J3QcwqxKRumKRgRPZ6WajMGZRvV15+spZaz+H5HKwukH6CkMvacVS3vqwyoyX
RM7Kzr1z/IIWT/ynl5tMaIgAOQwfHmB/c41FETP1UM9w8sJFQJI50Q2SvKlYP7gc
sDD9v+dJxFBYNKvjV2YSbY8dO2FBOmiJisudEtheye047picsDDkhi1Dd/uQDv7s
ewcr0/hRvbipCW59eRYxZyefkoqNQ82LugLvTz0iSVd0VX+6UHK6/9jvDaBJRHke
LPHaphH3zLe4rwyRm3vFI4kZrsm4/JR9dK4A7RFvxIgRMDCd1RUfOSw7V7dpots=
=Kwku
-----END PGP SIGNATURE-----

--4mwMARuvUPcmqDvg--

--===============7004606352030059113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7004606352030059113==--
