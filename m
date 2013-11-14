From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Turn on regcache_cache_only
 before disabling regulator
Date: Thu, 14 Nov 2013 17:05:13 +0000
Message-ID: <20131114170513.GT26614@sirena.org.uk>
References: <1384401561-10539-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2036746124022298859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C27D261A2F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 18:05:20 +0100 (CET)
In-Reply-To: <1384401561-10539-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2036746124022298859==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcSDOt7TZFizttpn"
Content-Disposition: inline


--ZcSDOt7TZFizttpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:59:21AM +0800, Nicolin Chen wrote:
> It's safer to turn on regcache_cache_only before disabling regulator since
> the driver will turn off the regcache_cache_only after enabling regulator.

Applied, thanks.

--ZcSDOt7TZFizttpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShQLFAAoJELSic+t+oim9mu0P/iMCFOVhNWfOql8rE6L/yzUQ
sJuai76OGoSjsAJX3VfaI3MMLg1PTpvk3d724hQzeXjLM5VnIvsouqhPCE8ZdwCt
1sPhH3W/1m9+W8A8593Z3RPmAu27cH9lWsxovToS8RyV5Brqm5TgNek8yzPVSWUB
BWomq/RwHFJ9mTShtEFLc9QFFhziUUKEaG3bTixchJLdKWy5J843ABuPqa7PjrSo
Zf4raewgEh7n0b5patyLGdwvrosGZQkN0WvpQPUqXLSaKFSahZHEZIK/rLdOXqQg
SNsOFZSYqkps3TrxrrvDD0+QCbWb1hTJ3ATYidWToymGtjGuTIBizhYS7yR3z+dV
gZWmJZQlsQZ5hbJzfAbcPuQr1btb468bMMMGJri+yvmJuxxX0RF1DL3g95CUl36T
DoZtyW/qk+FigyLKZFtFnbuGyLrvR68XFMBeF+WqAGOLl4+EXotI3K++qCLVYU5w
BvFqx1NloQ33ip9W0vrlAUuYeh0pgWfm/yFwx0wT7Du91hpss2Z1sehFw6mWMoIx
qI1mUODm7TQvve7vwT1zzHjaa/tjl6juIOfE1PoW/H2d3Esn3pSfTMNVEtAj+jtF
srcckQa//L1tCH2xW+/qmJCgkaDdzlrkqQ4CsUNCijaqlLeTIqNNZtHma0GRVGvb
VDqmrgCHX5oOOFeCU+uQ
=PB3N
-----END PGP SIGNATURE-----

--ZcSDOt7TZFizttpn--

--===============2036746124022298859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2036746124022298859==--
