From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 31 Jul 2013 14:16:27 +0200
Message-ID: <51F9001B.6070203@metafoo.de>
References: <cover.1375271745.git.b42378@freescale.com>
 <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD572615C0
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 14:15:29 +0200 (CEST)
In-Reply-To: <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>
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
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

[...]
a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> new file mode 100644
> index 0000000..a655800
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -0,0 +1,63 @@
> +Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Freescale S/PDIF audio block is a stereo transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,spdif".

That's not what the driver says though.

> +
> +  - reg : Offset and length of the register set for the device.
> +
> +  - interrupts : <a b> where a is the interrupt number and b is a field that
> +    represents an encoding of the sense and level information for the interrupt.
> +    This should be encoded based on the information in section 2) depending on
> +    the type of interrupt controller you have.

The exact layout of the cell depends on the parent interrupt controller, so
you probably shouldn't describe it here.

> +
> +  - clocks : The phandle for the clock ID number registered in clock tree.
> +
> +  - fsl,spdif-dma-events: The dma event ID numbers for Tx and Rx.
> +

Use the generic DMA bindings.

> +Optional properties:
> +
> +  - rx-clk-source : The clock cource for Rx. Need to set this source according
> +  to the SoC datasheet in SPDIF_SRPC section. If absent, the default source is
> +  value 0x0 - if (DPLL Locked) SPDIF_RxClk else extal.
> +
> +  - tx-clk-source : The clock cources for Tx. There're three sources, each for
> +  different supported sample rate, sequentially 32000Hz, 44100Hz and 48000Hz.
> +  Need to set this source according to the SoC datasheet in SPDIF_STC section.
> +  If absent, the default source is value 0x1 - CCM spdif0_clk_root input.
> +
> +  - tx-clk-div : The clock divider factor for Tx clock. There're three values,
> +  each for different supported sample rate, sequentially 32000Hz 44100Hz 48000Hz.
> +  Need to set this source according to the clock rate from the clock source.
> +  If absent, the default divider factor is <37 23 37> by using spdif0_clk source.

Can't the driver figure out the divider values on its own based on the input
clock rate?

- Lars
