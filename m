From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/32] ASoC: wm8728: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:21:40 +0000
Message-ID: <20141124182140.GA7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4387751931291263437=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BDEE2652CF
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:23:45 +0100 (CET)
In-Reply-To: <1416746269-4935-7-git-send-email-lars@metafoo.de>
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


--===============4387751931291263437==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhCCdIwQf0d0uSA5"
Content-Disposition: inline


--AhCCdIwQf0d0uSA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:23PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--AhCCdIwQf0d0uSA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3czAAoJECTWi3JdVIfQn6QH/RVAUutwB9iSblRkHKVlphPe
BiNYXzF8sM7THj7O0x4TnBlr3NZGhzFsAf8fBEiCoicfB7tk07DKt/4pGCWkwff9
MQ0WC1knIPMgQXdof8UxRUVb763b5JnpbK33i2rjJ72KAvprObRi9shTt9PN7SzD
a6a3ItMWPQILt9jRnJDowbRxBlZrrgsPr5Nk7DBCKFeQqjF+TH0MYFO8VJ/zbz1T
W9eOHo0yF7bsJLxjp1+7mr7ZMYiKSW1tVhmULI+fYZBdM878e+t0rEFEDkUqpUbS
QxRPYh2kecH2qX5lxanTa38pZNDHZbd3cw5l9PtjFgJrMWsfoN2ulU+QVB4dVvk=
=j7Ih
-----END PGP SIGNATURE-----

--AhCCdIwQf0d0uSA5--

--===============4387751931291263437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4387751931291263437==--
