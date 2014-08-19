From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Fix building of imx-es8328 on
	PPC
Date: Tue, 19 Aug 2014 10:44:12 -0500
Message-ID: <20140819154412.GF24407@sirena.org.uk>
References: <1408423775-3236-1-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7880845927579198465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBE71265808
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 17:46:02 +0200 (CEST)
In-Reply-To: <1408423775-3236-1-git-send-email-xobs@kosagi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bunnie@kosagi.com, Philipp Zabel <p.zabel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7880845927579198465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 12:49:34PM +0800, Sean Cross wrote:
> The imx-es8328 driver fails to build on PPC because it explicitly depends on
> SND_SOC_IMX_PCM_FIQ, which itself doesn't build on PPC.  Instead, rely on
> the SND_SOC_FSL_SSI config option to pull in the necessary libraries.

Applied, thanks.

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83DEAAoJELSic+t+oim9qhoP/1HzOBEX0Dju0J0iiPO6PO6J
LG0wHt7u0Pc6xjbmqUt/aMR0wTWLnq4ygMCCvyQrdEl1n27qjcVof9E8beSkuzLy
ZTSQApRJRBj0h9nLBr5xIE+k/A/0G+IdaeNVm9YmgKqoZMIcmdcsHOkKqkeZoA2k
mE7+KevFHXy234quN8XzqonZJa1hS41ITEh/BJmAs0iQzlBZ2xmSab/aKdafvupE
23/P0RgP4dVtxT4pSLpu15s7ZTYCEWpSZEt2QWDaVBoK7RS7Pl/sD/463gD6awXF
lXMWpBkMEcPpafVHIPZnK1yr+nbM+Z0U6Q+J6ZSm5SD4/LrL5T3uo97JlZJJvxBT
1g0DiHpJM84O/ERyOFIiXniURL8Mbuatxp4aoVygc4FbV8BXKmplPPB6qlOx5z9k
jEh4GTULpf70MsDx25at6AQMTWyWWnsi4XOWIx5USwy7TFLYuwDJnsr4oj9of4om
zutWsJXbYPhcXOgNh6n6MLyuBxfn7mNq6W1AJcYnOnjw9Jopa9kmLk6MFBbdmSwi
vpOAj37E4kG7wYUPhIfjk60WqUc/U25JPDQbRZdDZDsoKV84Wy1lU1smRX40OORt
J7C8LchS1eYUBRozuKRYVoT1OL60Uo53ubtTz6FDTGYA79T8SjsQpmWdLu4CD79T
Xf1NWp7YnrQR9knzecgk
=UkjP
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--

--===============7880845927579198465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7880845927579198465==--
