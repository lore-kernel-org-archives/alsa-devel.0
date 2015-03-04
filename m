From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: simple-card: Add support for
 samplerate and samplewidth constraints
Date: Wed, 4 Mar 2015 18:42:14 +0000
Message-ID: <20150304184214.GV21293@sirena.org.uk>
References: <cover.1425303942.git.jsarha@ti.com>
 <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
 <54F4C0F2.8000201@metafoo.de> <54F5884A.1090702@ti.com>
 <20150303113041.GM21293@sirena.org.uk> <54F5A25F.6090904@ti.com>
 <20150303153431.GA21293@sirena.org.uk> <54F6BAA8.2010803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2892341547360470708=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1575526530F
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 19:42:25 +0100 (CET)
In-Reply-To: <54F6BAA8.2010803@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org


--===============2892341547360470708==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iaFP3WRQOnUHNoA6"
Content-Disposition: inline


--iaFP3WRQOnUHNoA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 09:56:24AM +0200, Jyri Sarha wrote:
> On 03/03/2015 05:34 PM, Mark Brown wrote:

> >>I am wondering if there would be some better way to select the dai-link
> >>configuration than writing it to DT or creating a custom machine driver for
> >>each setup.

> Continuing this tought. I wonder if it would be better to introduce a new
> compatible match for each new card, with some clever way to manage the
> accumulating matches in the code, and hard code DAI-link configurations for
> each match. This way the old configurations would not be carved to stone in
> the old dtbs.

I would prefer that, yes - if only for override capability.

> As there is a proper way to deal with this, I'll look into that first.
> However, if there still is a need for these properties I am happy to finish
> the patch.

OK, a proper fix is of course better.  Might be worth looking at tooling
to make it easier to find/use but IIRC there's not a lot doing there.

--iaFP3WRQOnUHNoA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU91IFAAoJECTWi3JdVIfQBaYH/iv3SMSG65E7H+81CcPtZWzl
4ct3ArkJctZM5jCQVGOrqrAtvyAcBmEiazpKAHbPDawD1fqHSd0h4IFspWTcjQ8z
+PZ6cc4wv+qcRKwuYcOU+E0htG77LpuzfsZdAmA6Ql7JQ12RmOuR1zd2D8F6S1xN
L5yMB9s4M0U6MzM9PR+An5OctGrejX037gtMDtLdVHXIhMKPIzGqetutca3iYY+A
Mcos2Bk1lv4lK82BHz6rBQs68DrsWIdmhG8j8MmiPHJZ83Qi88KGcznVmNi1q9NG
evPB8H6J5NdgKz7s81erryafn6A71lBSD4M58ChuKLNlFGPwR5QE8al+HeAp9Os=
=zpgN
-----END PGP SIGNATURE-----

--iaFP3WRQOnUHNoA6--

--===============2892341547360470708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2892341547360470708==--
