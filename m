From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Revert "ASoC: Intel: Skylake: fix
	memory leak"
Date: Tue, 5 Jan 2016 11:46:22 +0000
Message-ID: <20160105114622.GY16023@sirena.org.uk>
References: <1451994364-29338-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2208400737271976929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACE722606C9
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 12:46:29 +0100 (CET)
In-Reply-To: <1451994364-29338-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2208400737271976929==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="We3kTPdwkBGsLLkt"
Content-Disposition: inline


--We3kTPdwkBGsLLkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2016 at 05:16:03PM +0530, Vinod Koul wrote:
> This reverts commit 87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1 ("ASoC: Intel:
> Skylake: fix memory leak") as it causes regression on Skylake devices

Please use subject lines matching the style for the subsystem.

--We3kTPdwkBGsLLkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi60OAAoJECTWi3JdVIfQwroH/3ZilT8ub+7NfdNTJ60JTsfe
GTspO4fysLwrzDLShwx7Egx9nZOpf+JBpcrufejGYruy0PtY53if26ma4CizXdVG
l2hmGq0NZ4b6SWJxOt2SwSOw7FSwNf3il0r1lT/2x04/Y/xkyetKlv5RelJYIbtR
dkm819dfSHGa0cqft9stJ7SC9fA55lbJ5AUjxKO/R8QIwSdTz0yiaWd1dNCNOknG
UCwirQd5fFcGR3mTW/2gnv4sCtQWMVeMAHyd0Z62gPrTh3z/klxLV/T9ynLzn9ki
S0kIemyXn8D1hDCJoaqGe53dgHzghUBAQ1imqOfYwKnGWWKWFS07rcl8Yw+DAAA=
=nvex
-----END PGP SIGNATURE-----

--We3kTPdwkBGsLLkt--

--===============2208400737271976929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2208400737271976929==--
