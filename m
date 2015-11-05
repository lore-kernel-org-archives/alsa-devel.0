From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix stream_name conflicting
Date: Thu, 5 Nov 2015 12:07:07 +0000
Message-ID: <20151105120707.GC18409@sirena.org.uk>
References: <1446596019-83464-1-git-send-email-yang.a.fang@intel.com>
 <20151104112623.GY20228@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718E3B2A7@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8872568167246738926=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD113265B3E
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 13:07:20 +0100 (CET)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718E3B2A7@ORSMSX113.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fang, Yang A" <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Konno, Joe" <joe.konno@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "M,
 Naveen" <naveen.m@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8872568167246738926==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 04, 2015 at 10:14:23PM +0000, Fang, Yang A wrote:

> Is there a better way to differentiate the name in route map?

You need to differentiate by scoping within the device, consider what
happens if you get a second DMIC added for example.  We can't do that
right now but it should be simple enough to add fields to the routing
information that allow a dev_name() to be specified.  Is that something
you can work on?

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO0ZqAAoJECTWi3JdVIfQu20H/igic39wWZr0ccsaju/tDTs6
7lf3smo3EaUMOpcytHPhE5kdtmVd6+ILOmLllJNzIE315xqc0UlsN1ZIBsHn4j3o
OtqP3v1Rnxr2uSbzA05C+uyPcvj+D8bWOWvH5hSez12IrqzGX51UTLhC1QMumPZn
FP536udEyLRhRUYZ99frSzcTj+tJ0top8lwNRV38/WhjGySEwGemSAl0lMe8buPY
i/54ve7BGrR+lMWpIHyBqRnwhQAnE/6uUt3aZRMS2vQZeh2O64PwgUa4xB5nG+R6
2pr+/g1Wy4aL7GmvOY03sjCtqICqjMe7RtveM/A2CUIhvxevsCsYbwO6iPp7/uA=
=ZaOo
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--

--===============8872568167246738926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8872568167246738926==--
