From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card-utils: add missing
	MODULE_xxx()
Date: Tue, 2 Aug 2016 20:41:46 +0100
Message-ID: <20160802194146.GI10376@sirena.org.uk>
References: <20160801233610.10479-1-khilman@baylibre.com>
 <877fc0hte3.wl%kuninori.morimoto.gx@renesas.com>
 <CAOi56cUjygjOiZ6OwRHXu0XsNMkJHeTB9KCOzTM9mzsuP78GOw@mail.gmail.com>
 <8760rjj20g.wl%kuninori.morimoto.gx@renesas.com>
 <m2r3a7qa2f.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1443378962714352579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12BD6266543
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 21:41:59 +0200 (CEST)
In-Reply-To: <m2r3a7qa2f.fsf@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1443378962714352579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1QGDfz3Tkbtkncdd"
Content-Disposition: inline


--1QGDfz3Tkbtkncdd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 02, 2016 at 11:50:48AM -0700, Kevin Hilman wrote:

> Your patch works, but as Mark pointed out, I didn't think that this was
> the right fix as this isn't a module, but just library.

I think building the library as a module is fine, that way we can load
it only in situations where it's used, it's just that it should be
pulled in by the relevant driver.

--1QGDfz3Tkbtkncdd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoPd6AAoJECTWi3JdVIfQGEQH/38CW5me21biwIM07aA1LI83
1XFWw2jyEflgsbxaa3ibl/jY0igELJzFLM3ShMWvAZAmK/G4RGdWIpKl40kqzc2k
ATQVknSDBdcGF8Kb7qdIeAMUnkKUx6cDbIFLHL2bkcGES+gZA+cfduSZmWQWsiiW
99HONYr1cMvAB/YV46Tt1zJx2OfISULOcxFAMzmLFRi7G4Zk8t8plc/7P8YGLL4z
gAfQYoi1spU1WEKo6I0fCtgs8exWlwRzSsyssB/k6SZwB5wTwDDY7K+kYjTa6z8V
71uSXxDZOIIXu0qSSStDM7Xfr17kg5j5nWrpoa3WCLt9dtpRLi3QdpdDIPDDA/E=
=WH7b
-----END PGP SIGNATURE-----

--1QGDfz3Tkbtkncdd--

--===============1443378962714352579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1443378962714352579==--
