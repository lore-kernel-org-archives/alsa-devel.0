From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v10 2/2] ASoC: fsl: Add S/PDIF machine
	driver
Date: Wed, 21 Aug 2013 12:30:59 -0600
Message-ID: <52150763.8020707@wwwdotorg.org>
References: <cover.1377054540.git.b42378@freescale.com>
 <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 8183C2610BA
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 20:31:04 +0200 (CEST)
In-Reply-To: <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com, s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/20/2013 09:13 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

> +Optional properties:
> +
> +  - spdif-transmitter : The phandle of the spdif-transmitter codec
> +
> +  - spdif-receiver : The phandle of the spdif-receiver codec
> +
> +* Note: At least one of these two properties should be set in the DT binding.

I still don't think those two properties are correct.

Exactly what node will those phandles point at?

There definitely should not be a DT node for any "dummy CODEC",
irrespective of whether this binding calls the other node a "CODEC" or a
"dummy CODEC".

If these properties are to contain phandles, it would be acceptable for
the referenced node to be:

* A node representing the physical connector/jack on the board.

* A node representing some other IP block on the board, such as an HDMI
encoder/display-controller

I think those options are unlikely in general, so I think instead these
properties should just be Boolean indicating that "something" is
connector to the S/PDIF RX/TX, without specifying what that "something"
is. It doesn't matter what at least in the connector/jack case, although
perhaps it does in the HDMI encoder/display-controller?
