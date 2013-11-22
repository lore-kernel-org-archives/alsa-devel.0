From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Use SND_SOC_DAPM_INIT_REG_VAL
 in SND_SOC_DAPM_MUX
Date: Fri, 22 Nov 2013 18:32:16 +0000
Message-ID: <20131122183216.GP14725@sirena.org.uk>
References: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8276838007530616567=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 332C7265163
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 19:32:22 +0100 (CET)
In-Reply-To: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, ac100@lists.launchpad.net
List-Id: alsa-devel@alsa-project.org


--===============8276838007530616567==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/DkgDsqJFFamjKX0"
Content-Disposition: inline


--/DkgDsqJFFamjKX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2013 at 10:29:18AM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> SND_SOC_DAPM_MUX() doesn't currently initialize the .mask field. This
> results in the mux never affecting HW, since no bits are ever set or
> cleared. Fix SND_SOC_DAPM_MUX() to use SND_SOC_DAPM_INIT_REG_VAL() to
> set up the reg, shift, on_val, and off_val fields like almost all other
> SND_SOC_xxx() macros. It looks like this was a "typo" in the fixed
> commit linked below.

Hrm.  Why has nobody else noticed this?  I've been doing plenty of
testing that involved changing muxes...  The patch and reasoning makes
sense but I can't immediately see why any of the testing I've been doing
recently would've worked without it since it all relies on muxes being
configured to make any noise.

--/DkgDsqJFFamjKX0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSj6MtAAoJELSic+t+oim9FtMQAIJ8j8Pnnf3ZV9d/gC3Jeh+K
dDWRMhDn6EHCALFOEp9nAFSUAnkgnwpRbaTM+tTD0xBiPdjCV2Ka7CbasfLouRj5
rSD9uWQVrEXLcrexnns9i6ZAQz0RRdEFS2h3/A5FnezvbWpgzSgW9rTyWy03WxVu
b6eJ4SrMweyxWe8WhETfMmtDcmoyci1Ek7OltHpBpHULX9FZgWmvIsGlr57s0w88
mcA4tHeGSlmFND8XWNvhLp6kIa4Xjv1eya3X6NPeZa//2KaIaCLaAU0ao2uRnO2q
lkL3Qn+9e2bLLR1fwuDPakyLbQYxIuH7rrMtNYDR28wvArIdaeC2JAjOpd9+1X9r
j/veuOW/tojOoj6+7DBxlkuDpA7wPZkBO1zLxVhQ9dRKz8sa+G7h+uW3wWpfPvmF
3HLIL5Axg75J083erlzSm7NmWz4gAfYBKTiVlcx2RqA+ZxhSRl4X/Qhrfk1E3P/h
TOmFNuZ+fCO1xH2kV/a7xLMXQrY74EwXIshZixKFEySB4PbM0r/1kPY144MnN78f
lDfAJM4zU2LnlfvwsLixiBmF7zvU/a0T47OZvxHEvbtnnxmiP1HkIbFRTIh4tfM+
zLkwMhCXYa5fNUs2U6MhHyP0zJfl7NZQ3ouq4mcK+H58HYcZ1HIM8nrOJaBMY/Oq
IypsupJM7mQQNg5++AJ5
=94dU
-----END PGP SIGNATURE-----

--/DkgDsqJFFamjKX0--

--===============8276838007530616567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8276838007530616567==--
