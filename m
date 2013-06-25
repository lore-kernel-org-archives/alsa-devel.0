From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: codecs: tas5086: fix
	documentation
Date: Tue, 25 Jun 2013 10:26:58 +0100
Message-ID: <20130625092658.GY27646@sirena.org.uk>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
 <20130624160551.GU27646@sirena.org.uk> <51C877F8.2010106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0365339758265455012=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 670172655F4
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 11:27:00 +0200 (CEST)
In-Reply-To: <51C877F8.2010106@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0365339758265455012==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TNwgp3ukRgvXRjlQ"
Content-Disposition: inline


--TNwgp3ukRgvXRjlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2013 at 06:46:48PM +0200, Daniel Mack wrote:
> On 24.06.2013 18:05, Mark Brown wrote:

> > Applied al, thanks.  Though specifying this in nanoseconds does seem
> > absurdly high resolution...

> Meh, I was confused, sorry. That first patch need to be revered (or
> dropped), the documentation was correct as it stood. The time values are
> given in fractions of milliseconds, not microseconds. My bad.

Dropped.

--TNwgp3ukRgvXRjlQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyWJfAAoJELSic+t+oim9D1gQAJrUgwBnl5pEgfrI2dlm0z/6
yjlwgivVneqyznhfm9DfN1fqGUPHad/68ueC0VfFnOFC6p/pD2xH2MKz4hT2PuE5
hMaWuq1I2Gf0njYwyhEAsY5ykTVxOCXYM3EdFcbP3yRXPAiqJNzQdgsYuVjQ1Hv+
arjyOwsdaDGlzKdDk4paMYUqgbSFQ1SNlzHiyPoHaxjPiuOazFtOJS50oj7JM/MN
Z+lUXEwHUvdFuxkr+/qlJUIjHgYqxdhrzdquIUI65/IXvZcqgfHoomhYvc8pbWdR
vQ8KN/Al6EDF8/jwAtcP40p5df3HLorVOpFLw1SNZq6l8k0bmeXlY0XTsSHcKrHw
VbQQq5pG2sWlZch/LXcpuezDk4sAi2ggveOovy6RYq9uoq0jifUAnRNw2Ir5wlxK
mR4Qe8XGCzL7o9bEcyQCl9Raz1pJYONVlEPaOgIbVx0uDHyMoAJn2EvpZf0TvDDc
WQrrfmeJf1E0Q047uSK3tkuCSHi3Pwbp4F253+XfZz/nutqwViJwOMsmxmmkh/fD
kKTkiIWYfTmK48mCx+M71uVCWCoFMpyPPYmMhJG456eNQbRhgdMME4v/8n6Mu0Lf
f9lQdTM8WUS5U9vHBwOd7gTt74QWerJern7af+3PiRhYG1UxnDz2FMA39xM42OMo
sWO7FHTR3kToaRPqAIxL
=mmio
-----END PGP SIGNATURE-----

--TNwgp3ukRgvXRjlQ--

--===============0365339758265455012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0365339758265455012==--
