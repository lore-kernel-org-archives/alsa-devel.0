From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] ALSA: HDAudio: enable dynamic
 selection between legacy and Skylake drivers
Date: Wed, 9 Jan 2019 19:23:19 +0000
Message-ID: <20190109192319.GO10405@sirena.org.uk>
References: <20181215200723.4216-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4732521377218510752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8997126742C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 20:23:25 +0100 (CET)
In-Reply-To: <20181215200723.4216-1-pierre-louis.bossart@linux.intel.com>
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


--===============4732521377218510752==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8WA4ILJSyYAmUzbY"
Content-Disposition: inline


--8WA4ILJSyYAmUzbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 15, 2018 at 02:07:21PM -0600, Pierre-Louis Bossart wrote:
> Use detection logic based on the PCI class/subclass/prog-if in the
> HDaudio legacy probe, and add a module parameter to bypass or force
> the automatic detection should it ever fail (or in case of missing
> firmware or topology files)

Given the issues Linus found is this series still valid?

--8WA4ILJSyYAmUzbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2SiYACgkQJNaLcl1U
h9ADPwf8DiC79ruS+zolLfK1BG4PyeUeyx2kJlPehB41g1qtWs4wmsgIJKgc0Gpi
lkwgPqFEOOyHK0sC7/CLXUTLJnBq1czHP7T1javtPoaezezUctbk7SThzT1PO2S7
b38QTiCddEslj+hcogSRHysz3HT/TiQlR5ORs1i3bZJR/UH/TgSZyWYPi53Jc4BO
Um7NL3OkdLGUS+97aMHJ2JrgN7VFarD5/NNNfmfeLG4+4+bx+WSF3Zabn9EvFsmV
HvpmshruDa7sqLvFmUezIyZ0ZEKlQppw4/DEuI6Jv7cWQeqqNkRAglIapHMje3tR
9ONE/ofrzjyZUJBB+lGPjJ4y2t0BnA==
=HvOD
-----END PGP SIGNATURE-----

--8WA4ILJSyYAmUzbY--

--===============4732521377218510752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4732521377218510752==--
