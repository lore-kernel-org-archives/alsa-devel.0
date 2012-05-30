From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: bugfix: enable master clock
 control on DMA stream
Date: Wed, 30 May 2012 10:42:25 +0100
Message-ID: <20120530094225.GB9947@opensource.wolfsonmicro.com>
References: <87r4u8kawm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7860541221076852124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D0C42434D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 11:42:29 +0200 (CEST)
In-Reply-To: <87r4u8kawm.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7860541221076852124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2012 at 11:55:11PM -0700, Kuninori Morimoto wrote:
> DMA stream handler didn't care about master clock.
> This patch fixes it up.

Applied, thanks.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxet4AAoJEBus8iNuMP3dtVEP/359u+hksEL5pP6AHRBIHY6g
PWgceVD5dc0WpjEpy93E6Udn6uY04i+9XGBR3eQDK2u57Hc/Y7d53ME4Vu27i1si
9HXPGMmDSI/z6wlaEa3EEUXEAPj/qkkZs5aKqkZ4e/tveTtWqsfuP9RJCF8ERviD
U5/FUf10QwWjeOVqYgzEIOrQriGkdWah87jnfGFKomX/t2o1eRjrcPwfr/E/hJSG
SJS906xHP0xWVCDctSugnEsuoN8r7izrWogVaSFjkE5TVEkJS1IT0wM5L+jEXZVg
lXyGbpNsGrPk9DRTZXqgxnROwuBu51rb26WrWTB61BxglTPnNfvnBe2Vm8blTrGn
gdlHTdst+91sG8eKyTc6nbArHFVn2K7ArYODRpkKO+Icl4/nazLNbH97CZG+3L3n
d3fBA8Kg04PAn6hAb8ZSCrHa1N59DozrYy7oKlZOiJ4uGlNadgwSvp7qBRYOZYWa
wH3cYNRitoeGAOFfzoTyhPkTSf5HR+muQMRxKunAGflYNZLNAsvjPqNeZ/U2RVDs
z618NdiWLLMa8byv8wQTSO3xRoX+zHOMT3gFTQWSq7jNFr9U6C19VUTt0ABsbGza
t0PCcayaMtBQpT29xPsfArJzoEeCVjylFUa6yeReOMCVgXccInO1ew3ptfHsLpDc
W7kpzyPfB+FE1FTgp0I7
=1zRc
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--

--===============7860541221076852124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7860541221076852124==--
