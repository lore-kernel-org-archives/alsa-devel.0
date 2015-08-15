From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Sat, 15 Aug 2015 09:51:47 -0700
Message-ID: <20150815165147.GJ10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
 <20150814203428.GR10748@sirena.org.uk>
 <s5ha8ttypc1.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D04D0@SHSMSX101.ccr.corp.intel.com>
 <s5h37zkzk2x.wl-tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8480D056B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5781316243252319106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B9952654BD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 18:51:52 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8480D056B@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5781316243252319106==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yEBrs0e8Ns0RDnuy"
Content-Disposition: inline


--yEBrs0e8Ns0RDnuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 03:25:18PM +0000, Lin, Mengdong wrote:

> In addition, does "disable this API/ABI for 4.2" mean disabling all
> topology features, or only some structures for v4.2?  But alsa-lib
> already integrated this ABI version.

I'm suggesting not including this at all in the v4.2 release so we can
continue to make changes, or perhaps just leaving the code there but
making sure it can't be used as Takashi suggested.  alsa-lib hasn't
released yet as far as I'm aware so we can continue to make changes
there.

> I'm worried that If we have to add new fields to ABI structures, how
> to keep the backward compatibility.

Right, it's tricky - there's a bunch of techniques like the versioning
that's in the current structures but they all take work and effort.

--yEBrs0e8Ns0RDnuy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz24iAAoJECTWi3JdVIfQJWcH/RSyLYAxuDAVaK7gl3585zIn
mh1HeVtXppRd9HcHurzBTJGtrMkhY9mceHlVwqeb4xsg/0+PiCiTgSWWM3QifNxk
wnybqokx94kwNbvhsmV9k4qBzRCA5pnm7bLF8toyJQQHLy9LIAs7TqmpyP6voESr
Z9u0DdRX6OdcSmqH6rdx2nDYdloHm1YZfizAoHY2+j84+SR4+vpnqo8W/PuV3WTR
qPJ7NYOZo28VP7PksEnsiXeiXs8Et8ViFOgrFZLWARLDCGli7XMOlWuGcKMBN9bT
NmgS0K28g/uljY9hweoZCZ6up9cOgnuigustUQaEBwNpEtaNIpr8Z/ZWMbUC9Yk=
=xk6P
-----END PGP SIGNATURE-----

--yEBrs0e8Ns0RDnuy--

--===============5781316243252319106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5781316243252319106==--
