From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 22/32] ASoC: wm8985: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:37:37 +0000
Message-ID: <20141124183737.GP7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-22-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1233868735390652216=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 54D96265654
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:39:43 +0100 (CET)
In-Reply-To: <1416746269-4935-22-git-send-email-lars@metafoo.de>
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


--===============1233868735390652216==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="isRWw+cSVDtV6LY4"
Content-Disposition: inline


--isRWw+cSVDtV6LY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:38PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--isRWw+cSVDtV6LY4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3rwAAoJECTWi3JdVIfQRbwH/1XiBPGh7CQBXKNCDFfvHH3n
b7bl8nCDqMybEpw0yo1cM/9iYLlGYK+fnkIv0KG7QOoYmUZdn/hN5rzFXM7AuzhF
/DvDIUCsNFYz1ViJ99nmmeiJbtIARrQbje7U74o7R/0r7mOeYe5lr0m9AnpIwtsm
mhRs7yG7Vp7X6gOqtQQt1S4MjWHjJUuLnQrEPbVPE2gGxmku5ppXS0HwgU3TgO3K
CIA986PQpIzdrv9u2U4ZNIWw2RqmYVO0CxYGxIAOg770fRjRmXreT6kMtFpHD8+q
imEwWOuiBxB9RioM9smMrgdurNgzr7yQd3VDHm5EYbWGMB4dlLp9ih+LT5iLH2M=
=5T3P
-----END PGP SIGNATURE-----

--isRWw+cSVDtV6LY4--

--===============1233868735390652216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1233868735390652216==--
