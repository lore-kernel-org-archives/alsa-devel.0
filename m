From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_card_name()
Date: Tue, 5 Jul 2016 14:10:52 +0200
Message-ID: <20160705121052.GQ6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <8760tusj2q.wl%kuninori.morimoto.gx@renesas.com>
 <20160629181555.GJ6247@sirena.org.uk>
 <874m8bbdei.wl%kuninori.morimoto.gx@renesas.com>
 <20160701095249.GJ6247@sirena.org.uk>
 <874m861dzi.wl%kuninori.morimoto.gx@renesas.com>
 <871t3a1crg.wl%kuninori.morimoto.gx@renesas.com>
 <20160704085003.GS6247@sirena.org.uk>
 <87lh1hzsww.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8780404543486767105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6857E2665F4
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 14:11:17 +0200 (CEST)
In-Reply-To: <87lh1hzsww.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8780404543486767105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LDTYQ/yPU1fZltPS"
Content-Disposition: inline


--LDTYQ/yPU1fZltPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 08:59:53AM +0000, Kuninori Morimoto wrote:

> > If we try to dereference card->dai_link without checking to see if it's
> > set then we'll crash.

> Ahh, do you mean we need like this ?

> if (!card->name && card->dai_link)
> 	card->name = card->dai_link->name;

Yes, exactly.

--LDTYQ/yPU1fZltPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe6PCAAoJECTWi3JdVIfQAXYH/iIJzDKppXiH2TVvEiAQd8JB
77rn2rZB13lJTFdMr4PnB5SYkJHVwJZMyX8+Af2bsXfElQ3e7csQMFfg+JzRN08O
k4c1vIzGH56Is1qTpTCa/r2rkMmd73S/slffwJsCxnttqWok0TB9LaEODU2q0U86
avKak5E5mE72r9aweHAMyeUctvCK1DnhJEcM6s+kBfXycieSl4rOrJh0naCmnyEm
DUEBYfQjsmaflWCZljq8qX+1UivVeS3R9706xRZC5251DTCqQfxHITqfh/fuMPEz
Vt5xP5JOlbJun8zz8Sm2x0QOcAmREEu+v53IDTdMf6edqFx+uOxc3lbBR2pyofs=
=S3mA
-----END PGP SIGNATURE-----

--LDTYQ/yPU1fZltPS--

--===============8780404543486767105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8780404543486767105==--
