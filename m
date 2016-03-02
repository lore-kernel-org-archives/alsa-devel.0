From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Wed, 2 Mar 2016 10:34:39 +0900
Message-ID: <20160302013439.GL18327@sirena.org.uk>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
 <20160226205208.GA25515@Asurada-Nvidia>
 <AM3PR04MB1412F6FB7E5107BBA3AB9B559ABB0@AM3PR04MB1412.eurprd04.prod.outlook.com>
 <20160301090615.GA4738@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4792338509910071112=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3586261536
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 02:34:53 +0100 (CET)
In-Reply-To: <20160301090615.GA4738@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Zidan Wang <zidan.wang@nxp.com>, alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4792338509910071112==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/IjyWiMc6vC4PmW7"
Content-Disposition: inline


--/IjyWiMc6vC4PmW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2016 at 01:06:16AM -0800, Nicolin Chen wrote:

> I personally suggest you to use fsl-asoc-card. Since the Codec IC
> provides three DAIs. And in the schematics, you do have three DAI
> links. It sounds plausible to me that we might treat these three
> DAI links as three different cards. Then use different compatible
> names: "imx-audio-wm8958-aif1" and so on. And each one can also
> has ASRC back-end support.

No, that's really not going to work very well - having the same CODEC
with very tightly coupled clocking connected into three cards is just
going to be a mess, especially for the WM8958 where AIF3 is mostly just
a pinmux to the other two DAIs rather than something that could ever be
fully independent.

--/IjyWiMc6vC4PmW7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1kMuAAoJECTWi3JdVIfQL5EH/R6PdruV8icgZkHUYFwrJJrG
7hbKeUhUlczgaFvHn2xtdOL9ifkrQ/TxYySdQ/aHNLQl1HRT32O9qAywwTPO1fAS
UV+hAp/XHl48LGyH9k7mvVrYi9iguqteFLMJY8mz1aTmy6Mvg5OgyxKXdn0Ps94t
EFQ9+pR/D74UVY4XYK3S/dgo/85HtMW4aNqwHYQLgiTZdFwCQQn6WzMnEWzKm1wK
P9LIBNyyDRil8pV3QefAPYeWMv/5lFQLytFWLimphSIxeRmjVcVkQA5bvJdPUhdm
M7p8Yz/8U/2VuGW5UO2sKNTHdUo3bgdbXRDh1QbbUIg/2KaDn4aPG/U7F4CbvzE=
=Qpb5
-----END PGP SIGNATURE-----

--/IjyWiMc6vC4PmW7--

--===============4792338509910071112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4792338509910071112==--
