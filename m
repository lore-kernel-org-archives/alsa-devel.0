From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: msm8916: Add msm8916-wcd
	codec driver
Date: Wed, 15 Jun 2016 10:31:36 +0100
Message-ID: <20160615093136.GW2282@sirena.org.uk>
References: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org>
 <20160614155938.GS2282@sirena.org.uk> <57611CEB.4030401@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7850931911066758799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 518952608B3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 11:31:48 +0200 (CEST)
In-Reply-To: <57611CEB.4030401@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============7850931911066758799==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xxgoS+Xwt19NyhFM"
Content-Disposition: inline


--xxgoS+Xwt19NyhFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2016 at 10:16:27AM +0100, Srinivas Kandagatla wrote:
> On 14/06/16 16:59, Mark Brown wrote:
> > On Fri, Jun 10, 2016 at 07:18:45PM +0100, Srinivas Kandagatla wrote:

> > > +config SND_SOC_MSM8916_WCD
> > > +	tristate "Qualcomm MSM8916 WCD"
> > > +	depends on SPMI && MFD_SYSCON

> > Normally users select MFD_SYSCON.

> This driver is child of spmi bus so, we need SPMI dependency here along with
> SYSCON.

That does not seem relevant to the problem with depending on MFD_SYSCON.

> > > +#include "msm8916-wcd-registers.h"
> > > +#include "msm8916-wcd.h"
> > > +#include "dt-bindings/sound/msm8916-wcd.h"

> > What's in here?  There weren't any constants in the bindings.

> Yes, there are DAI id's which are used in device trees.

That doesn't make them present in the binding document...

> > Why is this one device and not two devices?  The description indicated
> > that this was two separate bits of silicon.

> In theory there are 3 devices,
> one is the pmic-spmi driver, which provides regmap access to analog part of
> codec registers.
> second is syscon driver which provides regmap access to digital parts of
> codec to codec driver.
> third is the codec driver which uses both the above.

> Codec registers range is just split into two, range 0x0- 0x200 sits in pmic
> address space and range 0x201 - 0x4ff in the SOC address space,

> Are there any other better ways to model this kinda driver?

Why not just have separate devices for each of the register maps?

> > > +static const struct of_device_id msm8916_wcd_match_table[] = {
> > > +	{.compatible = "qcom,msm8916-pmic-wcd-codec"},
> > > +	{}
> > > +};

> > We were peering inside the parent for the register map, why does this

> I think that's the only way/interface to access PMIC spmi registers I guess.

Don't guess, understand what the code is doing.

> > appear in the device tree as a separate device?  Both the patch

> This node is child of spmi bus, like the other spmi devices.

If this is a SPMI device it needs to register a SPMI device not a
platform device.

--xxgoS+Xwt19NyhFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYSB3AAoJECTWi3JdVIfQNvoH/2Wujpv59u8+3Vp6Dm94iHTh
SUmobQFKZukBsnVTKnZgnrCAZFYJS40/4t1dqCdsggPvj2w/9dvdZWDyJxecNCVq
07LB82lCkXxKJSfYsZqajD055sdJXJ/K8lZB+ancA6ifQGDYFct/CQms8vpJxGUQ
9ZJ5kpMGUvKPJK6xT+jdrMNIu9znOV1q6N+SUnuAzHFAQgjyBL+znCVpnr7goLgg
FimBzLpbHkpDmZbOUIs11IxZrBoi/aF6UhEQOnduDNl5kpS1JckIb5RHJaaP19xb
PB1wxtur3472cNys8wgA11I5hMhy2Z21dB1csh4zCLQIG/vQMPrE/SJGkA0t3Js=
=NbjN
-----END PGP SIGNATURE-----

--xxgoS+Xwt19NyhFM--

--===============7850931911066758799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7850931911066758799==--
