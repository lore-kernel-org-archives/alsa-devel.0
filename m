From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH] ASoC: imx-sgtl5000.c: Add support for
 specifying PDCR_TXRXEN
Date: Thu, 24 Apr 2014 11:09:36 +0200
Message-ID: <20140424110936.78300197@archvile>
References: <1398268218-31897-1-git-send-email-david@protonic.nl>
 <20140424084630.GD7361@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [83.163.252.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ACAB2651D8
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 11:09:31 +0200 (CEST)
In-Reply-To: <20140424084630.GD7361@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: alsa-devel@alsa-project.org

On Thu, 24 Apr 2014 10:46:30 +0200
Markus Pargmann <mpa@pengutronix.de> wrote:

> Hi,
> 
> On Wed, Apr 23, 2014 at 05:50:18PM +0200, David Jander wrote:
> > This enables effectively swapping RX/TX pins on the external audio port
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt | 4 ++++
> >  sound/soc/fsl/imx-sgtl5000.c                                   | 5 ++++-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
> > b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt index
> > e4acdd8..3afea85 100644 ---
> > a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt +++
> > b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt @@ -29,6
> > +29,10 @@ Required properties:
> >  - mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
> >  - mux-ext-port : The external port of the i.MX audio muxer
> >  
> > +Optional properties:
> > +- ext-port-txrxen : Flag. Set to swap RX/TX signals on external port (set
> > the
> > +  IMX_AUDMUX_V2_PDCR_TXRXEN bit in the PDC register of the external port)
> > +
> >  Note: The AUDMUX port numbering should start at 1, which is consistent
> > with hardware manual.
> 
> You could also try to use the simple sound card and use DT properties to
> setup audmux.
> 
> This is a configuration example for the audmux:
> &audmux {
>         status = "okay";
> 
>         aud4 {
>                 fsl,audmux-port = <MX31_AUDMUX_PORT4_SSI_PINS_4>;
>                 fsl,port-config = <
>                         (IMX_AUDMUX_V2_PTCR_SYN |
>                                 IMX_AUDMUX_V2_PTCR_TFSDIR |
>                                 IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT1_SSI0)
> | IMX_AUDMUX_V2_PTCR_TCLKDIR |
>                                 IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT1_SSI0))
>                         IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0)
>                 >;
>         };
> };

I tried this, but the glue driver imx-sgtl5000.c changes the port settings to
its own knowledge.... and that includes hard-coded clearing of the
IMX_AUDMUX_V2_PDCR_TXRXEN bit.

How can I avoid the imx-sgtl5000.c driver from clearing the settings I specify
in the AUDMUX driver?

Best regards,

-- 
David Jander
Protonic Holland.
