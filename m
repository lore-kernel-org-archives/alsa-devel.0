From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/32] ASoC: wm8978: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:34:43 +0000
Message-ID: <20141124183443.GN7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-20-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6903751197405761855=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A0526531F
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:36:38 +0100 (CET)
In-Reply-To: <1416746269-4935-20-git-send-email-lars@metafoo.de>
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


--===============6903751197405761855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L9+4a/fGFceRH8Zi"
Content-Disposition: inline


--L9+4a/fGFceRH8Zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:36PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied, thanks.

--L9+4a/fGFceRH8Zi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3pCAAoJECTWi3JdVIfQmrkH/iieG9fYVDUhOFzt+fowVRMd
RttiH2qU0hzaObuhxg950v1RTQgM5K5oJQlV3WUJ5RFMx+tteYVytWv0iIBEdtpO
Sqbrq1aKpFPxaG7uZ6ZVGl73exkoyBZ+6DyPii/06tQXNTiZuN/aGZ1SPbkxyjlB
FgqnT7/iBnYVMZ/4l6kfYzfgrE6oD5OtAZs6T8b8pJbxu1mbBiSB8hdr7QeCGFPh
X+6f1ZlmUPYNBYpoV5EiUtTVPXXz8oubx4a4Hpa21EbgR3508Yfssjhxcawth6Zj
En+/AJFY6dNDhqKqRk31khlzj5qEuvy/OiHuwXb3kXs1pWiNWekIjQWJfYVHldM=
=CQvj
-----END PGP SIGNATURE-----

--L9+4a/fGFceRH8Zi--

--===============6903751197405761855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6903751197405761855==--
