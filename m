From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC:lm49453: fix build warnings
Date: Thu, 5 Apr 2012 22:00:56 +0100
Message-ID: <20120405210053.GT3129@opensource.wolfsonmicro.com>
References: <1333639449-25254-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3673947937364052907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDE6424839
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 23:01:03 +0200 (CEST)
In-Reply-To: <1333639449-25254-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3673947937364052907==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eyYj78xbwv+yMvU1"
Content-Disposition: inline


--eyYj78xbwv+yMvU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2012 at 08:54:09PM +0530, MR.Swami.Reddy@ti.com wrote:
> From: M R Swami Reddy <mr.swami.reddy@ti.com>
>=20
> sound/soc/codecs/lm49453.c: In function 'lm49453_set_dai_fmt':
> sound/soc/codecs/lm49453.c:1189:4: warning: overflow in implicit
> constant conversion [-Woverflow]
> sound/soc/codecs/lm49453.c:1193:4: warning: overflow in implicit
> constant conversion [-Woverflow]
> sound/soc/codecs/lm49453.c:1197:4: warning: overflow in implicit
> constant conversion [-Woverflow]

Applied, thanks, though I have to say the fix isn't terribly obvious.

--eyYj78xbwv+yMvU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfgf+AAoJEBus8iNuMP3dTfkQAJZr4iOBJMM2Ij260WFnQKPN
ozz67IZ3Wb8MBPxzeTWs3i4UuGnCktPfooh+lsKFTi/j5DKEOtwNCdBiti1W3seF
7tbs4w/MqDR+D6+/AFiZggOZNrvwSbTaNbmufE+XIHt8feQRDNuLBTgwB7aNrKr9
F6FybUD5IUd+w1M8NhU6v336WsBnjNkgxgDGP34H9rd9eGXgYLlst9fb5rNetKGh
qO7NM+LtYY9hUpycb3xJLAj1FeV9FVyo1+5iCdt1mnEE9Njxl8kGPH4v/A7q96Pn
DyxniYCYSjnDdDHXjnxG/hAE6GOyyueJWpg9d5kf4Ego77QMGSuN2uyd6LxCk2CO
6KgxU5pVCst6ski05HCg2Y9wt6qk8q8MW8DvUPRvSLuYg8SYsyx4cvNrwZW+Idpo
CDrBtAEPWSzEW4IuWNRCYPU3wxJ3uYUzyS2y+nu+Rr1iYc1JC6CpNVzEjYi87zOk
9I/LHvvFJU4UXTvwnizJK0uRtsW8/enSRzGdvXqYNMLl0v+lHZrtn+huxGzst2sr
fQh95DSNshDSA+vKOeSlxp/GKDY0GylRWa+jZNYiIqXq3Pkkuzc49U630SNPTuZW
m5wEygfKsVqYfVV9+1+6+kXyc98pFAaVSptc/PBE15VqDEaJJtcnjpkB5j2oqH6f
VR4RiPD6diay4/HBWMc+
=c5YE
-----END PGP SIGNATURE-----

--eyYj78xbwv+yMvU1--

--===============3673947937364052907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3673947937364052907==--
