From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add widget<->mux route into
 mux route macro
Date: Mon, 12 Aug 2013 11:56:48 +0100
Message-ID: <20130812105648.GR6427@sirena.org.uk>
References: <1376303612-28203-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722668825471264476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FAFC26168D
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 12:56:51 +0200 (CEST)
In-Reply-To: <1376303612-28203-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1722668825471264476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6apqy8gW/Oj6VEa"
Content-Disposition: inline


--L6apqy8gW/Oj6VEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2013 at 11:33:32AM +0100, Charles Keepax wrote:
> The routes linking the widget and the input mux were being added
> manually, rather than by the ARIZONA_MUX_ROUTES macro. This patchs adds
> the routes to the macro.

Applied, thanks.  You probably don't need to directly CC Takashi and
Jaroslav on every ASoC patch...

--L6apqy8gW/Oj6VEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCL9tAAoJELSic+t+oim9vDgP/2L7YInUPSHbQRBp/4iXYn1+
a0Ex2bfJLZMBFE1dSRAbGdivOKJTHN/+ksrxdAMWnVOFH59ixw+ra0CmVNXdfiXb
vXyt2TM2lfVYY39ARUnpPzZG2+848NHwoMWnS2Z0I6TTvc3fBdqILe1332hCrjcJ
nTD/OUiLzcsBxAE8ubSvKNNGWVkxcnBuT6rXl3dxltXYWEAFbF2//XwwkgoEFCBl
or0OslMXhrcYMP8P1f1fn+q6//cehtf1T2Fy9j1h8ywFK3AD+fSExx9rITazof8g
yjP6f3Cy6JnLAoknPcR2HRl10A8oIFPVsdlxwzgGVOVbvNADHZ9YsnALuLrJtH4/
Q93mkHho7o62yXVavtmz2z3Ee96OPV6z1cCGsWhv9NY99NgyZ5q5hWLF3+grFyWj
NON7SC0RVZAVbLL0V9ub+wb23UTLFykeNVZ0De8O5IwXp4xA0Nt94PaUA2bh7d6E
75Q3SDVuQ7nLY/OhEGqVyrqjXgFCnW4EVjyPWjzON6myQvJQa6Da7wyDXkrO0GKa
unrwuoWk51W86Mn69iQ/W6KZZNgSt5CDF3gP8MCg1t/Oc7J4WfrVP93Qvh2uAJHi
30vlm05H54FejIdxQDchARZmoaVJgBDl8QtdNvhOm5YzlEBxIXN0D2YPiHjueCDv
WcM4GbcvNYukCGH2eNhG
=wl8T
-----END PGP SIGNATURE-----

--L6apqy8gW/Oj6VEa--

--===============1722668825471264476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1722668825471264476==--
