From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: remove original filter from
	rsnd_dma_init()
Date: Tue, 29 Oct 2013 09:30:00 -0700
Message-ID: <20131029163000.GH16686@sirena.org.uk>
References: <878uxc7bv4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1710851725983704374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D9CB82610CE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 17:30:17 +0100 (CET)
In-Reply-To: <878uxc7bv4.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1710851725983704374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 12:52:19AM -0700, Kuninori Morimoto wrote:
> Remove original filter from rsnd_dma_init(),
> and use SH-DMA suitable filter.
> This new style can be used from Device Tree.

Applied, thanks.

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+J/AAoJELSic+t+oim9yOMQAIUmXz7WrDScFb7OHO6NiGJ2
cyJxzWpBVMVF4UBtlDjvmXV63f0yY5xmuHn4W1ijAtRRjUeaXdiPYIJ9FB4s8hfy
5yUii+dFj/Rtr0J8T2XVFIsUJXgyiE3ktopHAlS8ycZdnLAQMtcSpAbauzKTsIGk
mBBsveu0aERHTiJ1uksiHt459JFeC4FcfM+gba/ON8Hm5GvBpIUHmN5Mhdpo85g6
sbnHw/2nduQ13eQuvQJmQbKN8FSZzrSmoJueF6Do71FXdPjfS4tLvejWUGkO1ul+
tuC0ztaKQibo9G+KjMwJT1SnrNHonbtF7lX0iX7Rqk/cdO83rG6IgTtCbGOD9tSy
+QwYifDSdsy1fcLkwpOOzLvEek25jrs/YxcnjwnYimKRrfHJe4tre/i0eRenYMmc
CnvA+0WECNUJ1mEFFjiFNt6Cenb7xRNhz7Z8UCPMXxxs0ZgpqB6tZPzJ+Jx3cO17
b/XCLnTnxew8Tws72rT/WtYmNkbe+bjTnQ/8gl1LUI6aFPFdXN41hhTal35sqURA
PUkSlSaEl++25elyb3JlY39thGc8D9y62+5bfOI0GKNglY2PN3vOIjl8A2VBqfwa
3c309ixCHXySCfHIFET0cNFAsPDwTruNd3MgB1QsATb7Ht6mIH3wOgSVgfDM8MGi
jJSCqDe5Z/oiuJtOUrqq
=n82E
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--

--===============1710851725983704374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1710851725983704374==--
