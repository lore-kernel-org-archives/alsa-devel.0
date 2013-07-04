From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: add Renesas R-Car Generation
 feature
Date: Thu, 4 Jul 2013 10:26:36 +0100
Message-ID: <20130704092636.GM27646@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <8761wuixf1.wl%kuninori.morimoto.gx@renesas.com>
 <20130703111034.GI27646@sirena.org.uk>
 <87bo6j1706.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7956928736668639398=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B0D102656B3
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 11:26:40 +0200 (CEST)
In-Reply-To: <87bo6j1706.wl%kuninori.morimoto.gx@renesas.com>
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


--===============7956928736668639398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SVaud5yhx+5ISi+J"
Content-Disposition: inline


--SVaud5yhx+5ISi+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 05:52:28PM -0700, Kuninori Morimoto wrote:
> > On Sun, Jun 30, 2013 at 11:53:10PM -0700, Kuninori Morimoto wrote:

> > regmap?  I don't know if the new regmap field API helps with the fact
> > that some of the registers have been moved about.

> This rsnd_gen_reg_get() is absorbing Gen1/Gen2 and
> ADG/SSI/SCU/SRU mixed register mapping

Yes, what I was asking was if that code is reimplementing things that
are already provided in generic code.

--SVaud5yhx+5ISi+J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1T/JAAoJELSic+t+oim9V7QP/Apk078RsY1AawkmubWU5kHR
yaKIz08lihV/PRPBZ+/OGYGPX/difynSa9PMo2mZRhVlYMpabocoPrun9F05uTP8
O73PrtF3hYh4jHOkAQ9O4B4MLEXH1H2QBS/HhdUifpBZZEEv3Xmw4Q0TO/mrI6MN
DQ2/EIHqHoXNHcQuzzuUoDXHpQmAuAaWlc+2eTm+w6cqy/6F2hfwd43dEp7epsTg
bl6nBxMGZOB9Ktke9q0oRqC935L/jhBbSE/Wi2puxrJklFEf3HnIJB8/O25ZBUif
bYUo2UZRA36pFlPafzm+5rTFWYcfDR9GNXSHkH+ZNRcVvqdPqCG8TjGD24hGAKOZ
30S/7GODa2VEpbawSuuLl6IVKc+xqpXPkF53cioOlDGZVNhS4cG21VAbleMMe+dy
MmCSJ3dUhEHif5YNl2uDimqjZPO2vocqc+EjbbdZcHuPk3t9UJmPR7y5UMk6H8YE
n7n81CDEpZzcHW/SGIzSHtd2XCZqLHYpSArgNr4+NugnESjrIGG1z1tqrcSiXT3S
vO99xsUEy4t0/qhIFju4SuEK5laNLul1Ak+Vf3p2qPjSbukBeUpV5nfFgJT4PZvm
ZNYCiarcfe8/dM5AMD3Pu9JtIRoWuQH1zukyb3TDbW3/aEeaKgB9XmCqazmcsSc5
qkjv6ebG0CsRE86uOreI
=yiSk
-----END PGP SIGNATURE-----

--SVaud5yhx+5ISi+J--

--===============7956928736668639398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7956928736668639398==--
