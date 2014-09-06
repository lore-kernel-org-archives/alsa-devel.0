From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: 88pm860x-codec: Cleanup manual
 bias level transitions
Date: Sat, 6 Sep 2014 13:39:09 +0100
Message-ID: <20140906123909.GC4015@sirena.org.uk>
References: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2447129436050038564=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89A47264F10
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 14:39:33 +0200 (CEST)
In-Reply-To: <1410006575-499-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org


--===============2447129436050038564==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 06, 2014 at 02:29:31PM +0200, Lars-Peter Clausen wrote:
> Since the ASoC core now takes care of setting the bias level to
> SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
> anymore either.

Applied all, thanks.

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUCwBoAAoJECTWi3JdVIfQhkIH+wVmrW+cso76uWApcU0xmKUE
nPMBfOozninrnMEqbrp9hRlpeZzSRK/meusGQcx8kjbEJ1WzZDyNPxTDQlHVB+fs
mmzQljD/mm1JJLxjYwS6s9NZKQkICZz1WUzgSXPqexM2fAVf4q66Ifj5CrSbVBrF
akSesSIHi3z48DllDumY1o0uzCZuC3hXis82UI8vhOQNCgYAmMPeyiW2vemsOgAv
kATLxxuMMGVAOCrlc2gRmD4y3WYzCy06UtNMmOIvgh73uToEyrFg4De3v8iycKYL
u/0IXlZI9KvaSSZTX6aVKo6aeiI1NRhGhdBPi+MLLRy8ZRdUgNoo/rUl5ATuvfU=
=Eg1j
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

--===============2447129436050038564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2447129436050038564==--
