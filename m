From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: cs42888: Add codec driver support
Date: Mon, 24 Feb 2014 23:47:52 +0800
Message-ID: <20140224154751.GB6132@MrMyself>
References: <1393224929-7555-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140224113011.GE25940@sirena.org.uk>
 <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B745DBDD-8A64-4B98-819B-72F8AFF602DE@cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "rob@landley.net" <rob@landley.net>, Liam Girdwood <lgirdwood@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 24, 2014 at 03:52:24PM +0000, Austin, Brian wrote:
>=20
> >=20
> >> +	/* Disable auto-mute */
> >> +	regmap_update_bits(cs42888->regmap, CS42888_TXCTL,
> >> +			   CS42888_TXCTL_AMUTE | CS42888_TXCTL_DAC_SZC_MASK,
> >> +			   CS42888_TXCTL_DAC_SZC_SR);
> >=20
> > Does this interfere with the manual mute controls or is it a separa=
te
> > thing?  If it plays nicely with the manual controls it's probably b=
etter
> > to leave it enabled since it improves performance in some benchmark=
s
> > (that's why hardware tends to have the feature).
>=20
> Auto-Mute should be enabled by default.
>=20
> >=20
> >> +	if (!IS_ERR(cs42888->clk))
> >> +		clk_disable_unprepare(cs42888->clk);
> >=20
> > Does the device work without MCLK?
> Yes, MCLK is required. If you can=E2=80=99t get the clock you should =
error out.
>=20
>=20

Will refine it as you suggest.

Thank you for the comments.
Nicolin Chen
