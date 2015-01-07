From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Add helper function for changing
 the DAI link format
Date: Wed, 7 Jan 2015 18:04:40 +0000
Message-ID: <20150107180440.GI2634@sirena.org.uk>
References: <1420553842-17335-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5646768659599478033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9139926053B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 19:04:56 +0100 (CET)
In-Reply-To: <1420553842-17335-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============5646768659599478033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPRTZ4IozCHrMUKG"
Content-Disposition: inline


--ZPRTZ4IozCHrMUKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 03:17:20PM +0100, Lars-Peter Clausen wrote:
> For some setups it is necessary to change the DAI link format at runtime.
> This patch factors out the code that does the initial static DAI link format
> configuration into a separate helper function which can be used board
> drivers as well.

Applied all, thanks.

--ZPRTZ4IozCHrMUKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrXU3AAoJECTWi3JdVIfQ9ZMH/R8LR+CHfaVsw10RzhNzri2M
SVH1+5EMJCDrY1+XVDZvd6QzkcAIykqQDFC3yA6AH9srDxx/CnwkRT4GKktyNSrv
dxLpjdi+uK4d641dem8MTgNjXXlSYtZGh7uvxm/ASYS7SFdW+P5044OrVeB3xjvq
hSmNE7bFOkkeKTKnFvM/kVSnrBj/FLmPjD7C9gQ1Xty98hs338Y3f0Nvb9TA60Sw
kHUK/THtEyYP9BPbxEIMEr6997hDMPhXSmeGnu3ZihOWMAztJMQ27MjsZdsi2OIZ
8d4ysfWmvZ+UF/fs7IVQwAyspJ/i3s646HnGfHj0+uwvT8DkZFmgFsV8zgzj0bA=
=zEwF
-----END PGP SIGNATURE-----

--ZPRTZ4IozCHrMUKG--

--===============5646768659599478033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5646768659599478033==--
