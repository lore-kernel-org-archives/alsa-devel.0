From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v8 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Mon, 19 Aug 2013 15:35:58 -0600
Message-ID: <52128FBE.4080103@wwwdotorg.org>
References: <cover.1376912873.git.b42378@freescale.com>
 <a5b34243c0323e7692fab6a52a7adf4e3e8a5844.1376912873.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 366082608E8
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2013 23:36:08 +0200 (CEST)
In-Reply-To: <a5b34243c0323e7692fab6a52a7adf4e3e8a5844.1376912873.git.b42378@freescale.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, Pawel Moll <pawel.moll@arm.com>, festevam@gmail.com, s.hauer@pengutronix.de, Kumar Gala <galak@codeaurora.org>, timur@tabi.org, rob.herring@calxeda.com, tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de, R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 08/19/2013 06:08 AM, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale
> S/PDIF controller that supports stereo playback and record feature.

> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt

> +Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Freescale S/PDIF audio block is a stereo transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.

Well, the cable type is more a property of the components that are
hooked to the SoC signals that this module drives, so are somewhat out
of scope of this binding document. However, this is nit-picky comment,
and I'm not too worried about it.

> +  - clock-names : Includes the following entries:
> +	"core"		The core clock of spdif controller
> +	"rxtx<0-7>"	Clock source list for tx and rx clock.
> +			This clock list should be identical to
> +			the source list connecting to the spdif
> +			clock mux in "SPDIF Transceiver Clock
> +			Diagram" of SoC reference manual. It
> +			can also be referred to TxClk_Source
> +			bit of register SPDIF_STC.

So, the HW block has 1 clock input, yet there's a mux somewhere else in
the SoC which has 8 inputs?

If so, I'm not completely sure it's correct to reference anything other
than the "core" clock in this binding. I think the other clocks would be
more suitably represented in the system-level "sound card" binding that
I guess patch 2/2 (which I haven't read yet) adds, since I assume those
clock are more to do with system-level clock tree setup decisions, and
might not even exist in some other SoC that included this IP block.

What do others think, assuming I'm correct about my HW design assumptions?
