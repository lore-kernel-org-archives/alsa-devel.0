From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2][RFC] ASoC: soc-core: allow no Platform
 on dai_link
Date: Fri, 8 Feb 2019 18:25:24 +0000
Message-ID: <20190208182524.GI6695@sirena.org.uk>
References: <8736paoqr5.wl-kuninori.morimoto.gx@renesas.com>
 <87zhrinc2y.wl-kuninori.morimoto.gx@renesas.com>
 <e984c300-5732-17ca-212b-3954cbdf3765@linux.intel.com>
 <87o97xlicc.wl-kuninori.morimoto.gx@renesas.com>
 <477d13e1-7dfa-b384-259e-2e0e5b98684a@linux.intel.com>
 <87imy4nxq7.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7397132502325373224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 509EE267437
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 19:25:27 +0100 (CET)
In-Reply-To: <87imy4nxq7.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7397132502325373224==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 09:56:05AM +0900, Kuninori Morimoto wrote:

> I think "transit to modern" is just "rename", but
> "no Platform / no implicit dummy" are "new feature".
> Let's separate these. I want to know Mark's opinion

I agree that these are different things, though if we allow things to
sit for too long it's going to be confusing so ideally they should
happen close together.

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdyZQACgkQJNaLcl1U
h9AuEAf8D/tgDwKtYBiue8hW/+tNZ5Oo6vNGZcEpseceRe4Qb+Ajx6L/NLo6EMRt
Z+MIcy7VYl+YJvkNJvBeBYFh5MVLLr4cLJXYILjO3FlZgMNzKyMvmx8UcXp7+f34
M2swc/59PYu284yhDEXwR+xk+RR8Q3tPFVZuJfakGANI9LDJi6adIWkq+FklFP3C
mgLAT2maZP02nyOtlwX+lxt/tWKXzY3bo8jClvCftK/rDig624V2tCEv3TOHJQ0U
GvEEZ/JakOAyHKKePch4ELYwWFhk/4Lf/HWiemAlcMr1zDiTKRN42sSD1dDI225o
aW4GclUytGO+pkVRivMRcQ8qrj2/bw==
=0pWU
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

--===============7397132502325373224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7397132502325373224==--
