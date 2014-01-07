From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: soc-core: add
 snd_soc_of_parse_master_clkdir() for dt
Date: Tue, 7 Jan 2014 17:05:38 +0000
Message-ID: <20140107170538.GA31886@sirena.org.uk>
References: <1388630905-1321-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3877368268799898396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B594265002
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:05:51 +0100 (CET)
In-Reply-To: <1388630905-1321-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3877368268799898396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r2/fuxH/oC33tddT"
Content-Disposition: inline


--r2/fuxH/oC33tddT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 10:48:25AM +0800, Xiubo Li wrote:
> This patch adds snd_soc_of_parse_master_clkdir() and supports below
> style on dt:
>=20
> master-clkdir-out;
>=20
> If this property is absent 0 will be returned, 1 otherwise.
> 0 : SND_SOC_CLOCK_IN
> 1 : SND_SOC_CLOCK_OUT

This is mostly OK code wise, though it would be good to use those
constants in the code.  However I'm still not sure about it being a good
idea - it's similar issues to those with clock IDs but less strong.  Do
you have a user in mind?

--r2/fuxH/oC33tddT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzDPfAAoJELSic+t+oim9+AYP/3WOJVaFYod0qh226+S6Pea9
BQTQJI+U3zMri6QgVsavf7M2ZwJUru6oxJTaafVMCuIK6JgHk1zhx5y0zEmLqBtX
4rcpzohrcWfptvTSt6Z/x/r0oh78N5TtbPCnJ79SVjSXmF0F1WpAxjPfMfNW+NHS
+05T6+hVcwji2szsrsOoJ4zwA476KG4MkfxuR1wAJeMil8hKNLfDXwR6dujhxXp/
lFIHT22/r51/3Wm6yXP5q3fakXWvmJYjrJ2PytzUj6vJPHWe9cHc2dllatfcyDDE
Qzs1wGFo6yIoE0J7s92XcVCuDbVFrDWON6UnCX6pyKWwBgKa9HtYsBUOda0rxI4e
91r9+zJZVHX93YSA2v54tWMjLSy7dnMYs8woIreILz0rzRDV1hQaxz+e/VMjCDdZ
O6QbMFFY9LkiuGee+/HeB03EBpQZeI13vXz8B9kIP/O+UNOPWrCI1+8qZI/rOqEE
EPFl3GlD/nB/yNHfinxFoiaTCMs5F3LMXM60HsYz0yV+D8XE/f2F2yqFuyjaHfQt
otMINbH+ekaJTXxRX6m7fqL/6mqalfgr0SEeMTwYY1bnE6IPoWaLUVQyZSKZ+UGg
//rHc2LucalRElmTj9XoCAgzxSLwcnFwRmuJk0z0NWi5kgib4FkQ2MAUS8BQwb4p
roQaupCQzFTeVeUxgsY6
=rA5V
-----END PGP SIGNATURE-----

--r2/fuxH/oC33tddT--

--===============3877368268799898396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3877368268799898396==--
