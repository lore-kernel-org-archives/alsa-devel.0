From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 21/32] ASoC: wm8983: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:36:34 +0000
Message-ID: <20141124183634.GO7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-21-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7653672678673525903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D198265373
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:38:39 +0100 (CET)
In-Reply-To: <1416746269-4935-21-git-send-email-lars@metafoo.de>
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


--===============7653672678673525903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X970w0TH+RQTigba"
Content-Disposition: inline


--X970w0TH+RQTigba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:37PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--X970w0TH+RQTigba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3qyAAoJECTWi3JdVIfQIKYH+QGXiL5m0GR7LxbbHqfvUXmp
mt0ovZHxIJIH6N2ItYQ5H94PhqXafubtJpjzuG5MUWNidxEH9jU1d5mJvGlSa0ZJ
85DZP9qTqo83Y0B2tAZQMP8zMuX/pvl6MrcYAluBoWea9gZ5wy2wbwbQ18fuW66v
wZ3lnJM9IQdUavrUdy4vZZ00KpJszVqvFetXgPatTmVDJGhIYCK7/OORkFV0AueJ
Q27XHZ9veyaobvM/KAqdSxBtyuZYNx1AKBHc66H9MzxH43ddN1VhhkpSojfsO4cN
o1UR4k1BRhB65gjITtfTvTva0aNnjd6P8pLeYY+dj/zoZnT82g62EGwkfr70lug=
=NGYO
-----END PGP SIGNATURE-----

--X970w0TH+RQTigba--

--===============7653672678673525903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7653672678673525903==--
