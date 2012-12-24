From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFT] ASoC: lm49453: Fix mask for setting
 mode bit in lm49453_set_dai_fmt()
Date: Mon, 24 Dec 2012 15:32:36 +0000
Message-ID: <20121224153236.GC30837@opensource.wolfsonmicro.com>
References: <1356052760.9177.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2778774728663077975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62156261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:32:37 +0100 (CET)
In-Reply-To: <1356052760.9177.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, M R Swami Reddy <MR.Swami.Reddy@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2778774728663077975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 21, 2012 at 09:19:20AM +0800, Axel Lin wrote:
> The mode variable is either 0 or 1.
> To update mode setting, the mask should be BIT(0) rather than BIT(1).

Applied, thanks.

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HWJAAoJELSic+t+oim94aMP/iKMlVqe44EParz3hmUwmeCJ
X6QlqxXpaHiPgPwVdE4NYQ0o5dcw+P9nmPtPM9dflxap7nfLE6NxUj2fEz8GgM5x
7gdgSSsA0Moerou5kgWl6gzR5qvtDt4seOGpOtEnB5gMvYBmqk7TRVUZs7KqEfJa
WOSw7fO3Q/9ZT6+H45ZiF/gBcXEDsnvpXPXUP8klGGUTYyAuRErKQtdZKKOnYx3O
qIlGxJpq6p0XGqMAXEL1fvEycTjw+Qnmw6zeM4LwdeUhrL5YAT9N9BZ4FqdWbnLT
p76++eipGpuYdrQSplnvQ2nu+6twGT1JbkND+u3OFzb/vResFcmkcR0DtA3g61op
PtPLqxRjDZ+kCOPN320IFOBNu7Rka2hjBTROeEAste72nmp+JULV1m46RiSYVarm
2LRPbHfra+K28Oj/pt7KIm9I2lOCxvqJuqE4jleCV7B8XXCMy/v+jEA4jNpoDrLv
YvGV7RjVVOFBjrooSkHEJtwFnOuq07vNzc+zBOGNtyynRnRJWJofeM/YXlX+qMaC
UhasiDeMvrCzk48BJ3uS5lyTjFsAoa3eIZXVueRdlp5tcxsZxEW15fxttAt+QxpH
1lhatyMlkKEWxbZFInz/ugOOcyNjFuc/iMt+hjWtLgjqpmtqmDuYTwZ0r+niTT2a
9UfIFnuSJ5610ei3LVx6
=XIOj
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

--===============2778774728663077975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2778774728663077975==--
