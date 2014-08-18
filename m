From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ASoC: fsl-asrc: Convert to use regmap
 framework's endianness method.
Date: Mon, 18 Aug 2014 13:21:41 +0100
Message-ID: <20140818122141.GG14559@leverpostej>
References: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
 <20140818095155.GD14559@leverpostej>
 <e2a8e001e3d945a9ba9fafc1cfebe0a8@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C0E02654FC
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 14:21:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e2a8e001e3d945a9ba9fafc1cfebe0a8@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "varkabhadram@gmail.com" <varkabhadram@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 18, 2014 at 01:03:14PM +0100, Li.Xiubo@freescale.com wrote:
> >>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++---
> >>  sound/soc/fsl/fsl_asrc.c                             |  6 +-----
> >>  2 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> >> index b93362a..791f372 100644
> >> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> >> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> >> @@ -26,9 +26,12 @@ Required properties:
> >>       "ipg"             Peripheral clock to driver module.
> >>       "asrck_<0-f>"     Clock sources for input and output clock.
> >>
> >> -   - big-endian              : If this property is absent, the little endian mode
> >>-                       will be in use as default. Otherwise, the big endian
> >> -                       mode will be in use for all the device registers.
> >> +   - big-endian              : If this property is absent, the native endian mode
> >> +                       (same with CPU) will be in use as default. Otherwise,
> >> +                       the big endian mode will be in use for all the device
> >> +                       registers.
> >> +                       See Documentation/devicetree/bindings/regmap/regmap.txt
> >> +                       for more detail.
> >
> >Why does this have to change the semantics of the DT binding?
> >
> 
> I'm thinking that maybe in the late fulture, this device will be
> applied to some PowerPC SoC, from the regmap framework code, we can
> see that the 'big-endian' property could be ignored.
> 
> So,in this case,  if it is absent, the default endian mode should be
> used as defualt or native as the regmap framework said.

As I have mentioned in the past w.r.t. endianness bindings, there is no
such thing as a "default endianness" or "native endianness".

PowerPC and ARM can be Bi-endian, configured by the kernel.

The hardware's registers have a fixed endianness regardless of this
runtime configuration.

So describe that fixed property, as that does not vary with kernel
configuration (and is therefore a property of the HW rather than the
combination of HW + kernel).

Thanks,
Mark.
