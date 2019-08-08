From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Thu, 8 Aug 2019 22:33:11 +0100
Message-ID: <20190808213311.GN3795@sirena.co.uk>
References: <20190808095715.29713-1-tiwai@suse.de>
 <ae7d32fe-a279-8309-2370-1832edcce413@linux.intel.com>
 <s5hr25vhg22.wl-tiwai@suse.de> <20190808190343.GK3795@sirena.co.uk>
 <s5hftmbie9i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4928947547696254627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 164F6F800E3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 23:33:17 +0200 (CEST)
In-Reply-To: <s5hftmbie9i.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4928947547696254627==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Content-Disposition: inline


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2019 at 10:38:33PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > I can do that easily enough.

> OK, I pushed out the branch topic/hda-bus-ops-cleanup.
> Please merge this one and topic/hda-dmic branch into yours.

There were some conflicts which hopefully I resolved OK, it compiles and
everything so it can't be that bad right?

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MlRYACgkQJNaLcl1U
h9DiXwf/ZTczst1ezjK7W+0tEDc74yWuvsSH2RFmprD9jwicQTkfsr4tYSXrooQw
7HAc3zweDmtuiLy3+YxnR1ArStpnpicVjHXevCqtQ1FgKQBxETv0Sr+d6N9ptkpU
Xgj5kQwcMVEtNzRo/Byn+58cBbR1CB4lZjly7vfJ7WXmL9C0OKHQwiknzS0Chx1O
T0mqi1DZWTTzHn7NdTIH9qAI0zZCBWD1wmE4YTsaT/ftzbMoxKal5B9ax7p5XaIP
R4N+Nw889bBEWR42Hrpw09Cq+TrAH+LaV0GB2tp1343sLL+lNeoFNxC1IEZHdEXG
W3OBo6juE/EYv7gGhsiAxZxf5/ZQgw==
=vi1U
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--

--===============4928947547696254627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4928947547696254627==--
