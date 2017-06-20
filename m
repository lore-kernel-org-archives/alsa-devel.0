From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: zx_aud96p22: add ZTE ZX AUD96P22
	codec driver
Date: Tue, 20 Jun 2017 13:40:59 +0100
Message-ID: <20170620124059.r55r363y3y3if6jg@sirena.org.uk>
References: <1497708574-22380-1-git-send-email-shawnguo@kernel.org>
 <1497708574-22380-3-git-send-email-shawnguo@kernel.org>
 <20170619161910.siea75hqxgtxhjmp@sirena.org.uk>
 <20170620031953.GC4818@x250>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3617728565619827489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FBCC26680F
 for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2017 14:41:10 +0200 (CEST)
In-Reply-To: <20170620031953.GC4818@x250>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3617728565619827489==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o6evzgh4tsf74a5o"
Content-Disposition: inline


--o6evzgh4tsf74a5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2017 at 11:19:55AM +0800, Shawn Guo wrote:
> On Mon, Jun 19, 2017 at 05:19:10PM +0100, Mark Brown wrote:
> > On Sat, Jun 17, 2017 at 10:09:34PM +0800, Shawn Guo wrote:

> > > +	/* Overall power-up */
> > > +	regmap_update_bits(regmap, AUD96P22_PD_0, PD_0_PDZ, PD_0_PDZ);

> > Why is this not done with DAPM?

> As this is a overall power bit, which is not for any specific component.
> I'm not sure which DAPM widget should be used for it, and how it should
> be arranged in the widget route.  Any suggestion or example will be
> appreciated.

Sounds like a fairly standard use for a supply widget.

> > > +	/* Reset ADC and DAC path */
> > > +	regmap_write(regmap, AUD96P22_RESET, 0x0);
> > > +	regmap_write(regmap, AUD96P22_RESET, 0x3);

> > What does this mean?

> It's a de-assert/assert of ADC and DAC reset.  I will add proper
> defines for the bits to make this clear.

Why are we resetting these - won't this loose settings?  And if it's
just something to be done as part of starting the DAC and ADC why isn't
it done via DAPM?

--o6evzgh4tsf74a5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllJF9oACgkQJNaLcl1U
h9DWvwf/SBXv7ersxFpBQKrImH48bUc369WD4ad8tqt+I/KOul39BqTlxogeDyN1
T9pdvn6TXglEHdFXDeGeiDhcKO0HGSvirhdDqAD3qrRo33R40peba1I+I2EhCVdt
N76tMREeW2spdrXmsAmQKdEyC6O6Nwbp21eU2Q8cbnwHg70uKwZKf519AeXiNbM5
IHBpDz5b2NAlTQDoB7oAR49FT1hBVd8Ht5axEk8S9UkoReq2DNG8wgyT9lc5gwSP
2c4pUN7/A9Slr61jtRM8I0miskuK+V4Dhc83fNBnNi/3KrCEHW6D+EWDY/fKuunB
Fw0kapNxqlzkET3+L/9YESH0NtOdoQ==
=gu/p
-----END PGP SIGNATURE-----

--o6evzgh4tsf74a5o--

--===============3617728565619827489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3617728565619827489==--
