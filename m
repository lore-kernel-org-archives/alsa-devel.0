From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC: Intel: Skylake: Critical IPC
 fixes and flow adjustments
Date: Tue, 25 Jun 2019 11:53:35 +0100
Message-ID: <20190625105335.GO5316@sirena.org.uk>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7766505464853236442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98303F896EA
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 12:53:41 +0200 (CEST)
In-Reply-To: <20190613190436.20156-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: cezary.rojewski@intel.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7766505464853236442==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G3Z/XoW3/0g+zQCP"
Content-Disposition: inline


--G3Z/XoW3/0g+zQCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 09:04:29PM +0200, cezary.rojewski@intel.com wrote:
> From: Cezary Rojewski <cezary.rojewski@intel.com>
>=20
> This set of changes contains critical IPC fixes:
> - ASoC: Intel: Skylake: Read HIPCT extension before clearing DONE bit
> - ASoC: Intel: Fix race condition in IPC rx list

Pierre, any thoughts on this series?

--G3Z/XoW3/0g+zQCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0R/SwACgkQJNaLcl1U
h9A5rAf+OMqGUDZJe6WyKCe4+6DveFRKfB350STkSrAgc+6tuz4X3KFlXucZj4PH
OHqW/TfSSeXtqRrcz3CCkAS66kGKrCoodE4y8fQhUkT1reFx/nmNusmXT8sdj8rz
eYT0QFUk8LiXBmaLBLLEQWCItq8TAN3TaPYQq18hR4VtnaQc6uRbUfFRmF4N4PHe
54TOJ3J9ZuK94CjeYWkonueU/94JxHB1F7Z8nXZLkK+gRa2j6LBX7zMzGYue3Z0+
jx1Y1YkRkebFEIw71lAf5oNj2/BS/U1BZzFktW2ECW//3n4zh7N6hBFrvxsVW5Y3
EMqRi/keXF1/4LS+BB/9lxH6wfTNBw==
=WAWO
-----END PGP SIGNATURE-----

--G3Z/XoW3/0g+zQCP--

--===============7766505464853236442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7766505464853236442==--
