From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98925: Fix mask for setting DAI
	invert mode
Date: Tue, 26 May 2015 18:32:51 +0100
Message-ID: <20150526173251.GX21577@sirena.org.uk>
References: <1432643708.30725.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0722367965941335138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A86F0261B07
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 19:33:04 +0200 (CEST)
In-Reply-To: <1432643708.30725.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Anish kumar <anish.kumar@maximintegrated.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ralph Birt <rdbirt@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0722367965941335138==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JJKOhZVZ8d05tF05"
Content-Disposition: inline


--JJKOhZVZ8d05tF05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 08:35:08PM +0800, Axel Lin wrote:
> The M98925_DAI_WCI_MASK bit is not updated with current code.
> To properly set the DAI invert mode, the mask should be
> M98925_DAI_BCI_MASK | M98925_DAI_WCI_MASK.

Applied, thanks.

--JJKOhZVZ8d05tF05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZK5CAAoJECTWi3JdVIfQKp4H/R/Q5seCOv7sSjDnZmOigQDJ
UgNmsbWeE8NGvnL/RW5uutXNDrX11F8qzTjV1/7NPZoQ8cNTxDwrHnGK+GN550VV
kImX3x+XDCiiJU7gy3X7zveG02hE5KVdVoVCOjMSviZysNx9k54ayQA0qXqVU6KQ
B2CjsL1ToK6yRV0IN1dPO40zbmLHxABzrrCt7dvyPWrhxYQ1FAKEGAQvXKuucv4y
qBagFF+ws4ts2b80knYqmUQZDYqMGEV+e/jXEP6bvfIJN69nlZMxWKL40+SBun2d
ltkcuQW/KFUTxgHWCHQTRWpfk0WZVKBOcTCQnuKuP9d6p5pazMMtjRjZD7WpxQ0=
=sZRC
-----END PGP SIGNATURE-----

--JJKOhZVZ8d05tF05--

--===============0722367965941335138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0722367965941335138==--
