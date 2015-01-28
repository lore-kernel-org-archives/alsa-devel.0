From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/7] ASoC: pcm512x: Support mastering
 BCLK/LRCLK using the PLL
Date: Wed, 28 Jan 2015 19:14:30 +0000
Message-ID: <20150128191430.GG21293@sirena.org.uk>
References: <1422454572-7847-1-git-send-email-peda@lysator.liu.se>
 <1422454572-7847-6-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5373060454841119214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73DEB262631
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 20:14:35 +0100 (CET)
In-Reply-To: <1422454572-7847-6-git-send-email-peda@lysator.liu.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@lysator.liu.se>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org


--===============5373060454841119214==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2BwlnJGNAaT6vtF0"
Content-Disposition: inline


--2BwlnJGNAaT6vtF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 03:16:10PM +0100, Peter Rosin wrote:

> community pages (1). The clocking functionality is also much better
> described in the datasheet for the chip PCM5242, which seems to be
> register compatible with PCM512x and PCM514x (which both have severely
> lacking datasheets).

If it's register compatible we should add the device ID...

--2BwlnJGNAaT6vtF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTUVAAoJECTWi3JdVIfQJA8H/1JMOC9ysco6niND7VNkQtzc
gRnWml3LLWeyB96tE2XvzfIzrvZ57EiGlOVMYVzM8orVrKgd9/DjCOzCzk9z89Pl
+fAuHe46XNa+Kmuycv2s9SXbnArAfXe1dtpyoN7V4dqUEH9497RQv6pcq2lZ6IjL
kSzBdiMzWvYF5sDKzi0bdcnQ9nFdnBkp+gR0ZZNxrzZ/BXPSC0bbk1WAy+YBTtji
pcCo4EKMRU5531uxHFtHPIGf0WUPDBwZaZO7r9P9nB+7MO7IjCHCKdJZDA9YCcZ2
FJ11EEyr0YvYEIf4yORKgNpFZKnz6MI89nyFsMV89i2mACtej0z8Ja+XLRhKHB0=
=473B
-----END PGP SIGNATURE-----

--2BwlnJGNAaT6vtF0--

--===============5373060454841119214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5373060454841119214==--
