From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsi: care fsi_hw_start/stop()
	return value
Date: Thu, 1 Nov 2012 14:48:06 +0000
Message-ID: <20121101144806.GO4413@opensource.wolfsonmicro.com>
References: <87mwz3mjou.wl%kuninori.morimoto.gx@renesas.com>
 <87lienmjnj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8260901167131019762=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E470262617
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:48:07 +0100 (CET)
In-Reply-To: <87lienmjnj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8260901167131019762==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GYaKytDE8aa4+VVK"
Content-Disposition: inline


--GYaKytDE8aa4+VVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 30, 2012 at 07:59:15PM -0700, Kuninori Morimoto wrote:
> Current FSI driver didn't care fsi_hw_start/stop() return value,
> and it causes WARNING() call if SNDRV_PCM_TRIGGER_START failed.
> This patch solved this issue

Applied, thanks

--GYaKytDE8aa4+VVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkoueAAoJELSic+t+oim9+80QAIex2Q/8PQmdjmSoSj677F4Y
qO4sAG2hfRmGLDKYAG/1zl2w60qIw1IrG8s9j1uRTjqm2bLIR4mHPvS6tyRz8ZhZ
sRpZ9QOonuCwxHiWyrwocUe0BY0/u4HoO/6PrpCsWuaZdvdRn4HJH6IUXGVLJbFN
DMtD5gxDYb6oi/7foOs4St6jcZ2uvL1LWFbULzgR2xIKWYOAphqmWqiN84B3qA9Z
0ewW6237kPaZd/RblT29To36Q/e8yHliCTADW6xbiDuurq/O9XB0DoyYjnWz8A6/
FJj3Jc11h2lk+4GxTiP1mVqD8Nj6QBPWrrzJKfPngeByopr/ThNBKzl17pQLIh6I
Cj0REfVSiByPUhtHzxO1V1aKYL3VZEgWqfCGgRhMEGslOcBkyvlLsEN6br4yuJ2E
XGPuzA1np0sifay7bbPzou0FGqX7CvhDroML3pIqJYQatVfFeutIhrIudfSVcpdg
mglMVtPtd/Vs/aOScnYEFnDQWapYOplqHhNDd/AdxyDxPDXvRP23kClnaf+EtXml
XoSjixM3r8sNns8GrGFRfcxcfGVqiiV73HkLYpjUjvp9E6Ih6jlTKii179UHH6W9
ZTtcVuXm1Kv8pNwJmpVcxrhTqMnmnfim1BGTfn0NNZy9rIFeMohCulNOj7KoY5Wj
ThekOvh7LtvweO0w36O8
=f7o3
-----END PGP SIGNATURE-----

--GYaKytDE8aa4+VVK--

--===============8260901167131019762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8260901167131019762==--
