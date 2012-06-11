From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Ux500: Add machine-driver
Date: Mon, 11 Jun 2012 20:27:57 +0800
Message-ID: <20120611122755.GQ11439@opensource.wolfsonmicro.com>
References: <1339070437-15150-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120611053432.GP4218@opensource.wolfsonmicro.com>
	<4FD5E309.4080301@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2817479103976840077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C34C243D2
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 14:28:18 +0200 (CEST)
In-Reply-To: <4FD5E309.4080301@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2817479103976840077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="de1H0RjRxOSdb4we"
Content-Disposition: inline


--de1H0RjRxOSdb4we
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 02:22:33PM +0200, Ola Lilja wrote:

> >> +static inline const char *get_mclk_str(enum mclk mclk_sel)
> >> +{
> >> +	switch (mclk_sel) {
> >> +	case MCLK_SYSCLK:
> >> +		return "MCLK_SYSCLK";
> >> +	case MCLK_ULPCLK:
> >> +		return "MCLK_ULPCLK";

> > Why not just drop the MCLK_ from the strings?  I'd expect that'll be
> > implied by the context...

> I like having some kind of prefix before the alternatives in my enums,
> even if you could figure out what its for without it.

Is the control name not enough for that?  I'm only suggesting this for
the strings...

> >> +	/* Digital interface - Clocks */
> >> +	SOC_SINGLE("Digital Interface Master Generator Switch",
> >> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
> >> +		1, 0),

> > This enables and disables a 256fs (or similar ratio) clock output from
> > the device?

> This is the clocking of the digital interface which is used together with the
> bit-clock switches when we are in gated mode (see discussions regarding these
> parameters in earlier review of the codec-driver).

> >> +	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
> >> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
> >> +		1, 0),
> >> +	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
> >> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
> >> +		1, 0),

> > I suspect that these are doing what DAIFMT_CONT is for...

> See comment above.

Can you refresh my memory on this discussion please?  There's been
several occasions where I've been waiting for new code to make unclear
things clearer.

--de1H0RjRxOSdb4we
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1eREAAoJEBus8iNuMP3dFEAP/0l2hYB4D7tbraWr7sGhjHbY
ZHTwUkzvEOk6SlW9JsIc9DqdoqpiVn2A+9vO7hwuWyNXyzfPodHXnmqPLLbIIEdH
eFClcPy8eX2aKRhcBIaCS129Poesp7/jBcTHvcjItr0O8K1YHEiFfhErDIdn9G6z
/TizE8NtC+iSDpMrwymA4b7h2kOpgekbAe2R+MRWL880k+tRe9n4g4SuUBsoorkZ
jxo0SmEAlD1kq4e5+XS75pN6mEvCbCwagmcX+mG3L7wcwUuSVzw6EldBG/s06Weo
RMs1OO7Vvj+eDBeFH+ICEgCET+2XDsMPavWiY452sN/tGX3kQvKBgOdtPt3adg1x
LR0NHeO7b1yvDksOejmmjB6RLFAITPgFAcPN1aX+RvP759NQsClKaMx1UNZrIeBt
sMg4O28nPrnFWRfz/HBVK0IOlIGk1JcZ2Jh5FgmxsEXb06K0YBSGxDusAW541HeA
hYDr17CJ/XGpilmdm7OpV8MRlot0W5QLXlcgSHIx/Om6sQSBIwUH3mOpv8Etctop
F5DLK6oB+cMSGidvrBaZx7V1VfBp7nwhEF8BIu5LQwHMwX6bsbxeY9J7QQlwVk3p
fW1fK5AmOdiwNCHBJyiU653PBHxYMgisE3/2wCC0M4gpVzQu7UAcUAP3dzZSz55Q
yHHN2p8mqqWB4O7mbeeY
=lYTz
-----END PGP SIGNATURE-----

--de1H0RjRxOSdb4we--

--===============2817479103976840077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2817479103976840077==--
