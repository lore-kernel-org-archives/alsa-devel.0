From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] ASoC: max9867: Use continuous sample
	rate
Date: Fri, 2 Mar 2018 10:50:02 +0000
Message-ID: <20180302105002.GA6255@sirena.org.uk>
References: <20180301141843.GB30722@lenoch> <20180301142216.GH30722@lenoch>
 <20180301182202.GH12864@sirena.org.uk>
 <20180301214708.GA4302@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971925443685325752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E69A267CF6
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:05 +0100 (CET)
In-Reply-To: <20180301214708.GA4302@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============1971925443685325752==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 10:47:08PM +0100, Ladislav Michl wrote:
> On Thu, Mar 01, 2018 at 06:22:02PM +0000, Mark Brown wrote:

> > flexible.  Devices don't need to be able to do this independently, you
> > can have a flexible external clock tree for example.

> Thanks for clarifying this. So in this particular case we should use
> snd_pcm_hw_constraint_list for SNDRV_PCM_HW_PARAM_RATE to enforce only
> supported rates based on master clock, right? I'll rework this patch then.

Yes, that's the ideal.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZLFcACgkQJNaLcl1U
h9BVZAgAhBjjx7B7rgziDwoK086iJi8vwzc5P0BcoFEqMaw7D45e620ZYISFFTXN
MPQUf3a5W6HyyR/mQdH+OrxZTZeDEqiNPdX3A1y9J7+5fysyIq+nnLuzXuLnXN2o
f+tPImQImVTyIRIlwv/1efTvmGnkaLCMpevM0WhvpZi/WjDv2eoEsN2aq9Yb4FSX
Wuwb6BPNznkZQhyG3ibw+VPAjuKRXCowcive3cKHLcxhlVZyNVJZbuEO2Bm/hiCP
SUlcz5bgIn8FMzGlwvsBFmx85ClozYRGe4AS+JFrMyznrGjdNTNQYzuDEZP60W2n
1TaKNrji73DSPrh8wwlQ9UTtoAKjWw==
=IxEr
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============1971925443685325752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1971925443685325752==--
