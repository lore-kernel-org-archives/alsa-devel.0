From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: Intel: add a status for runtime
	suspend/resume
Date: Thu, 5 Feb 2015 18:05:36 +0000
Message-ID: <20150205180536.GE21293@sirena.org.uk>
References: <1423148208-2767-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1043866285379236232=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F082260530
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 19:05:41 +0100 (CET)
In-Reply-To: <1423148208-2767-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1043866285379236232==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="14bM4CotJTQANPRw"
Content-Disposition: inline


--14bM4CotJTQANPRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 10:56:48PM +0800, Jie Yang wrote:
> For runtime suspend/resume, it is some different with suspend/resume,
> e.g. codec power supply won't be switch off, codec jack detection
> still working(to wake up system from Jack event), won't call call
> snd_soc_suspend/resume, etc.

Applied, thanks.

--14bM4CotJTQANPRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU07DvAAoJECTWi3JdVIfQvugH+QGNSouAfhE4fDwtQ2aORFcO
VQtvSVqjm3mzQbndV1mCZFksJBOL2iYL2zV+EC7NTUaGA2HySYDm0V+2r6wdJsN7
qR/kWYwKX00VZ97neRyDwRyX04WEhtaHY15J59ZAzl+PYiIVVD+rUx99wdbQD+2v
jFAXsGNDOV6nIF+0quYYHlFprb0ekyJgKgSeVczoR5NrVSE6JYR6QaZ9clpJq/sp
rArwN1ozyBI3wj0/prStHEknb7CSpP0gsOr587X1XLTwCgnGHsVsMIdW2ELJuSPq
8bTGYx2tzgkJR0JBj0ecCukpZLpDDltNlIJ7i4IdCtgCr9eYlDcSs9ApouG4HyY=
=CAGc
-----END PGP SIGNATURE-----

--14bM4CotJTQANPRw--

--===============1043866285379236232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1043866285379236232==--
