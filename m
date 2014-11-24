From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/32] ASoC: wm8776: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:25:16 +0000
Message-ID: <20141124182516.GE7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3995180567927706901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FCF4265455
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:27:20 +0100 (CET)
In-Reply-To: <1416746269-4935-11-git-send-email-lars@metafoo.de>
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


--===============3995180567927706901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OAsA6xQjj2jRKPG2"
Content-Disposition: inline


--OAsA6xQjj2jRKPG2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:27PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--OAsA6xQjj2jRKPG2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3gLAAoJECTWi3JdVIfQIXUH/R8C5TRJPWILqt1mEs5UULbh
xWAZ6KZ4ezbNlVkzRbRh3ow5MqRiurOcQhsjuOTUJ4gHW7NfGNPopPpQMntqo2v4
M+8mkkHj9tA+YZ/BHqHamjOLQoJ+tYLpuwhIe/wA7xya5rtrbtmOjXicFD20C8+d
Nmggtk1s4avbS52vO4od15jP2n/OYkAANSDQVEWzCNuXlG1sE1vRcynCjS0gbgJo
l9jrMp7AvHxUXa3ycOvfbxPo4IW0fDlkNPb3I9/FVPw9MzA2NvFCK9or8F6MW6ry
CUBFEan3rSaAmB/8fSMciqM9B7itfu7a1X7tAHeXONGtIEcZ31A1ksqC7Kbo4Y4=
=lX9S
-----END PGP SIGNATURE-----

--OAsA6xQjj2jRKPG2--

--===============3995180567927706901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3995180567927706901==--
