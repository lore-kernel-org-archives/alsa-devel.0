From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/5] ASoC: Intel: IPC framework updates
Date: Tue, 23 Jul 2019 17:59:00 +0100
Message-ID: <20190723165900.GM5365@sirena.org.uk>
References: <20190720194532.23682-1-cezary.rojewski@intel.com>
 <48015f53-e650-1e77-9217-3a65250673ac@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7493460028597554256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9052CF800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 18:59:07 +0200 (CEST)
In-Reply-To: <48015f53-e650-1e77-9217-3a65250673ac@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7493460028597554256==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 04:12:19PM -0500, Pierre-Louis Bossart wrote:

> The rule is that we can't break git bisect. And if you squash the patches
> together, then you have a really complicated patch to review/test, so like I
> said earlier such invasive changes in shared prototypes are really painful.

Yeah, I build test each commit as they get applied (though not
everything gets covered so things can get missed) and it's generally
helpful for people doing things like bisection.

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03PNQACgkQJNaLcl1U
h9DIugf/VItGBR/q1aSLeIYEatGAGxY34V2ObQlyDtj6eBtJZ1WAKPAtYVUigd/G
0+L+03cfSBOc6i0PLwE/b4JVRIMGyexNGvAR+FmFau0Iborm3Hjcr6h7TygczpCu
4Rz1rM1N1NxwoIN5guE/M/yyluROffSb7hOWFmDHn/S8nMXb4lBMugWgPAlxU+YW
AZ4t4c/HoPXxCPGWSzV9uRI5cuaulDhT0WUP+ug9ViMweAdOss8bM9yVUf3apafr
5O2nrlHjYrTM/DOvN5LPY81h8ee3ktZBMeun9h6UXbcnEHFHnmKOBYUQAXyJacze
tnzajqoAnu1H/aEQRfc7vNRgaoOeCQ==
=uPxN
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--

--===============7493460028597554256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7493460028597554256==--
