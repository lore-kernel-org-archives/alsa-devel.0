From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 0/7] ASoC: Intel: Skylake: Driver
 fundaments overhaul
Date: Wed, 24 Jul 2019 19:10:22 +0100
Message-ID: <20190724181022.GG4524@sirena.org.uk>
References: <20190723145854.8527-1-cezary.rojewski@intel.com>
 <20190723154449.GJ5365@sirena.org.uk>
 <cac0d84e-61d3-5379-cbce-10f8d637310d@linux.intel.com>
 <81f9a74b-0848-8a45-a4d1-8ac44d11e0ad@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8692554425699391285=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A0ADF800E8
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 20:10:28 +0200 (CEST)
In-Reply-To: <81f9a74b-0848-8a45-a4d1-8ac44d11e0ad@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============8692554425699391285==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2019 at 07:14:52PM +0200, Cezary Rojewski wrote:
> On 2019-07-23 20:07, Pierre-Louis Bossart wrote:

> > - draw the line at "no new features" after e.g. 5.5 and "no new
> > platforms when SOF provides a solution". SOF was expected to reach
> > feature parity by the end of 2019 so it's not a random date I just made
> > up.

> While I can agree on the "no new features" line, the date is a loose
> subject. Honestly, I could've probably called first ~70-80 patches: "a fix".
> Validation team managed to mark half scenarios a failure immediately. Then
> developers were set loose. With enough motivation, we have managed to crash
> even the most simple scenarios. I do not call a folder with bunch of code
> not following any specification, design patter, lacking verification and
> testing and confirmed to be harmful a "driver". And thus, "new features"
> gets entirely different meaning when applied to /skylake.

If there's things that fix bugs then they won't be covered by any wind
down in new features so that's a separate thing whatever happens there.

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl04nw0ACgkQJNaLcl1U
h9APQwf/bfZqxu0gSLeffEQCfsi1HZNYE4TcvNbe5ZDZdCYuo1npPVADhJwJtQkV
csXGQgpznRfpAsxgQ19lj5Obrv7lvZ5unIz7qFK4Y+TThwysBj5ObCetfptsWVNe
tt8crziWSTdKe8YYSEX6TjwTHKcufjKWcdBzt2NgZHG7STjFOMnGOQzceRt428Jv
OCd2aAB2WA+DT0htD2NyhAOVafQy8HtD6T0lLYYEfyyjBULfSC/J8lbiNk61L6JZ
UI6ztUReCuWcwY/97jIYSUzGHhQrV4jUZTU9q3xhgVpDvTWO2iyp0zq6o3TYH6KF
4/JvqS1ceo3jQJkhoVOoxv7SP0W8AQ==
=u9jR
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

--===============8692554425699391285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8692554425699391285==--
