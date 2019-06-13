From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: SOF: acpi: add module param
 to disable pm_runtime
Date: Thu, 13 Jun 2019 19:48:01 +0100
Message-ID: <20190613184801.GV5316@sirena.org.uk>
References: <20190612164726.26768-1-pierre-louis.bossart@linux.intel.com>
 <20190612164726.26768-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362548349541301904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFBFAF80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 20:48:02 +0200 (CEST)
In-Reply-To: <20190612164726.26768-3-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0362548349541301904==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JEhTuUFIcUlI65CC"
Content-Disposition: inline


--JEhTuUFIcUlI65CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2019 at 11:47:25AM -0500, Pierre-Louis Bossart wrote:
> Add debug option to disable pm_runtime. This is not intended for
> production devices but is very useful for platform bringup.

I can't immediately find it right now but isn't there some generic way
of doing this in the runtime PM framework?  If not it seems like it'd be
a good thing to add, these can't be the only devices where it'd be
useful.

--JEhTuUFIcUlI65CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CmmAACgkQJNaLcl1U
h9DsjQf+LtqUER+EEmHDYsd+yR4kTcoHOm262gYqnkmFSg+EmO0g94yWkvXcTt64
1nSe4v/Adda6CFR2RjQrd5Dab2xSSmVSgqWWTIaINJ3+ZE2oO7zYuLnmbLYSPSk6
wnjKlfefKYm+eCvWFrE1CSdqtNfOPZ0d0sBqV0xMztPlqe6FaXN91fzU3eaXigrD
nwK2dXeCaZho6ne1LbkBoyprWDcjHk6wNICOJKbHDkNVL3KLPsjCTqQMxR1TIqwf
OOsUNZs9ymrTq5/JSP9tqnmjT2x0ko9tMAcwB/6CCAfTOPMO/lD8EUS9WINk+A5T
uwSGciepCLOfs4Mz9PtXpWLgGPnYlQ==
=SpwH
-----END PGP SIGNATURE-----

--JEhTuUFIcUlI65CC--

--===============0362548349541301904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0362548349541301904==--
