From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 16/32] ASoC: wm8955: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:28:48 +0000
Message-ID: <20141124182848.GJ7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-16-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7569346897390185247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D5802652F4
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:30:53 +0100 (CET)
In-Reply-To: <1416746269-4935-16-git-send-email-lars@metafoo.de>
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


--===============7569346897390185247==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xSXKkePCxtN78XFb"
Content-Disposition: inline


--xSXKkePCxtN78XFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:32PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner. Also remove the regcache_mark_dirty()
> from the suspend handler since this is already done by the ASoC core.

Applied, thanks.

--xSXKkePCxtN78XFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3jfAAoJECTWi3JdVIfQj60H/35w9VWQ6xiQ1xc4Uo4wZZug
nUg2Om7ilRurH99IlATFR28idnC7uMzVRxaXfSagY7K29d1Le5Ppew7uAggX51VI
lm9rht9jZU7g89eW65kVHKbb0ydkG6j0t2S4g+Qy+ylGtScQkod01JbFqU/kGPKQ
DdnjVnJVdBxY9ZG/sEmoMZLfIaLWsiq83P1F8CAzKBFOkAHp/+h7FvnAGCbNkivf
cwaq1dCopka+7LBuM1VMsL0JUUemEki3FBJizF+hnIY5NwXZG/U1O7qyQR4+234g
plR2X6QVtVRWUbI+FPZwXe61xe6Rp/IelQJhj7BiEFZyvPdLMFWepqsFNgKniUI=
=bf2P
-----END PGP SIGNATURE-----

--xSXKkePCxtN78XFb--

--===============7569346897390185247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7569346897390185247==--
