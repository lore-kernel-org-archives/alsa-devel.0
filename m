From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/4] ASoC: tlv320aic32x4: Rearrange
	clock tree shutdown
Date: Sun, 23 Feb 2014 13:00:19 +0900
Message-ID: <20140223040019.GF25940@sirena.org.uk>
References: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
 <1392916981-9333-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5555613647159340941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18F9B261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 05:10:20 +0100 (CET)
In-Reply-To: <1392916981-9333-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5555613647159340941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xDncCqeGrqBEEx+S"
Content-Disposition: inline


--xDncCqeGrqBEEx+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 06:23:00PM +0100, Markus Pargmann wrote:
> Rearrange clock tree shutdown to disable them in the reversed order of
> startup. First disable all dividers, then PLL followed by master clock.

Applied, thanks.

--xDncCqeGrqBEEx+S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXJQAAoJELSic+t+oim95ukQAJwJ91gWst+5sYKj0ABG3v71
nLiDDZGQ/603S/94HEejU0Hkf2iJh/ftvJoQWofuVZYjBRnthRdWKOh1MaZVUsn3
Y9G8lgJzUv7QnPNz8C+xkZrCu49hsd7nTkXmT6Bt7vfaV143+lkS1RlS7nut0KQK
C7Ub1t1/tTSZuDsxozzcAjHOxHAxePBZZ9FIxpnGU42WY9+knDq62zK2+mUX3ADq
YIxw9kj1Jgb0N3XdawYjXbybFS+crbOLbzJDdD0/k5uzOTWi8AKDfTM4USzzi+pf
l9x+O09L14q8Pwv8gcug4cvMDya1K3N2QHJSNy++P2be35WYN02kDU37oB6ZeNVW
xI5R9L73AKPdSBLYWnRjZ9HxwTghmnfm9KEewo9CNFIkFc6iA1oL4JOuzvJJKBYq
kKFeajRXYXJbgb0cnCqZkJ4m2gJ//Hmy2lF2cy4Y0H6cG+UceCBe5BorbsT2WupC
Y9FnqdkgoIqykX5eumEZSBBwi0/ZWa6lMItNPRQBMN04jebk6NIoQg9sfdtRJec9
44MboDc+Y/t3MEGzAkGjqpKbkM1O+5jZW068+Sx3FlfuapqFSwY3gxzUWEtr+q/b
UOsk7y+zuZjm/A/B1Ccdd5OGeAmbrFEm9URba5QLqTfAfZ6sqhQLci8MUQmqufA7
MCmDrxQHzvcB3oKCsox+
=urB1
-----END PGP SIGNATURE-----

--xDncCqeGrqBEEx+S--

--===============5555613647159340941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5555613647159340941==--
