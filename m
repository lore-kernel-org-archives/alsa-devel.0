From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about WM8904 regcache
Date: Fri, 12 Jul 2013 12:32:25 +0100
Message-ID: <20130712113225.GB24508@sirena.org.uk>
References: <51DFA98A.50900@atmel.com> <20130712084200.GV24508@sirena.org.uk>
 <51DFD464.1090503@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1504822387235439063=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EC34E26597F
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 13:32:28 +0200 (CEST)
In-Reply-To: <51DFD464.1090503@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1504822387235439063==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cJfXB9mphngkt5vq"
Content-Disposition: inline


--cJfXB9mphngkt5vq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 12, 2013 at 06:03:16PM +0800, Bo Shen wrote:

> Do you mean the system boot up the device should be in _BIAS_OFF state?

Yes.

> I add debug info to set_bias_level function, and don't see this is
> called when system boot up. When I run aplay command, it call from
> _STANDBY to _ON, not _OFF, after show the error message, it call
> from _PREPARE to _OFF.

It's not called on boot, it's just the default state - the probe()
function is intended to leave things in _OFF.  What you describe sounds
like it's sitting in _STANDBY, you need to debug why this is happening.
I can't see anything in current code - snd_soc_register_codec() sets the
bias level to _OFF by default.

--cJfXB9mphngkt5vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3+lGAAoJELSic+t+oim9Zq8P/2IzoA8rO13ZsWybAFL0crrS
1a7Uou13ujYSsOyTUR7q4Br9ONak9+4sBGRG2P3b8St3vSY0OeO3zhDGygcc4BHh
tZ1ydwt1wQYsMWbnBJnkwOqKlUXG+3a1BchNUJo5wxxNXWXn8ci84gOcspzh+FwH
Qx6YfWEvv/LcmYdZs9dEouaEwR45elNnyIGP7sLMXcZS1R7ZnhBsxMZboQwcTSOK
UU0FZg4SSU5gJODY7zne7HTGv2XeWnzvvtZdoi4xNaxAxLjsRrtRaM49PLC4HMLF
43iQ8gkz9SS0pNQd++GlMFfOuW3CfmLHqe+sys7dO4SVO3Bxs4ikR23508uROsnS
WXvm+re0djMNX86PgL4V5UXxOue3pFIuNZyS5dhFPG3rIf7B4cz0uxw4zEZhIS0m
veQuJYa5B+ns97cEo65YUvDmUtNa/4guXG3sLqfPdHo/Uq9t/2fmqEsShbeTxs43
SdeoVGHMLBauOA8OwEysTl3l9WqFELv+LdjHmTCK60bh9XA9TE89B5mKhV1pX+8K
1xIVMtgieyE5vjz+FOhm0XliIM8RnBbrT6zkQFBULcg/YBFFvCHFTGfgqLIFm3Si
RvcBO+navHG4cOKrqeBgmtspS2FWm4gOQcLdv69944kutYASskJrGisS+2eMGDLj
PPI/ESvHJ4rsjyeqHGT+
=TTVW
-----END PGP SIGNATURE-----

--cJfXB9mphngkt5vq--

--===============1504822387235439063==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1504822387235439063==--
