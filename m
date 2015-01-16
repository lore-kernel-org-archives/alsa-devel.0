From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Correct CBM_CFS dai
 format configuration
Date: Fri, 16 Jan 2015 11:46:46 +0000
Message-ID: <20150116114646.GH3043@sirena.org.uk>
References: <1421400025-6374-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1844516999165107471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75C4B2604EE
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 12:46:59 +0100 (CET)
In-Reply-To: <1421400025-6374-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1844516999165107471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QuX0r7ZseMwydPce"
Content-Disposition: inline


--QuX0r7ZseMwydPce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 16, 2015 at 11:20:25AM +0200, Peter Ujfalusi wrote:
> We should select FSR also to be driven by McBSP, not only FSX.

Applied, thanks.

--QuX0r7ZseMwydPce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUuPomAAoJECTWi3JdVIfQOZ0H/j/QxyOzn3RhYA64uDNbmDju
J+mBnmBvN+dBW0x1Gd2Enw04tFKHIX+7p9BIqChWf2uI6bA9QV+mpVY4mMf/6YyO
IG783Wo6jS3689scNJMY84OXJ3vXDixa7IBAHyDHPERsfa1c6tyhSxjLw4bHrcLa
IG0OqX6aNLnB7NsnG3M/479rOWKvyeH8BnrpfKBxE7K4PLFlXVNx74ZaNhXMrQ8L
Kig7QKKnO3BMu8M5S/CApoM9ALe9zuNrE/CtxnH1EFhBJBxObRuDYbirXVk3Udch
aqE3NbYtAG5MbHHWwQ0WFoqM+4nHaMVxDvniLCFVSbiFdotaCxX1ihf7Uz/ZXdg=
=Vz2a
-----END PGP SIGNATURE-----

--QuX0r7ZseMwydPce--

--===============1844516999165107471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1844516999165107471==--
