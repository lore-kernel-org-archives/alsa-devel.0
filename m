From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of
	micbias-voltage
Date: Thu, 11 Jan 2018 15:07:04 +0000
Message-ID: <20180111150704.GC7834@sirena.org.uk>
References: <1515660031-9183-1-git-send-email-fischerc@swissphone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7240284538090515092=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 085402678EB
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 16:07:07 +0100 (CET)
In-Reply-To: <1515660031-9183-1-git-send-email-fischerc@swissphone.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: fischerc@swissphone.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, fabio.estevam@nxp.com, bhumirks@gmail.com, richard.leitner@skidata.com
List-Id: alsa-devel@alsa-project.org


--===============7240284538090515092==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 11, 2018 at 09:40:31AM +0100, fischerc@swissphone.de wrote:

> The mic-bias-voltage should get powered up/down automatically.
> Added missing DAPM_PRE and DAPM_POST widgets to fire up the mic_bias_event function.

> +	SND_SOC_DAPM_PRE("MIC_BIAS_PRE", mic_bias_event),
> +	SND_SOC_DAPM_POST("MIC_BIAS_POST", mic_bias_event),

I don't understand what this is intended to do.  The mic_bias_event()
callback is already hooked up to the Mic Bias supply widget, it should
be invoked whenever the bias is turned on and off already?

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpXfZcACgkQJNaLcl1U
h9Baxgf8CCVwLLUieAcXIUSQO3XCzfsLB+nnPQB2N+H+1VUdr5GSKthXzC12uGzQ
asizJ7FtY2VC8wWwk1LztUgvIN+woAIx4W5zvWCwI6dHOkI87wwpurN+TbxvVHX0
9naWN1dSXfkcYmjgpZz5qeL/Yhy4UNXepfw5qmZcQpJPq+fMAUHXZOw1L144Q1IA
PKYmD32DejubOpND3jRDn/AyNsuTMYzjlkv67bKQeHmq0S9sTogtfI3EgQ8ZDN0C
W84ATnoSfL0rtchQiYjVWdkqbBttuLbwI6EXClQaivKTThnptmoKUwO7nNXvHvHv
EWNsCbaZrpjjVa8Zh3X/4IcS4lEyyg==
=1x1j
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

--===============7240284538090515092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7240284538090515092==--
