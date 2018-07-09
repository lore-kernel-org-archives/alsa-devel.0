From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Date: Mon, 9 Jul 2018 13:03:31 +0100
Message-ID: <20180709120331.GD16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <2110bdcf-96ad-deb5-a5cb-767d7b2e242d@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2110bdcf-96ad-deb5-a5cb-767d7b2e242d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 05:31:04PM +0530, Rohit Kumar wrote:
> On 7/9/2018 4:44 PM, Mark Brown wrote:
> > On Fri, Jul 06, 2018 at 03:13:13PM +0530, Rohit kumar wrote:

> > > +static const struct component_master_ops sdm845_ops = {
> > > +	.bind = sdm845_bind,
> > > +	.unbind = sdm845_unbind,
> > > +};

> > Why is this using the component stuff rather than the normal support for
> > finding the components of audio cards?

> QCOM soundcard is dependent on platform and cpu dais which gets registered
> only when ADSP is up.

This doesn't answer the question...

> This is the design being followed in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/qcom/apq8096.c?h=v4.18-rc4#n132

Oh dear, missed that :(  This is also broken and should be fixed.

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDTxIACgkQJNaLcl1U
h9Bf9QfzBxfpdaf3Kgqek9OEaRg8qCwBJTPClTwxSL64WDXtnM9oqDQxuxgQW/3q
z9HMBar0c5vcZoaqfhDGD2Zh0ZFryjPrij/GMJEDmzi3P2X71c27yzWXu5zImwLI
3DjgmHs/Sbnu6XiSdadvPIRTqy8zXCT7jX8+OSfDDymzlAROQ8PqcFFDfHwY+PLe
lKvQgqv+k7DGQBCDktZOOA2LbrskCg2TlEkdT3LxXBEJWyNcY6lrpxvuhEOUdoWl
VeYsm91cvGYBmRJA4QUMCHzLOp3nL61k9hTaSGXhoQLtumubpsOHHz2Ovnmg2JR2
4TjGGhaf6JhB9wesxiHaW1t6cldK
=g8ov
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
