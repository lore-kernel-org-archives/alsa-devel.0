From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: add
	snd_soc_register_component()
Date: Tue, 12 Mar 2013 19:40:35 +0000
Message-ID: <20130312194034.GG19942@opensource.wolfsonmicro.com>
References: <87fw06ace9.wl%kuninori.morimoto.gx@renesas.com>
 <87k3pdtnlk.wl%kuninori.morimoto.gx@renesas.com>
 <87ip4xtnka.wl%kuninori.morimoto.gx@renesas.com>
 <513F71BF.3040608@wwwdotorg.org> <513F7AAB.8040401@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6270725691237938623=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 45DEE265D97
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 20:40:40 +0100 (CET)
In-Reply-To: <513F7AAB.8040401@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6270725691237938623==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IRIOLc8eTv1AOxGv"
Content-Disposition: inline


--IRIOLc8eTv1AOxGv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2013 at 07:57:47PM +0100, Lars-Peter Clausen wrote:
> On 03/12/2013 07:19 PM, Stephen Warren wrote:

> > I wonder how much work it is to convert all users of
> > snd_soc_register_dais() to this new API; is it worth doing so?

> If we allow the component driver to be NULL it's pretty much straight
> forward using coccinelle. Don't know if it is worth it to conver them all
> right away.

Given that it's automatable...

--IRIOLc8eTv1AOxGv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP4SfAAoJELSic+t+oim9efoP/0DwlYP4d9xC1M3dCuNhD5fS
3Qm3faqk8IBUop+qn1YGKOypYR8nQc10OPLF7vxhRIxOdkBMI8MhKMw2agBe3SHa
g4bF9nLvZec33hRjJIzIcL9MW1QN6m2GZStgTAwJga6xYNBjYgSj4QB5UFt2NgsH
LO28mBhQR6N0NXiD3bTKkMxeM2u3D9r4fQ5rmDu89GJ/9AKN0+cJHfY3rFQx8inV
h7D5/tp1OCADEAHXTcDjwqnfIOJjpVuUZ07d1iF/ji4DSLGZKiTM6FNfXmaumpEp
prh1LSmZiPcLYrTYdx/wPkNw/m3KIun+7psWiy6TK762iTVUOFs46y1uEqlQn+n9
CVXg4RId3/iIuziaMSdgGiHD/eg0r8xtc2yXvkNkL3IEUzs0X51hYnE0QVcEZtOF
gl+f8k8T9W5tuAWHPbWVMJAfnr6etc4HGR6HOAbd4ckfDHn/03ihBIjxWFyL9Hz1
+BG/+vujBCCCLB642YiSBcHaoKRc79N9s2vIHC11wCH99F+C3s5/dE6dp/ml/meD
FEIt6LRqRonKTTRJ487WJ2bIYeCoU2OTZsJqYqo8w5eQi0wBoKRbPSkawPjzlqbA
X53s49h8J11nWvneZA7JEH1VL130I5/yoTiR/PuVePBXfiIJtkede203NVsdB28X
QfuTkmNgLipwhstRqPGO
=AofM
-----END PGP SIGNATURE-----

--IRIOLc8eTv1AOxGv--

--===============6270725691237938623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6270725691237938623==--
