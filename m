From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: fsl: Add VF610 soc audio card
	Kconfig
Date: Mon, 10 Feb 2014 12:31:24 +0000
Message-ID: <20140210123124.GW1757@sirena.org.uk>
References: <1390453370-29194-1-git-send-email-Li.Xiubo@freescale.com>
 <1390453370-29194-2-git-send-email-Li.Xiubo@freescale.com>
 <20140123183829.GB11727@sirena.org.uk>
 <88ad355def5f440eb92ca921b17aabb9@DM2PR03MB509.namprd03.prod.outlook.com>
 <20140126124313.GF11727@sirena.org.uk>
 <d774da5b38ff47b6a350d92d1ffb362a@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3915068459167556849=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B8402610CF
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 13:50:56 +0100 (CET)
In-Reply-To: <d774da5b38ff47b6a350d92d1ffb362a@BY2PR03MB505.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3915068459167556849==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wt10+cXOThorkX0z"
Content-Disposition: inline


--Wt10+cXOThorkX0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 04:12:19AM +0000, Li.Xiubo@freescale.com wrote:

> > My patch was "ASoC: codecs: Make OF supported CODECs visible in
> > Kconfig".  I can't remember offhand what the patch for i.MX was called.

> Yes, found it.

> If so, shouldn't the CPU DAIs(such as I2S) also be invisible in Kconfig like
> CODECs ?

Yes, they should be getting made visible too when they can work with
simple-card - that was what the i.MX patch was doing.

--Wt10+cXOThorkX0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+MaZAAoJELSic+t+oim9PPsP/1TOvo9IJ7Wu9LgaYNPxXMU4
cZbc9YcQoPRgMBhIwofGhDVZs74xi5tiQhQ0ib2GZp+xE3JB2DN+XSn7PJ7cWDSL
B0E8rqoAkWAxUohLMrX9asRrk7naHWc1vYQOmKCgxYW7srZEXLuhnWlRdBlIDWPX
aRkzcPGMUjtD91eF13tfRxKnoHvDQfrLlY5O6VGjqVBTOdxKKNPe65P7DL0407jj
w9guocX+vM7V6GpUSRztG913crpKKml88Q/KE/rNRBOmQ9w5ER+J3FHcsipkJD4B
HmnxdLINqoEbY9eXIlLjts9lBgADzidqhvZz/3HxkqfLK7oy+noaOFVbB6BvTpaG
mxR3h4a230Ku4JIuCl3z+R3FbciHdtLn/cRNj/1XWfhimKuTvANZG/ISrQC/DUQy
D7uQEPZfZ3Pvq4m6CyYTq8Jrfa447N2n1StBK3RF+duaJ3O2j3+r6BqzCGXZFJSw
DjCkc/5UhD5jPD3sDuXqlIpI/rODMIOOTRykxv9HT78oimNmG06pFrNf9EZQL3CO
TbHiwpi2ZvwQxySAJ7e12ymGu5nlFbGn/urTKAD81denZQLbQdAH2dVFgWMAuW98
BKze+Yt5+cvb7o4GBwrEgVunHknKHLdtYJO/l083+CyQ50NQRLYTVrDIQ3z3HQ/R
NyV61TA7i2qH0ZBLVUC4
=GV1w
-----END PGP SIGNATURE-----

--Wt10+cXOThorkX0z--

--===============3915068459167556849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3915068459167556849==--
