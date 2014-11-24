From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 23/32] ASoC: wm8988: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:38:22 +0000
Message-ID: <20141124183822.GQ7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-23-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4560918191348746548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A7C265473
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:40:28 +0100 (CET)
In-Reply-To: <1416746269-4935-23-git-send-email-lars@metafoo.de>
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


--===============4560918191348746548==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TuLZpJsoCmPfu6RO"
Content-Disposition: inline


--TuLZpJsoCmPfu6RO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:39PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner. Also remove the regcache_mark_dirty()
> from the suspend handler since it is already called by the ASoC core.

Applied, thanks.

--TuLZpJsoCmPfu6RO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3sdAAoJECTWi3JdVIfQsf8H/AiacP0xFPGCmJpANd2KiTzI
inblb8xJ7a9aDwOSHmNJ5Lc3/Kqq1ehoMd6D6XM468xJ/+vMGV4jjGAvCExH9OVk
539E6+P4X5WGn3BWgcupVfx/Rh0kTTomg4HG8Q23jcBeW+TdP9KRMR1JNsMljh3d
KY034vtmY0dY8B9KpxCd0Ao6kkZ60UAjm2DzQBaHYdz0X+CCefdQHdEXDMSD0zr3
ts5SfCA3Hb4NVEoqLGCxCUaLms1p6Dooe4DNrIwQ9jZTlEBLL6vpeUAwQNJSs5f9
gMbcEvfKTpO0O9IiRCZMnX9l+5dMrWjgafxq7ngZ37SsITRmv6gi0TgIHxkfxJQ=
=aTn1
-----END PGP SIGNATURE-----

--TuLZpJsoCmPfu6RO--

--===============4560918191348746548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4560918191348746548==--
