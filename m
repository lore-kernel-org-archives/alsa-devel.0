From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 27/32] ASoC: wm8994: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:40:47 +0000
Message-ID: <20141124184047.GU7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-27-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3141857298597263123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D13C8265367
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:42:42 +0100 (CET)
In-Reply-To: <1416746269-4935-27-git-send-email-lars@metafoo.de>
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


--===============3141857298597263123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0tLsAbKYoZ7gVvm3"
Content-Disposition: inline


--0tLsAbKYoZ7gVvm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:43PM +0100, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied, thanks.

--0tLsAbKYoZ7gVvm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3uvAAoJECTWi3JdVIfQZYkH/iErXjEcf01j1YzAFnokPU4u
pauViRalKeQAw0FoqoVbWTqWJKwVEAc7+/jt5swEc6ngq4hp9+wmnMh+u8K/ayVW
rojOXULUOLBW7NJ/eZt2olyk0mvuplgX15jb3NcObTPfuQ/qUc/tH8rNc9Iybrow
0WuulRTZUEdF1RfDSbTuNYo1gg8iwW2I4hk1ZTPZDUv2R88Dshaj/xYm5jXU6eGH
frn2xQjRBjL0r7cfjOx1CtNDnc5zXZMrSewa8e2YjQvBCoBt3yfxYZXUE1TjsTyr
N+c/oSnrhiiuhYjaqFAbouoq6n8+d0K0cvYxxrDLU4kpfbK9ggGnLg/lm60Q6NM=
=f+z2
-----END PGP SIGNATURE-----

--0tLsAbKYoZ7gVvm3--

--===============3141857298597263123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3141857298597263123==--
