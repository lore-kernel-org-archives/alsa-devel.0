From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3] ASoC: Add support for BCM2835
Date: Mon, 18 Nov 2013 14:16:37 +0000
Message-ID: <20131118141637.GI30853@e106331-lin.cambridge.arm.com>
References: <5289F9DF.8060406@koalo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 46C29261A06
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2013 15:16:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5289F9DF.8060406@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: devicetree <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 18, 2013 at 11:28:31AM +0000, Florian Meier wrote:
> This driver adds support for digital audio (I2S)
> for the BCM2835 SoC that is used by the
> Raspberry Pi. External audio codecs can be
> connected to the Raspberry Pi via P5 header.
> 
> It relies on cyclic DMA engine support for BCM2835.
> 
> Signed-off-by: Florian Meier <florian.meier@koalo.de>
> ---
> 
> This successor of RFCv2 is no longer dependent on the dmaengine
> patch (of course you need it for running it). Therefore, it
> should cleanly apply.
> 
> Furthermore, some minor enhancements were applied. For example
> - Removal of bcm2835-pcm.c and .h
> - Adding bindings documentation
> - Adding possibility for setting bclk_ratio
> 
>  .../devicetree/bindings/sound/bcm2835-i2s.txt      |   22 +
>  sound/soc/Kconfig                                  |    1 +
>  sound/soc/Makefile                                 |    1 +
>  sound/soc/bcm/Kconfig                              |   10 +
>  sound/soc/bcm/Makefile                             |    5 +
>  sound/soc/bcm/bcm2835-i2s.c                        |  904 ++++++++++++++++++++
>  6 files changed, 943 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
>  create mode 100644 sound/soc/bcm/Kconfig
>  create mode 100644 sound/soc/bcm/Makefile
>  create mode 100644 sound/soc/bcm/bcm2835-i2s.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
> new file mode 100644
> index 0000000..7bf1d04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/bcm2835-i2s.txt
> @@ -0,0 +1,22 @@
> +* Broadcom BCM2835 SoC I2S/PCM module
> +
> +Required properties:
> +- compatible: "brcm,bcm2835-i2s"
> +- reg: Register location and size
> +       <PCM base address, size
> +        PCM clock base address, size>;

I'd prefer something like:

- reg: A list of base address and size entries:
  * The first entry should cover the PCM registers
  * The second entry should cover the PCM clock registers

Are the clocks actually a sub-block, or are they actually a separate
unit that just happens to feed this one?

> +- dmas: List of DMA controller phandle and DMA request line ordered pairs.
> +- dma-names: Identifier string for each DMA request line in the dmas property.
> +  These strings correspond 1:1 with the ordered pairs in dmas.

It should be pointed out that "tx" and "rx" are expected.

> +
> +Example:
> +
> +bcm2835_i2s: i2s@7e203000 {
> +       compatible = "brcm,bcm2835-i2s";
> +       reg = < 0x7e203000 0x20
> +               0x7e101098 0x02>;

Please bracket entries individually:

reg = <0x7e203000 0x20>,
      <0x7e101098 0x02>;

> +
> +       dmas = <&dma 2
> +               &dma 3>;

Similarly:

dmas = <&dma 2>,
       <&dma 3>;

[...]

> +static void bcm2835_i2s_stop_clock(struct bcm2835_i2s_dev *dev)
> +{
> +       uint32_t clkreg;

s/uint32_t/u32/ (and elsewhere...)

[...]

> +       target_frequency = sampling_rate*bclk_ratio;

It would be nicer if there were space around binary operators here and
elsewhere.

> +       clk_src = BCM2835_CLK_SRC_OSC;
> +       mash = BCM2835_CLK_MASH_0;
> +
> +       if (bcm2835_clk_freq[clk_src] % target_frequency == 0
> +                       && bit_master && frame_master) {
> +               divi = bcm2835_clk_freq[clk_src]/target_frequency;
> +               divf = 0;
> +       } else {
> +               uint64_t dividend;

s/uint64_t/u64/

[...]

> +       ch2pos = bclk_ratio/2+data_delay;

Spacing would make this far nicer...

Thanks,
Mark.
