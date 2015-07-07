From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] arm64: dts: mt8173: Add afe device node
Date: Tue, 07 Jul 2015 09:46:55 +0200
Message-ID: <25205102.t939MQMDBD@ubix>
References: <1436165530-41963-1-git-send-email-koro.chen@mediatek.com> <CAGS+omCOzJs=VWboU_7doUum6BEfmh1hV88HmJiin2c-A_n_Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCOzJs=VWboU_7doUum6BEfmh1hV88HmJiin2c-A_n_Mw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Monday, July 06, 2015 09:02:38 PM Daniel Kurtz wrote:
> On Mon, Jul 6, 2015 at 2:52 PM, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > This adds afe (audio front end) device node to the MT8173 dtsi file.
> > 
> > This patch is based on Matthias's tree:
> > https://github.com/mbgg/linux-mediatek
> > branch: v4.2-next/arm64
> > 
> > Signed-off-by: Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> > 
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 32
> >  ++++++++++++++++++++++++++++++++ 1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8173.dtsi index 0696f8f..f8afab4 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> > @@ -14,6 +14,7 @@
> > 
> >  #include <dt-bindings/clock/mt8173-clk.h>
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > 
> > +#include <dt-bindings/power/mt8173-power.h>
> > 
> >  #include <dt-bindings/reset-controller/mt8173-resets.h>
> >  #include "mt8173-pinfunc.h"
> > 
> > @@ -393,6 +394,37 @@
> > 
> >                         #size-cells = <0>;
> >                         status = "disabled";
> >                 
> >                 };
> > 
> > +
> > +               afe: mt8173-afe-pcm@11220000  {
> 
> I believe this should be something generic, like:
> 
>   afe: audio-controller@11220000
> 

Yes, please find a name that better describes the component instead of just 
using the compatible string.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
