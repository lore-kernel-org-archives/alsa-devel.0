From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 2/2 v6] ASoC: dwc: Update DOCUMENTATION for I2S Driver
Date: Wed, 27 Apr 2016 18:32:42 +0100
Message-ID: <5720F7BA.9030500@synopsys.com>
References: <cover.1461749984.git.joabreu@synopsys.com>
 <30ee79f0744cdf3561d43654f1ecf3d486bf7a08.1461749984.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30ee79f0744cdf3561d43654f1ecf3d486bf7a08.1461749984.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Rob Herring <robh@kernel.org>, Carlos Palminha <CARLOS.PALMINHA@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Sorry. Follows bellow.

On 27-04-2016 11:05, Jose Abreu wrote:
> This patch updates documentation for the Designware I2S
> driver.
>
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Carlos Palminha <palminha@synopsys.com>
> Cc: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>
> No changes v5 -> v6.
>
> Changes v4 -> v5:
> * interrupts is now required property
> * Drop 'snps-use-dmaengine' property
>
> This patch was only introduced in v4.
>
>  Documentation/devicetree/bindings/sound/designware-i2s.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/designware-i2s.txt b/Documentation/devicetree/bindings/sound/designware-i2s.txt
> index 7bb5424..27a728f 100644
> --- a/Documentation/devicetree/bindings/sound/designware-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/designware-i2s.txt
> @@ -3,14 +3,18 @@ DesignWare I2S controller
>  Required properties:
>   - compatible : Must be "snps,designware-i2s"
>   - reg : Must contain the I2S core's registers location and length
> + - interrupts: <IRQ> where IRQ is the interrupt number.
>   - clocks : Pairs of phandle and specifier referencing the controller's
>     clocks. The controller expects one clock: the clock used as the sampling
>     rate reference clock sample.
>   - clock-names : "i2sclk" for the sample rate reference clock.
> +
> +Optional properties:
>   - dmas: Pairs of phandle and specifier for the DMA channels that are used by
>     the core. The core expects one or two dma channels: one for transmit and
> -   one for receive.
> - - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
> +   one for receive. Set this parameter if the I2S DMA block is enabled.
> + - dma-names : "tx" for the transmit channel, "rx" for the receive channel. Set
> +   this parameter if the I2S DMA block is enabled.
>  
>  For more details on the 'dma', 'dma-names', 'clock' and 'clock-names'
>  properties please check:
> @@ -23,6 +27,7 @@ Example:
>  	soc_i2s: i2s@7ff90000 {
>  		compatible = "snps,designware-i2s";
>  		reg = <0x0 0x7ff90000 0x0 0x1000>;
> +		interrupts = <15>;
>  		clocks = <&scpi_i2sclk 0>;
>  		clock-names = "i2sclk";
>  		#sound-dai-cells = <0>;
