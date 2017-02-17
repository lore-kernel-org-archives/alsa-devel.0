From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Fri, 17 Feb 2017 10:43:54 +0000
Message-ID: <20170217104354.e6ylky6xqjaasl6m@sirena.org.uk>
References: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
 <20170217104047.vhrcehhojpkdeksu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6114549329574261328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8464B2668B2
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 11:44:00 +0100 (CET)
In-Reply-To: <20170217104047.vhrcehhojpkdeksu@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6114549329574261328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uvpcusvyjybju7sp"
Content-Disposition: inline


--uvpcusvyjybju7sp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2017 at 10:40:47AM +0000, Mark Brown wrote:

> This is still broken, the above has tabs replaced by spaces.  I think
> I'll try to fix up by hand but it's going to be fiddly and that's a one
> time thing...

OK, that worked - it's definitely a tab/space problem.  Please
investigate this and try to get it fixed though, I'm not doing that for
every patch you send.  It may be something to do with what happens when
it leaves your company mail system and looks fine internally?

--uvpcusvyjybju7sp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlim0+kACgkQJNaLcl1U
h9AVQgf+KMEB6gJzDT6JA71mUGdLa28NiFoEVXoeZ4kThbbPi66lFrFBt0vFPQDK
ltPg9DY1FMiaXdGS5dcwoEi6hWYwPMLrGTqGvNDjdlWWPMjqOSUJ5DpT2zUWMe8S
m71/tXynZnfoPY7cmXyljgYs9mLsSInquQTz5hJJ5dKzfH+kk8HTDDPOb17hNB4L
VIJX9XsL3Qam/euM+2JgS/wRLxJJyMaFNL2+0dgGhdbj53wHKVtaRU0IExcj5mcM
eJDyuRkzliJYRA/gndkL+eAdtwQUkdoc0frtJZ8Ou4GrYQqJigXYq5wEi6aMGDam
DusHopVlJ52i8lqrKE8TgqFpVA373A==
=DagX
-----END PGP SIGNATURE-----

--uvpcusvyjybju7sp--

--===============6114549329574261328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6114549329574261328==--
