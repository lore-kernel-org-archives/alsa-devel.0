From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver
Date: Wed, 31 Jul 2013 14:12:18 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD0CC2E0AA@039-SN2MPN1-023.039d.mgd.msft.net>
References: <cover.1375271745.git.b42378@freescale.com>
 <30e7b0fec9e813b8765514e48296ebecc6ca1039.1375271745.git.b42378@freescale.com>,
 <51F9001B.6070203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB472615F2
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 16:12:22 +0200 (CEST)
In-Reply-To: <51F9001B.6070203@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "timur@tabi.org" <timur@tabi.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi Lars

Thank you for the sage advices.

I'll revise the patch and send the v2.
________________________________________
From: Lars-Peter Clausen [lars@metafoo.de]
Sent: Wednesday, July 31, 2013 8:16 PM
To: Chen Guangyu-B42378
Cc: broonie@kernel.org; timur@tabi.org; alsa-devel@alsa-project.org; linuxppc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org; rob.herring@calxeda.com
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: fsl: Add S/PDIF CPU DAI driver

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
