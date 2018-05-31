From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S
	mux clock
Date: Thu, 31 May 2018 18:01:17 +0200
Message-ID: <20180531160117.GC2727@piout.net>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF2B26793D
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 18:01:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Mark Brown <broonie@kernel.org>, Cristian.Birsan@microchip.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, linux-clk <linux-clk@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 31/05/2018 09:20:57-0500, Rob Herring wrote:
> On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
> <codrin.ciubotariu@microchip.com> wrote:
> > On 31.05.2018 03:58, Rob Herring wrote:
> >>
> >> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
> >>>
> >>> The I2S mux clock can be used to select the I2S input clock. The
> >>> available parents are the peripheral and the generated clocks.
> >>>
> >>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> >>> ---
> >>>   .../devicetree/bindings/clock/at91-clock.txt       | 34
> >>> ++++++++++++++++++++++
> >>>   1 file changed, 34 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> index 51c259a..1c46b3c 100644
> >>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> >>> @@ -90,6 +90,8 @@ Required properties:
> >>>         "atmel,sama5d2-clk-audio-pll-pmc"
> >>>                 at91 audio pll output on AUDIOPLLCLK that feeds the PMC
> >>>                 and can be used by peripheral clock or generic clock
> >>> +       "atmel,sama5d2-clk-i2s-mux":
> >>> +               at91 I2S clock source selection
> >>
> >>
> >> Is this boolean or takes some values. If latter, what are valid values?
> >
> >
> > This is the compatible string of the clock driver.
> 
> Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
> still a plan to fix this?
> 

There is still a plan to do that, hopefully soon (I'd like to aim for
the next release or the one after).

I think this one should go in as-is so it can be fixed with all the
other one at once.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
