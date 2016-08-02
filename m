From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card-utils: add missing
	MODULE_xxx()
Date: Tue, 2 Aug 2016 19:11:14 +0100
Message-ID: <20160802181114.GG10376@sirena.org.uk>
References: <20160801233610.10479-1-khilman@baylibre.com>
 <877fc0hte3.wl%kuninori.morimoto.gx@renesas.com>
 <CAOi56cUjygjOiZ6OwRHXu0XsNMkJHeTB9KCOzTM9mzsuP78GOw@mail.gmail.com>
 <8760rjj20g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8245293031005226999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BBC9265D6E
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 20:11:32 +0200 (CEST)
In-Reply-To: <8760rjj20g.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============8245293031005226999==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LNKrWK8T5LDJo+fl"
Content-Disposition: inline


--LNKrWK8T5LDJo+fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2016 at 03:22:08AM +0000, Kuninori Morimoto wrote:

> +MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
> +MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
> +MODULE_LICENSE("GPL v2");

This lot is what is needed (well, just the MODULE_LICENSE).

> +MODULE_ALIAS("platform:asoc-simple-card-utils");

This is wrong, this isn't a driver but rather a library that's used by
other modules so it shouldn't have an alias.  The aliases are there to
let modutils know which module to load for a device that it sees.

--LNKrWK8T5LDJo+fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoOJBAAoJECTWi3JdVIfQ4EgH/0U85U9z5Es3porYH6spltCw
pPyhZkxcEQWFr6x/oJWLCl2uLGuUdZ1Lb2cCJo+vgir7EwjO1tsvv8EikCbEnlhc
eKBv82IteGSKpZcmCLUcrmUKcyclinty4bDnYMdgR5zabIY3gi6TTx4x0GgAnbYY
5qlDzaITHTHjXxd/vBrXeCJXoV6gT9f14H0nt/vNyIMh9HCb208lC1hW5A/J5qUD
zuhQdt+l0vwyeQBJBLzteMS0Lq59j704KpV2drn6oXFRPoX015NHLOEDTLcfdzhA
Dh9TjvIFRYyRSVnoh+cOq2K/kFU4IW7aMIuEUijOy6AiFLCkR3THLn56cl2hqug=
=iZcW
-----END PGP SIGNATURE-----

--LNKrWK8T5LDJo+fl--

--===============8245293031005226999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8245293031005226999==--
