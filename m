From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Enable both DMIC
 channels also when using mono configuration
Date: Sun, 28 Sep 2014 12:04:19 +0100
Message-ID: <20140928110419.GU27755@sirena.org.uk>
References: <1411737938-29903-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5515738587694648052=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3F9260570
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 13:04:38 +0200 (CEST)
In-Reply-To: <1411737938-29903-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5515738587694648052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UNrMg7q4I5bA1PGX"
Content-Disposition: inline


--UNrMg7q4I5bA1PGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2014 at 04:25:37PM +0300, Jarkko Nikula wrote:
> According to MAX98090 specification "Digital microphone clock (DMC) is
> enabled once both data channels are enabled.". Therefore both digital
> microphone data channels must be enabled also when using mono microphone
> configuration.

Applied, thanks.

--UNrMg7q4I5bA1PGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUJ+szAAoJECTWi3JdVIfQtjgH/RidSm4O4gAKpVvGOpiGIE9L
KdLN0LyR5MXy30wxhaJCKCzWJSeyvtE9nlJlNcbp+m+qLHIBIVxuDz3Lc7+Mq0Vx
0TdKibHbyBxXSbMhea9HZ+q52TPIz3mjAUjdP/FHUZ5v1Ar1eCD3rG/1qUFNNBfJ
6R/HO/s/A5jEQJi3f/CcFeBwYoVpIVXYCd096jro+z2a8grrnKV6NNH5uDISmeLr
+5m5Zoy/2lEp+qEs3LTLlwQtyU11ar3OQJqhfWk0/bC/Fo/DxWFhjxh3wnZ2BTuj
CHnS1+up7zmA/9BsF6QiBmQACqzhot4iUJoLvqnop5mNst/dDWW+pXd+6HJ136E=
=Ffhd
-----END PGP SIGNATURE-----

--UNrMg7q4I5bA1PGX--

--===============5515738587694648052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5515738587694648052==--
