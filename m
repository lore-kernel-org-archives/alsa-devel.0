From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v10 2/2] ASoC: fsl: Add S/PDIF machine
	driver
Date: Wed, 21 Aug 2013 20:54:33 +0200
Message-ID: <2125663.4przPy426h@flatron>
References: <cover.1377054540.git.b42378@freescale.com>
 <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
 <52150763.8020707@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BC7A72625F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 20:54:38 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id mz13so330683bkb.30
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 11:54:38 -0700 (PDT)
In-Reply-To: <52150763.8020707@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com, s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 21 of August 2013 12:30:59 Stephen Warren wrote:
> On 08/20/2013 09:13 PM, Nicolin Chen wrote:
> > This patch implements a device-tree-only machine driver for Freescale
> > i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> > fsl_spdif.c drivers.
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> > b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> > 
> > +Optional properties:
> > +
> > +  - spdif-transmitter : The phandle of the spdif-transmitter codec
> > +
> > +  - spdif-receiver : The phandle of the spdif-receiver codec
> > +
> > +* Note: At least one of these two properties should be set in the DT
> > binding.
> I still don't think those two properties are correct.
> 
> Exactly what node will those phandles point at?

Imagine following setup:

  ________              ________________
 |        |     RX     | Microphone DSP |   Analog mic input
 | S/PDIF | <--------< |________________| <-------------------
 |        |             ________________
 |  DAI   | >--------> | Amplifier      | >-------------------
 |________|     TX     |________________|   Speakers output

As you see in the diagram, the S/PDIF interface of the SoC can be 
connected to some external devices that can perform sound processing or 
simply handle the physical layer.

I'd say that normally both RX and TX lines would be connected to a single 
codec chip that has multiple blocks inside, like sound processing, 
amplifier, mixer, etc., but nothing stops you from making a crazy setup, 
when RX and TX lines are connected to different chips.

> There definitely should not be a DT node for any "dummy CODEC",
> irrespective of whether this binding calls the other node a "CODEC" or a
> "dummy CODEC".

I agree. Instead if no chip connected to particular line is specified in 
device tree, it's responsibility of Linux sound core to handle this 
properly by adding a dummy codec or whatever.

> If these properties are to contain phandles, it would be acceptable for
> the referenced node to be:
> 
> * A node representing the physical connector/jack on the board.
> 
> * A node representing some other IP block on the board, such as an HDMI
> encoder/display-controller
> 
> I think those options are unlikely in general

Why? You usually codec SoC DAIs to some external chips.

Best regards,
Tomasz
