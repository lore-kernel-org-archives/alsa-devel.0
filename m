From: Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date: Tue, 27 Aug 2019 11:35:36 +0200
Message-ID: <20190827093536.rl6fjuvctjwd33as@flea>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zfutohgftfydg3jy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Code Kipper <codekipper@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--zfutohgftfydg3jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 27, 2019 at 04:20:24PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>
> On Tue, Aug 20, 2019 at 3:25 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Hi,
> >
> > This series aims at fixing a number of issues in the current i2s driver,
> > mostly related to the i2s master support and the A83t support. It also uses
> > that occasion to cleanup a few things and simplify the driver. Finally, it
> > builds on those fixes and cleanups to introduce TDM and DSP formats support.
> >
> > Let me know what you think,
> > Maxime
> >
> > Marcus Cooper (1):
> >   ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
> >
> > Maxime Ripard (20):
> >   ASoC: sun4i-i2s: Register regmap and PCM before our component
> >   ASoC: sun4i-i2s: Switch to devm for PCM register
> >   ASoC: sun4i-i2s: Replace call to params_channels by local variable
> >   ASoC: sun4i-i2s: Move the channel configuration to a callback
> >   ASoC: sun4i-i2s: Move the format configuration to a callback
> >   ASoC: sun4i-i2s: Rework MCLK divider calculation
> >   ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
> >   ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
> >   ASoC: sun4i-i2s: RX and TX counter registers are swapped
> >   ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
> >   ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
> >   ASoC: sun4i-i2s: Fix the LRCK polarity
> >   ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
> >   ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
> >   ASoC: sun4i-i2s: Fix the LRCK period on A83t
> >   ASoC: sun4i-i2s: Remove duplicated quirks structure
>
> Unfortunately the patches that "fix" support on the A83T actually break it.
> The confusion stems from the user manual not actually documenting the I2S
> controller. Instead it documents the TDM controller, which is very similar
> or the same as the I2S controller in the H3. The I2S controller that we
> actually support in this driver is not the TDM controller, but three other
> I2S controllers that are only mentioned in the memory map. Support for this
> was done by referencing the BSP kernel, which has separate driver instances
> for each controller instance, both I2S and TDM.
>
> Now to remedy this I could send reverts for all the "A83t" patches, and
> fixes for all the others that affect the A83t quirks. However the fixes
> tags existing in the tree would be wrong and confusing. That might be a
> pain for the stable kernel maintainers.
>
> Any suggestions on how to proceed?

I've just sent two patches to address that (adding a comment in the
process so that hopefully it doesn't happen again).

Let me know if it works, and sorry for the mess :/
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zfutohgftfydg3jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWT5aAAKCRDj7w1vZxhR
xdWcAP92UC8ohpBC1hEZ+YE9YtL68wqEMKjjgaiRbBPuMCI9tQEAvzYPAtyZtF9A
o8AofY1070asyuWTmZNoBs4WWZOnHQ4=
=P/nX
-----END PGP SIGNATURE-----

--zfutohgftfydg3jy--
