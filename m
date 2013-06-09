From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Sun, 09 Jun 2013 19:12:32 +0200
Message-ID: <51B4B780.9040201@metafoo.de>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
 <1370605987-19290-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4C8260309
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 19:09:12 +0200 (CEST)
In-Reply-To: <1370605987-19290-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/07/2013 01:53 PM, Daniel Mack wrote:
> The ADAU1701 has 2 hardware pins to configure the PLL mode in accordance
> to the MCLK-to-LRCLK ratio. These pins have to be stable before the chip
> is released from reset, and a full reset cycle, including a new firmware
> download is needed whenever they change.

I think it makes more sense to let the user provide the mclk frequency and then
let the driver in the hwparams callback choose the right divider based on the
select playback rate.

> 
> This patch adds GPIO properties to the DT bindings of the Codec, and
> implements a callback for the set_clkdiv callback of the DAI.
> 
> To avoid excessive reset cycles and firmware downloads, the default
> clock divider can be specified in DT as well.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  .../devicetree/bindings/sound/adi,adau1701.txt     | 13 ++++
>  sound/soc/codecs/adau1701.c                        | 74 ++++++++++++++++++++++
>  sound/soc/codecs/adau1701.h                        |  4 ++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau1701.txt b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> index 3afeda7..c9c6e98 100644
> --- a/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> +++ b/Documentation/devicetree/bindings/sound/adi,adau1701.txt
> @@ -11,6 +11,19 @@ Optional properties:
>   - reset-gpio: 		A GPIO spec to define which pin is connected to the
>  			chip's !RESET pin. If specified, the driver will
>  			assert a hardware reset at probe time.
> + - adi,pll-clkdiv: 	The PLL clock divider, specifing the ratio between
> +			MCLK and fsclk. The value is used to determine the
> +			correct state of the two mode pins below.
> +			Note that this value can be overridden at runtime
> +			by passing the ADAU1701_CLKDIV_MCLK_LRCLK divider
> +			with ASoC calls. However, the chips needs a full
> +			reset cycle and a new firmware download each time
> +			the configuration changes.
> + - adi,pll-mode0-gpio,
> +   adi,pll-mode1-gpio:	GPIO specs to describe the GPIOs the ADAU's PLL config
> +			pins are connected to. The state of the pins are set
> +			according to the configured clock divider on ASoC side
> +			before the firmware is loaded.

I'd make this one property with two gpios, e.g.:

adi,pll-mode-gpios = <&gpio 12 0 &gpio 34 0>;

- Lars
