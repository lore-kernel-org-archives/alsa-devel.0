From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] ASoC: codecs: msm8916-wcd-analog:
 get micbias voltage from dt
Date: Mon, 21 Aug 2017 19:24:09 +0100
Message-ID: <20170821182409.c6vnzcuomrygrwjh@sirena.org.uk>
References: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
 <20170817080211.11453-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8040538316276532230=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11CF8266C78
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 20:24:12 +0200 (CEST)
In-Reply-To: <20170817080211.11453-2-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, damien.riegel@savoirfairelinux.com, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============8040538316276532230==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w3xsrwssywqnafqp"
Content-Disposition: inline


--w3xsrwssywqnafqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 17, 2017 at 10:02:09AM +0200, srinivas.kandagatla@linaro.org wrote:

> +		/*
> +		 * Special headset needs MICBIAS as 2.7V so wait for
> +		 * 50 msec for the MICBIAS to reach 2.7 volts.
> +		 */
> +		if (wcd->micbias_mv >= 2700)
> +			msleep(50);

This doesn't sound like how ramping usually works?  Normally it'd be at
least somewhat proportional to voltage, a sudden cutoff like this seems
strange.  I'll apply but this looks like it needs fixing, please send an
incremental patch.

--w3xsrwssywqnafqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmbJUgACgkQJNaLcl1U
h9BKgQgAhXLjflrbzfqvOIAtDBG5wriC6659FYOqjGsGbdKCT17fXGxG3vDHZysr
R/1OaYS84KtynAPgksfChCKnFc+HREay+vtI4cdtPknELFsVwXEKgYO1uPC2D9T7
r7Vnt9SVtKAGlk2u90o0VQ0Nb+hitiAq7A8O7xWvPG/AlF3UOgAoHyVqRAWudwWu
TMqESaDckjxkOCa2dj/CCLkuZtDEwTdtiTCARrvAF31rY3Gvbqco4Zj77+8iBW3l
pe3Xy6HsvlZsyaNaSOHex1ukeUHVjEs9fLSQllo+hl6vDCr8ED0vsdJIxZaUSBBz
W+zdp2VjPx3QfMcr+0YRCtfIZGe4CA==
=SqjU
-----END PGP SIGNATURE-----

--w3xsrwssywqnafqp--

--===============8040538316276532230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8040538316276532230==--
