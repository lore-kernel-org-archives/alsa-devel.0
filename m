From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 30 May 2016 16:16:38 +0100
Message-ID: <20160530151638.GN29837@sirena.org.uk>
References: <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
 <20160520110137.GJ8206@sirena.org.uk>
 <5742641A.9070409@nuvoton.com>
 <20160523170432.GA8206@sirena.org.uk>
 <5743CD4E.6020805@nuvoton.com>
 <20160524110309.GI8206@sirena.org.uk>
 <574B9ED3.5070005@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7763950900963940014=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D18026073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 17:16:45 +0200 (CEST)
In-Reply-To: <574B9ED3.5070005@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7763950900963940014==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3rMDlCEgcaHQQFB+"
Content-Disposition: inline


--3rMDlCEgcaHQQFB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 30, 2016 at 10:00:51AM +0800, John Hsu wrote:

> I see. The configuration is an array of filter coefficients. Maybe
> we'll make it with bytes type kcontrol for userspace. Is it suitable
> for the case?

Right, byte controls would be completely uncontroversial here.

--3rMDlCEgcaHQQFB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTFlVAAoJECTWi3JdVIfQF6IH/R7hiFlmwFpDt0/UYKtkrWku
dkDvLlDFi3IBgsph0nqIUBovKpMZ93GQxS5YqRWrqJWHyGcJXmG7kLpADaBVITAr
wohZNPYb0SvkKpRlT/HGO2xO5F50GJpZHNPJzcQuy6fNoodddzdc/KouRmT5PKmi
lZMmmZXo+u3Ub2VioN5164AIyep4Vy7XhuWsIHNw4+8+Fx7G3dUzqpLMJgvW0NFE
bDHfgSpG9dyIhluZDyoO6PT/i2v6mvIA0OVtHtRjkN/kpwEiWw6GuJrN/E0V9tq2
S5EF721+3kJwJWW23SPl+Q/DxYXzurJ7s6anoKsLToohghtpHuSTw5hJb08T3co=
=3Gcg
-----END PGP SIGNATURE-----

--3rMDlCEgcaHQQFB+--

--===============7763950900963940014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7763950900963940014==--
