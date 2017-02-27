From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/3] ASoC: zx-96p22: add documentation
 for zte's aud96p22 controller
Date: Mon, 27 Feb 2017 11:20:35 -0600
Message-ID: <20170227172035.wm2azn4chevvuise@rob-hp-laptop>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 1129C266CCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 18:20:37 +0100 (CET)
Received: by mail-oi0-f68.google.com with SMTP id f192so1022459oic.3
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 09:20:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
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
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, tiwai@suse.com, srinivas.kandagatla@linaro.org, bardliao@realtek.com, lars@metafoo.de, axel.lin@ingics.com, Paul.Handrigan@cirrus.com, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, devicetree@vger.kernel.org, arnd@arndb.de, yesanishhere@gmail.com, xie.baoyou@zte.com.cn, nh6z@nh6z.net, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, oder_chiou@realtek.com, linux-kernel@vger.kernel.org, petr@barix.com, jun.nie@linaro.org, shawnguo@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 15, 2017 at 06:55:08PM +0800, Baoyou Xie wrote:
> This patch adds dt-binding documentation for zte's aud96p22 controller.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  .../devicetree/bindings/sound/zte,zx-96p22.txt     | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> new file mode 100644
> index 0000000..4184566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/zte,zx-96p22.txt
> @@ -0,0 +1,24 @@
> +ZTE zx96p22 controller
> +
> +Required properties:
> + - compatible : Must be "zte,zx-aud96p22"
> + - #sound-dai-cells: Should be 0
> + - reg : Offset of I2C register for zx96p22
> +
> +Example:
> +
> +	audio_i2c0: audio_i2c0@1486000 {

i2c@...

> +		compatible = "zte,zx296718-i2c";
> +		reg = <0x01486000 0x1000>;
> +		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
> +		clock-frequency = <1600000>;
> +		status = "ok";

No need for status in examples.

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +		inner_codec: aud96p22@22 {
> +			compatible = "zte,zx-aud96p22";
> +			#sound-dai-cells = <0>;
> +			reg = <0x22>;
> +		};
> +	};
> -- 
> 2.7.4
> 
