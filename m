From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: Intel: Skylake: Add more
	platform granularity
Date: Thu, 13 Dec 2018 15:37:10 +0000
Message-ID: <20181213153710.GO10669@sirena.org.uk>
References: <20181207235008.22988-1-pierre-louis.bossart@linux.intel.com>
 <20181207235008.22988-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2106353318528076982=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 723A626789F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 16:37:16 +0100 (CET)
In-Reply-To: <20181207235008.22988-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Chris Chiu <chiu@endlessm.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2106353318528076982==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 07, 2018 at 05:50:08PM -0600, Pierre-Louis Bossart wrote:
> The current SKYLAKE kconfig is a all-you-can-eat selection that will
> support all known plaforms. This is however not necessarily a good
> thing: most platforms for SKL and KBL don't support the DSP, but a
> number of CNL/WHL ones do. Selecting this driver in all cases isn't
> really smart and will require users to muck with blacklists.

This doesn't apply against current code, please check and resend.

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSfKUACgkQJNaLcl1U
h9C20Af+MgzYdkseepaxJM3EKtN00mR1u9Ud5l2eSo6PUWgviDXWiLk3WQQeQAXT
VP4yZ6BQSgKNugaJcakqMKAnQy29jAZZrUKoNEcsYnw4FmbGSiud7KcV+ObGNPJl
kEDkQ8ZfxeX4zhGQzoQPkJB7Q6RMD0XLJ5wpx89F232AXphbZrHZ2vb0iJKQu3B2
rI00Gtfsct0Vw77xaabLa1dVi4eIQrBVXyO35noQqjAbzF6khL5GMEDyFFIn+2vc
FoP7dYBnPCfY3O6n0aVl2fjRu9gtMfUCGmXaKEIgYThipdgRwlVHGqjA4McsALuL
HDOglMDpRnQ9C5ISVC2CEKKATSyp7Q==
=OZbR
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--

--===============2106353318528076982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2106353318528076982==--
