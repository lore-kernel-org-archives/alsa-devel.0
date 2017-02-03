From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:nau8825: automatic LRCK and BCLK
 divide in master mode
Date: Fri, 3 Feb 2017 12:57:57 +0100
Message-ID: <20170203115757.q2ku7xzymqcx3yq2@sirena.org.uk>
References: <1486021010-32340-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1908771423326293962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D035B266991
 for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2017 12:58:04 +0100 (CET)
In-Reply-To: <1486021010-32340-1-git-send-email-KCHSU0@nuvoton.com>
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
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1908771423326293962==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2pvuonmwssj25pa5"
Content-Disposition: inline


--2pvuonmwssj25pa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2017 at 03:36:50PM +0800, John Hsu wrote:

> Provide the automatic configurable LRC and BCLK divide. The bit clock rate
> can be chosen by userspace. The driver will make configurations of LRCK
> and BCLK automatically when playback or capture in master mode.

As far as I can tell this only provides manual selection from userspace,
I can't see the code for automatic selection.  I'd not expect to see any
userspace control of something like this, if there is an override I'd
expect it to come from the machine driver, and as I've previously said
I'd definitely expect automatic selection to be the default like it is
with other CODEC drivers.

--2pvuonmwssj25pa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliUcEQACgkQJNaLcl1U
h9D+qwf+MNMmiNYvPE8D26n0lmO6yidUYBdTuzCipKIowye8LFeIBpBDFjgV+7+A
YlckX06Dh70F3TQ9I+p9OUWI3quxCXuIXta5m8bi8SFd+r/m5gwzJpvS3W0+kwRi
Shm/Rk0kqY4mAtkeAI053arnMNVAhaKsSUps0hGb2ceScm1kaqS75FmeHxE7KR+x
tRDxANMkCHZiLEnyNc56inOggIqKzBULLUpwCF0uf5TbC5UykQSDui5otksPxlEn
XtB6f+ZBwoGzuBOmLLmrSfehoWMpvicCpPqKO7NPeJRCWpnwhkRviQs50ryo68qW
48p+RHYpl9jV7sOfwEku/Bg2B1LdWw==
=tmDO
-----END PGP SIGNATURE-----

--2pvuonmwssj25pa5--

--===============1908771423326293962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1908771423326293962==--
