From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Thu, 4 Dec 2014 11:25:12 +0000
Message-ID: <20141204112512.GS7712@sirena.org.uk>
References: <1417681425-4360-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7681136663148844804=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F8422614DA
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 12:25:36 +0100 (CET)
In-Reply-To: <1417681425-4360-1-git-send-email-b50113@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7681136663148844804==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6jbJE0PFwegn7S6c"
Content-Disposition: inline


--6jbJE0PFwegn7S6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2014 at 04:23:45PM +0800, Zidan Wang wrote:

> If we use PLL to generate sysclk, wm8960_set_dai_pll() will enable PLL. But
> PLL doesn't power down after using codec. So power down PLL in suspend().

That would be a bug in the machine driver, the machine driver should be
disabling the PLL when it suspends since the startup and shutdown of the
PLL need to be coordinated with the input clocks.  Besides, if we were
doing this in the CODEC driver then as I said last time the PLL needs to
be restored on resume since the machine driver should be able to expect
that settings it has made are preserved (eg, if it sets things up on
init).

--6jbJE0PFwegn7S6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUgESXAAoJECTWi3JdVIfQw9MH/A0OeNQyJsQ7PrtyEcAxizRt
A8+y/S4gjduYNIOfGTaNfz+U7UVnU0YI2EaCTlJ0JzVetMcADfspe3/LYs53s+PR
K/eJwDOQX54FpDXR8oEOCdOgMkSYl4NunlaP+Yhc0FdjX5WmpawS6D0R3IZIeqdC
tFXxvrC1U41FVcVkzbSapbX1oMq0Kautlm3Yy5jZcAJoeRCIaOMolJ2RgYNYAITu
Q4PBHKnYvs/GAsZD20cIsbyHV+bggwN2T0YXXKajknH0GH3Zd743LALAqGkpYz8k
LZ2D16ZmH0xrJugTUM7fEjXH27cioJ9m3jIo1x2ltXXcZbHfit/IRSnlNYZvbRg=
=wYSk
-----END PGP SIGNATURE-----

--6jbJE0PFwegn7S6c--

--===============7681136663148844804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7681136663148844804==--
