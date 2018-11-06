From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa-ssp: make suspend call resilient
 against multiple invocations
Date: Tue, 6 Nov 2018 16:31:46 +0000
Message-ID: <20181106163146.GC31950@sirena.org.uk>
References: <20181106112020.10901-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0028751170467629146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4262678F2
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 17:31:47 +0100 (CET)
In-Reply-To: <20181106112020.10901-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0028751170467629146==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 12:20:20PM +0100, Daniel Mack wrote:
> The suspend callback is called twice when the machine is suspended, once
> through the ASoC layer and once through the platform device layer. Make sure
> not to confuse the clock layer with unbalanced calls, and bail out early if
> we are already suspended.

This feels like something we should be fixing at the core level - as far
as I can tell there's no PXA specific duplication going on here, it's
the core that's triggering the suspend operation twice so it's likely
that there's going to be problems on other platforms somehow.  Or is
there something PXA specific I'm missing here?

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvhwfIACgkQJNaLcl1U
h9A62gf+I0/d63AmI8SjgwD2BR8ddWgivw4KfeZ+yg7giE3kp2L5BM03cFkvttaG
gWJJeDGEWvb8rO3hPNefApNajkGro4NfKt3mgUr++I4lsE1hQxRjWM9ZLiZNvx2L
eK7Q1aSYK9kMrsgBibxxe2RfWTCKbBnPrEYpgP9XpfrG+5D9QiOrgccATLhy4/Oi
RmoLfjJLckWeujz1tmXkeAXLZ1x+P6IYAatds6eRznZrNsbdmScc/ryfY+HP3io7
RTWeuWG4KpqS2atTNKYeYDF5Gi1FxnA/NwtERbFn09ZeWrLsuw4uu0yY3NGwvfn8
Y9BuJDpvExYEAOA1huN1Tkn/VoDexw==
=XFYa
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--

--===============0028751170467629146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0028751170467629146==--
