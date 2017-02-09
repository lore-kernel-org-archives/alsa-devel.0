From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] ASoC: zx-i2s: introduce pclk for
	zx2967 family
Date: Wed, 8 Feb 2017 18:52:07 -0600
Message-ID: <20170209005207.y6wcrzk43ngfslhl@rob-hp-laptop>
References: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
 <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C83266A0A
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 01:52:09 +0100 (CET)
Received: by mail-ot0-f195.google.com with SMTP id f9so220618otd.0
 for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2017 16:52:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1486522955-14528-2-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, mathieu.poirier@linaro.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, shawn.guo@linaro.org, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 08, 2017 at 11:02:34AM +0800, Baoyou Xie wrote:
> ZTE's zx2967 I2S controller driver introduces pclk, this
> patch documents this fact.

Now we have the same subject for patches 2 and 3.

Personally, I'd prefer "dt-bindings: sound: blah...", but not enough to 
argue with Mark about it. If that is not the prefix, then it should at 
least have "binding" in the subject.

> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> index 7e5aa6f..77390c0 100644
> --- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
> @@ -4,7 +4,7 @@ Required properties:
>   - compatible : Must be "zte,zx296702-i2s"
>   - reg : Must contain I2S core's registers location and length
>   - clocks : Pairs of phandle and specifier referencing the controller's clocks.
> - - clock-names: "tx" for the clock to the I2S interface.
> + - clock-names: "wclk" for the wclk, "pclk" for the pclk to the I2S interface.
>   - dmas: Pairs of phandle and specifier for the DMA channel that is used by
>     the core. The core expects two dma channels for transmit.
>   - dma-names : Must be "tx" and "rx"
> @@ -15,13 +15,17 @@ please check:
>  	* clock/clock-bindings.txt
>  	* dma/dma.txt
>  
> +Please note that ZTE ZX296702 I2S controller driver is compatible for zx296702
> +and zx296718, so compatible string might be set as follow:
> +	"zte,zx296718-i2s", "zte,zx296702-i2s"

Drop this and just make compatible doc above like this:

   - compatible : Must be one of:
	"zte,zx296718-i2s", "zte,zx296702-i2s"
	"zte,zx296702-i2s"

> +
>  Example:
>  	i2s0: i2s0@0b005000 {

BTW, this should be "i2s@0b005000". No trailing 0 on i2s and no leading 
0 on unit-address.

>  		#sound-dai-cells = <0>;
> -		compatible = "zte,zx296702-i2s";
> +		compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";
>  		reg = <0x0b005000 0x1000>;
> -		clocks = <&lsp0clk ZX296702_I2S0_DIV>;
> -		clock-names = "tx";
> +		clocks = <&audiocrm AUDIO_I2S0_WCLK>, <&audiocrm AUDIO_I2S0_PCLK>;
> +		clock-names = "wclk", "pclk";
>  		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>  		dmas = <&dma 5>, <&dma 6>;
>  		dma-names = "tx", "rx";
> -- 
> 2.7.4
> 
