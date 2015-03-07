From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 3/6] ASoC: sgtl5000: initialize
 CHIP_ANA_POWER to power-on defaults
Date: Sat, 7 Mar 2015 10:28:48 +0000
Message-ID: <20150307102848.GN21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-4-git-send-email-eric.nelson@boundarydevices.com>
 <20150306201207.GX21293@sirena.org.uk>
 <54FA26B8.9050601@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7396752762640011581=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 875CB2605F3
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 11:29:01 +0100 (CET)
In-Reply-To: <54FA26B8.9050601@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============7396752762640011581==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cDindX5G2SjHcQY7"
Content-Disposition: inline


--cDindX5G2SjHcQY7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 03:14:16PM -0700, Eric Nelson wrote:
> On 03/06/2015 01:12 PM, Mark Brown wrote:

> > Two big problems here.  One is that this appears to also affect=20
> > LINREG_CTRL which your changelog didn't mention.

> It did mention the change:

> 	> Initialize CHIP_ANA_POWER to match power on defaults, which
> 	> disables ADC, DAC, and charge pumps.
> 	>
> 	> In the process, remove references to the following
> 	> register/bitfields from the sgttl5000_set_power_regs routine:

That's burying the lead a bit - that just looked like a list of
bitfields within the register (hardware designers often call ndividual
bitfields registers).

> The CHIP_LINREG_CTRL value needs to be set based on the presence
> or absence of external VDDD, so writing a default (power-on) value
> doesn't help much, and this certainly shouldn't happen after
> the proper value is written.

This indicates that there is a greater confusion in the code which
should be fixed, this sounds more like a patch of some kind at this
point.  At the very least this needs to be renamed, or there needs to be
handling in the sync code for the more sensitive registers.

My understanding was that this was being done to regain control of the
chip after driver start because there's no reset feature in the chip.
That's a reasonable thing to want to do but apparently the current code
isn't very well thought out.

--cDindX5G2SjHcQY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tLgAAoJECTWi3JdVIfQ7gMH/3PUZzuxsl+8y4PhCnsHO+BP
ppHW3Ud575sNAgh8jSDvOjBpzOvE1CE0pwlM6N7MLiAlOvDYw+zEkQ3ra3i5bdDE
E6JL+5+w39zQ0Gk4FMspG9SxEQbB9WpyQJleL2VeHxzNgvqO2BywLt6VTX9OXp7M
/xSTFOgnXyD0oZXZ/LcB5wuEHmJrFfHbsctG7CCSmwsndHQt4G/1x/9wfRl55Sk0
aIA37H77AN3am/jZocoasQuXkXszkVhbQYWcQXJ3aa62JW/bUNzU5BwhZMzO8f/n
qNcUs29kCms1OBWIG+eb8z/lwrhiNmFB9N3doS3PmvIjJ1U+ktEUbPr/IOKLJtw=
=AmnF
-----END PGP SIGNATURE-----

--cDindX5G2SjHcQY7--

--===============7396752762640011581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7396752762640011581==--
