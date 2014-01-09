From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm5110: Add controls for
 headphone short circuit protection
Date: Thu, 9 Jan 2014 13:30:30 +0000
Message-ID: <20140109133030.GM31886@sirena.org.uk>
References: <1389271441-21046-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1389271441-21046-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3061170478364556949=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 726AD261A8B
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 14:30:41 +0100 (CET)
In-Reply-To: <1389271441-21046-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3061170478364556949==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SgAYzkuV7cEXWXHw"
Content-Disposition: inline


--SgAYzkuV7cEXWXHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 12:44:01PM +0000, Charles Keepax wrote:

> +SOC_SINGLE("HPOUT1 SC Protect", ARIZONA_HP1_SHORT_CIRCUIT_CTRL,
> +	   ARIZONA_HP1_SC_ENA_SHIFT, 1, 0),

Boolean controls should be called ... Switch.

--SgAYzkuV7cEXWXHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzqRzAAoJELSic+t+oim968EP/3ZP5zUGUktYrjG563kQtTz4
+K6YRZH0Nyy3meAwCu/F2asYsz8Xax2C407KS/Y7z01UkvbgJYv72YuFqF7hiC2d
9HcBLBSQg8KRSRRI6ldmq5jQX8Un3bB8i7H9XwYWgr8VeE14dhs4SckrVAw07c6A
1odUUHzJdEv5j/sXUiY1zz7pCfWpKKlVefaXVNFYmTTYSSPFC9OtR1/43Ah4MW/1
5Z6xj5glkw0b1p4P1p5gg8DNOtRbnqNh62TqDm0goUntNVg4A5bTcgBHV5yJRSAv
MzU7Ln6qIsqwNSMbC2XwW01nAXQlNHvl0HK3tR3h2Cbg7xhm6YXzTsoAMZPWKSFQ
U2icMp1YSDgK1VTjksmtRtR5bnsxJGsOZIaofWDnbUvowH8VJjmuxbS/uHiRkNaQ
pMGkS5YQz+yYk1weUT5G0maLtlsx0mfBKljjxGZeF9h4ye0CMxjM2LIZ0vDwjtKZ
qTjdmjo9dnk5XL3wv4VJY/0SSL0tSOXBGhOv8JtVSsr+V0xMhXHejvOdWdrs7B3O
Fk7c2nZLZfbl9TGxahg2dCOqIzAhqO0TKJUY3JpGwJtVoP+RXJu9S5cqhaxPSPeB
1OxGZGXZ5gQKo70V/WaI9549tqFKryQ7nxSHbMr6/XONackkwL7lvhhPLTyZULG0
XB8Rspc+XOhn20SraQP2
=I7qG
-----END PGP SIGNATURE-----

--SgAYzkuV7cEXWXHw--

--===============3061170478364556949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3061170478364556949==--
