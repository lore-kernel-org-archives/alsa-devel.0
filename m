From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: boards: Use FS as nau8825
 sysclk in nau88l25_max98357a machine
Date: Fri, 18 Nov 2016 10:38:55 +0000
Message-ID: <20161118103855.z5gcfc5fnsfxsx26@sirena.org.uk>
References: <1479448032-18248-1-git-send-email-grace.kao@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3545511764671980421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8446E266B17
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 11:39:05 +0100 (CET)
In-Reply-To: <1479448032-18248-1-git-send-email-grace.kao@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grace Kao <grace.kao@intel.com>
Cc: Vinod.koul@intel.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3545511764671980421==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="voi5u3jphg64fyuj"
Content-Disposition: inline


--voi5u3jphg64fyuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2016 at 01:47:12PM +0800, Grace Kao wrote:
> 256FS sysclk gives the best audio quality per nau8825 datasheet.
>=20
> Loud headphone pop happens if there is no sysclk during nau8825
> playback power up sequence. Currently Skylake does not output MCLK/FS
> when the back-end DAI op hw_param is called, so we cannot switch to
> MCLK/FS in hw_param. This patch reduces pop by leting nau8825 keep
> using its internal VCO clock during widget power up sequence, until
> SNDRV_PCM_TRIGGER_START when MCLK/FS is available.
>=20
> ---
>=20
> diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/=
intel/boards/skl_nau88l25_max98357a.c

I can't do anything with this without a Signed-off-by, please see
Documentation/SubmittingPatches for an explanation of what this means.

--voi5u3jphg64fyuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLto/AAoJECTWi3JdVIfQ7HAH/0MAHH8L4oYPHmcOYInJE8Z+
9K4HE75t9blrpP2Ks3enHKc6ows2cB6u1l9V1ZqnrNIh0T1uvoGZLyE2u7WK6/of
OOUDkflo48deutO29mW9bmalG22fA8+t9DztK6pa6LrS9Enak2ATP6M4vJhxQywK
rLvcMrYKXgptdYLs+wHPhfnMv7UP9S9huynNCNdJkILr4F/cPStRSiTDbsfwo0Bv
E/4+FRZfF3C70qbbYJ2oy7u83xbWTO7iANyKWrnF/VmlUWg/1+/xQObJMW2fWUjJ
J4no/jfz2HIVrvvKx1na2QzDpa6ZeYEXtXCT2dKznr9T4aRT1qdxnLB4ri+xjiY=
=roRr
-----END PGP SIGNATURE-----

--voi5u3jphg64fyuj--

--===============3545511764671980421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3545511764671980421==--
