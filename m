From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19 v2] ASoC: fsi: fixup fsi_pointer()
 calculation method
Date: Thu, 9 Feb 2012 10:56:36 +0000
Message-ID: <20120209105635.GB3058@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
	<20120203115522.GG3151@opensource.wolfsonmicro.com>
	<87k440x0ft.wl%kuninori.morimoto.gx@renesas.com>
	<20120206164644.GU3070@opensource.wolfsonmicro.com>
	<87k43zv6uc.wl%kuninori.morimoto.gx@renesas.com>
	<20120207112959.GF3332@opensource.wolfsonmicro.com>
	<87obtayynm.wl%kuninori.morimoto.gx@renesas.com>
	<20120208115024.GH3120@opensource.wolfsonmicro.com>
	<87vcngrfgp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5355202271981844472=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 095AF243A5
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2012 11:56:39 +0100 (CET)
In-Reply-To: <87vcngrfgp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============5355202271981844472==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 04:57:29PM -0800, Kuninori Morimoto wrote:

> I guess you will got some conflict around this fsi_pointer() when you merge.

Applied, thanks.  I'll try to make sure that the conflict resolution
looks like your original patch whenever I merge up from Linus' tree so
hopefully shouldn't be too much hassle.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM6ZHAAoJEBus8iNuMP3dDrEP/2QOshYdY0Ej7XlxF2NHo4dw
t+Fw/pcSGgVooInJZCL8wOdU/rABbdf54nV6OLOWmit/+/77uQM019h/AowsXZhQ
fPn8bFZKRmwTRVwiUH3alkClaZYuy+4e0wlY42Buh/4QIx4m/7Bqmudj5zo+lfhI
pjaEtfDC+Hoy4wewuVR4/zI/gg/1kGS+Glp9r1SXOdO5adSk2cOO9mzPcVM717sm
wiJnnnyA+b8ckRU9D184+Kn/St+JvseB31fR8tUyUTqDQSsEzeG5n3CIMBYRFfe5
2Ny+hxZxhYHMB7aYMh+L/w1xrzMX/V8kpWPJ/bkILdfcBIDfPPFJWrNyuQFLHUbu
JCeOkV7mcu9yEQIuKotFaG1prOedwkhZlqjWN682sxjIybcM+OoWPG93OmZW5SS7
IZpq/Ajbon8PYgvXicExZA6cd8lp1f9UvG2cdD1m2BcsdqPtbLO0Wr5SeveMqZlx
+KZlN1gBGu7m9UEhbwe287IAGNvJLXnT/+pTXnEYc9HuKqgfvKr8zU3Lfl2HNUgl
nGs4U4LHFMmfPSgb58cAzb5HoeYYXKtfrHDpbKIPA9brHpLrZt2VUzdemqcSEShB
n03FV10DeKe3aJZ02Yq8a3anZfMDv4AlhIerrhAWYMZDTEUD/kRGBv8joSXewZbX
+rDC0LE562Czki6Q56lo
=87Qy
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--===============5355202271981844472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5355202271981844472==--
