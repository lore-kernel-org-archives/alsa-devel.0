From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: SOF: Intel: Initialize hdaudio
	bus properly
Date: Thu, 8 Aug 2019 14:13:35 +0100
Message-ID: <20190808131335.GF3795@sirena.co.uk>
References: <20190808095715.29713-1-tiwai@suse.de>
 <20190808095715.29713-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8374601176798162019=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B74F9F800E4
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 15:13:41 +0200 (CEST)
In-Reply-To: <20190808095715.29713-4-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8374601176798162019==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 11:57:15AM +0200, Takashi Iwai wrote:
> The SOF HD-audio bus has its house-made initialization code.  It's
> supposedly for making the code independent from HD-audio bus drivers.
> However, this is error-prone, and above all, the SOF driver has
> already dependency on HD-audio bus driver when CONFIG_SND_SOF_HDA is
> set.  That is, if this Kconfig is set, there is no reason to avoid the
> call to the proper bus init function.

Acked-by: Mark Brown <broonie@kernel.org>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MH/4ACgkQJNaLcl1U
h9ARfgf9GkzUjoQ870PUyuCKngYf0CnDAxx8bm8Daje2hsDx7Q+Mc/Ax+Cotj9BP
zBY8jUENGsEGMkxdKbQZxqObbVizAeGSaDGDMNEjQL3BWCP289tvRbVcFkN8o8Xt
fwdbyeCKu9BHgsxvP8x/zenVQhYPZcoYlRy3QoA61YjdslK79Q/bfJIA7VQVcf7y
ZzAKIDmPWZn+HHnVTH0bQtuahU2Re1Y0x6F3HrBnsbwX1URbvP1mInQr623uIOP6
ChzVTFssFU9XF/awIHxdITiNdp7Zi3xFn16IEirETvhV/QKxLbV3FYANTwklHF+W
TXIFjLyGJgS5VnepFrXEz25JZUwnnw==
=UKb7
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--

--===============8374601176798162019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8374601176798162019==--
