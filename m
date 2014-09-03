From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Add recovery for PLL lock
	failure
Date: Wed, 3 Sep 2014 15:36:18 +0100
Message-ID: <20140903143618.GP29327@sirena.org.uk>
References: <1409748168-21992-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5092199540241746165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CE1265751
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 16:36:25 +0200 (CEST)
In-Reply-To: <1409748168-21992-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5092199540241746165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MCBkylF/aX/f/TlX"
Content-Disposition: inline


--MCBkylF/aX/f/TlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2014 at 03:42:48PM +0300, Jarkko Nikula wrote:
> All MAX98090 input clocks MCLK, LRCLK and BCLK must be running and stable
> before powering on the codec in slave mode. Otherwise the PLL may not lock
> to LRCLK causing silence in playback and capture. How often that happens is
> somewhat hardware and clock configuration specific.

I've applied this but I'm thinking it would be more robust to
restructure the interrupt handler so the handling is in a separate
function to the one that reads the status register - that way when
_det_enable_work() polls the status it can just mask out the PLL
interrupt bit and call the usual interrupt handler.  As things stand
we've effectively got two copies of the interrupt code which will
probably cause trouble at some point.

--MCBkylF/aX/f/TlX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBydfAAoJELSic+t+oim92VcP/2f5PFX8ru/MFfwA+1B0ldyF
XaJS0R7Z7Xbx7Elm1cR2ISAqYSJauEqrGY5wCI15+JB6oa5lkic3yOlEffGlYjAC
ODTCpZOqHhvCoNBbDGA6GHCdJthB5A5VhkI0IsSbvEqZvDKzw8gH6uj50pGBemgJ
YyC2h5kQR3sJXxZY+bAx5pd274t4zDO62h1ZSs/jLAMcIgFPnsQ8Hxb6TKmreVxd
5dYH5DGE7Xx/usGF/H8CKHEhJ1GwXdSmqHoL5qsny9kk6K7hAM5U9POF/hxQmB9Y
wJA38YN/cHNgJBWA9OaMh3TrZQFTtuNcVsnxFJAL5i+xSy2JLU7HpdVNkAC7HY27
orez2MUNZaKUKL4cyaCtG7XbdP4WddQtGU0/BZPfHRwfR6eiDvIZ1nsBnYH5WEN5
iyvZQjy0TdVvc2h+mmvKWc+fbQmAXuF+bWJ9TjX6ERnl2MgtYEXU4rlwOAQKwpxm
kyy+Ek1T/9lXktHl3rFsCVEuyswTTJjt4mpBcmawnKap6cRWPirRoCCG+DrqrpmM
T1quyhpNZwSpLcE/kZS/9Bdc9sSIejUDy6t01g9jMN5NUOL4qSsqd3ndMWSyknaA
zzzTeczsuUPDUHUY4s3L8lc7zgUlpmZWfSuktGIuVYx3jkvJkU7d8eVG0yqX5G9t
kG12jXoiLIMhmHhklX/O
=WAK3
-----END PGP SIGNATURE-----

--MCBkylF/aX/f/TlX--

--===============5092199540241746165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5092199540241746165==--
