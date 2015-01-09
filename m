From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ttc-dkb: Remove unnecessary
 snd_soc_dapm_disable_pin() calls
Date: Fri, 9 Jan 2015 20:31:06 +0000
Message-ID: <20150109203106.GO2634@sirena.org.uk>
References: <1420835301-14469-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120432828953502369=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD09F260438
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 21:31:18 +0100 (CET)
In-Reply-To: <1420835301-14469-1-git-send-email-lars@metafoo.de>
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
Cc: Qiao Zhou <zhouqiao@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2120432828953502369==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l0cPdtAPtAyfJl83"
Content-Disposition: inline


--l0cPdtAPtAyfJl83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2015 at 09:28:21PM +0100, Lars-Peter Clausen wrote:
> The "Headset Mic 2" and the "Headset Stereophone" widget are managed by the
> jack detection logic. Their will be set depending on whether something is
> connected to the jack or not. There is no need to manually change the state
> beforehand as it will be overwritten anyway.

Applied, thanks.

--l0cPdtAPtAyfJl83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsDqKAAoJECTWi3JdVIfQMpYIAIWRuLLeu4yVRmJhYp+jRCoQ
BmI7hw2Vi1dVsOSSE4FOAZlwQ3uyZPCjxfAqD9tYrQXpyShveZL1LbTs34cdLI94
7cAtu1yNb9eiv6MNRMLHVumAHzUommQfg9yD0TB8TGWCLiUEohwk0Tih0mroreMP
yHIX39EXyCWeyQOtLzrJAKO+dwasl4DDh6beD+TNcM6qrQsHxSN1vnziMwoZPYS4
Pz5tE3un9eRLytTaYx/+tKJr7tP+83Y6uN28tlN6jGIrfiQN456yhU+qPtznP0LY
SjU4pHtGt5JPLyOaNoHZMgVhToE9oTSUcltXvprvBf2WCvXcMOIwpWdYa7cCXLE=
=vKA8
-----END PGP SIGNATURE-----

--l0cPdtAPtAyfJl83--

--===============2120432828953502369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2120432828953502369==--
