From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
	initialization
Date: Wed, 19 Nov 2014 10:56:55 +0000
Message-ID: <20141119105655.GE22111@sirena.org.uk>
References: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6693023075698266295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D91C2260543
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 11:57:18 +0100 (CET)
In-Reply-To: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6693023075698266295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3ND3gJe4e1E4uwh"
Content-Disposition: inline


--z3ND3gJe4e1E4uwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 03:13:26PM +0530, Vinod Koul wrote:
> For ACPI we missed to pm_runtime_enable() call which is required to tell PM
> core that runtime on this device is enabled now. Since this is common to
> both PCI and APCI move it out. Also for ACPI we do not require
> pm_runtime_allow() call, so remove that

Applied, thanks.

--z3ND3gJe4e1E4uwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbHd2AAoJECTWi3JdVIfQM8UH/2sxEfwlx9bLfazYb9/0m6b+
imqfUbI3uZ1CSioO0pkuZMdUmM2hMM/9vhr1Hg0XLuNmCeGhlPftsU2BDy7ZN2T7
UDl4feWu8fYUZ5Rc9FSXmsB+f5TklcP1i+/pX5C4d1t0R8dFi6RzUN8gaOntmJrg
0Abchox9x0BUqhMHxakqjF8Ev2tHyJEAPfGOQFXNZ9SLvNhYYkw4B2/RxAKbwRpI
LeM7asLEv5S4d959SEAjC7uGoeT8aK7kHyYsfqeVvPMgAULyEoQcLwTLS8AgqvAN
XXfj133cccNWI85dlIThEQO2IUPhGMmPe79o3Vjo0QqR5fdzg7exynVIDXw3RdQ=
=xNVC
-----END PGP SIGNATURE-----

--z3ND3gJe4e1E4uwh--

--===============6693023075698266295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6693023075698266295==--
