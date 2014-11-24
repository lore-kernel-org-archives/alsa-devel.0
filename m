From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 18/32] ASoC: wm8961: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:30:00 +0000
Message-ID: <20141124183000.GL7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-18-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1897874519883924919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EFA926067E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:32:05 +0100 (CET)
In-Reply-To: <1416746269-4935-18-git-send-email-lars@metafoo.de>
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


--===============1897874519883924919==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VH1SAMC12vKu3aE"
Content-Disposition: inline


--3VH1SAMC12vKu3aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:34PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--3VH1SAMC12vKu3aE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3koAAoJECTWi3JdVIfQ9oEH/RR8N9VnZ/5LeJeTob72YK/l
84dh1Xcc9bC9ZAuO2QSz0wzGgrSlFA44ZKzwsCbxyp60vzL+rc5NQ7lBUdtEKfuW
JLYNECBtj8Le8GT+r0RVYNfEahiH3CqDeIAK7ljagVTnVFyI3I7ghdXvjWe3nQzg
DBp8Bqe7YQyt6EYVl+WC8kqFK/0SN262GFQBfF/5Rn+ujTjkI+RnWg9GgKP8tcEz
8TV4366oYskeFD4oZ4CNhEZmcZHudP4thaA356hADP9c2X0LP4TvdfA0//KH/mfD
du3U3zC56AewUGpZ/K4J8Pc4MheAfGRp4l5WKhj3VsC/m9sQAc+1PL23juoe+aY=
=MY4i
-----END PGP SIGNATURE-----

--3VH1SAMC12vKu3aE--

--===============1897874519883924919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1897874519883924919==--
