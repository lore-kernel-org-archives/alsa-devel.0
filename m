From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] ASoC: Add pcm9211 driver
Date: Wed, 31 May 2017 12:16:05 -0500
Message-ID: <20170531171605.ugtpiroui37ktxgz@rob-hp-laptop>
References: <20170524103547.9252-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FDDB26691F
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 19:16:08 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id w138so2889949oiw.3
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 10:16:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170524103547.9252-1-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, quozl@laptop.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, May 24, 2017 at 12:35:47PM +0200, Julian Scheel wrote:
> This adds a driver for the TI PCM9211 digital audio interface
> transceiver. The driver currently only handles the receiver aspect of
> the chip. Some extra device-tree fields are introduced to allow
> configuration of pin functions directly out of this driver.
> 
> Signed-off-by: Julian Scheel <julian@jusst.de>
> 
> ---
> Changes in v2:
> - Fix checkpatch errors (long lines, * association)
> - Fix typos in device-tree documentation
> - Fix group-function dt. Mask was applied on unshifted data
> - Fix error check for int0 gpio lookup
> - Fix ADC rate list (92->96kHz)
> - Add support for AUXOUT as second DAI
> 
>  .../devicetree/bindings/sound/pcm9211.txt          |  119 ++

Matching the compatible for filename is preferred, so "ti,pcm9211.txt".

>  MAINTAINERS                                        |    6 +
>  include/dt-bindings/sound/pcm9211.h                |   55 +
>  sound/soc/codecs/Kconfig                           |   10 +
>  sound/soc/codecs/Makefile                          |    4 +
>  sound/soc/codecs/pcm9211-i2c.c                     |   65 +
>  sound/soc/codecs/pcm9211.c                         | 1446 ++++++++++++++++++++
>  sound/soc/codecs/pcm9211.h                         |  206 +++
>  8 files changed, 1911 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm9211.txt
>  create mode 100644 include/dt-bindings/sound/pcm9211.h
>  create mode 100644 sound/soc/codecs/pcm9211-i2c.c
>  create mode 100644 sound/soc/codecs/pcm9211.c
>  create mode 100644 sound/soc/codecs/pcm9211.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm9211.txt b/Documentation/devicetree/bindings/sound/pcm9211.txt
> new file mode 100644
> index 000000000000..df3974368125
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/pcm9211.txt
> @@ -0,0 +1,119 @@
> +PCM9211 audio CODEC

TI PCM9211...

> +
> +This device supports both I2C and SPI (configured with pin strapping
> +on the board). The driver is currently implementing i2c only.

What the driver supports is not relevant to the binding.

> +
> +Required properties:
> +
> +  - compatible : "ti,pcm9211"
> +
> +  - reg : the I2C address of the device for I2C, the chip select
> +          number for SPI.
> +
> +  - VCCAD-supply, VCC-supply, VDDRX-supply and AVDD-supply :
> +    power supplies for the device, as covered in
> +    bindings/regulator/regulator.txt
> +
> +Optional properties:
> +
> +  - clocks : A clock specifier for the clock connected to XTI. While the
> +    device could work without it, this driver currently relies on it being
> +    available
> +
> +  - clock-names : Must specify "xti" to match the requested clock.
> +
> +  - reset-gpios : GPIO wired to the reset pin, if not supplied a soft-reset is
> +    used as fallback
> +
> +  - int0-gpios : GPIO connected to interrupt0 output of the PCM9211. The
> +    line can be configured to any of MPO0,1 and MPIOA,B,C0-4 and error/int0.
> +    If this is specified it is used as an interrupt to notify alsa controls

alsa is a Linux detail not relevant to the binding.

> +    about changes of the incoming sampling rate on DIR (spdif) as well as NPCM
> +    status.

This should use interrupts property instead.

> +
> +  - ti,group-function: An array with size 3 specifying function for pingroups
> +    A, B and C. Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-a-flags-gpio: An array with size 4 specifying flags out or gpio
> +    mode per pin, when function DIR_FLAGS_GPIO is selected for group a.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-b-flags-gpio: An array with size 4 specifying flags out or gpio
> +    mode per pin, when function DIR_FLAGS_GPIO is selected for group b.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-c-flags-gpio: An array with size 4 specifying flags out or gpio
> +    mode per pin, when function DIR_FLAGS_GPIO is selected for group c.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-a-flag: An array with size 4 specifying flag assigned per pin,
> +    when function DIR_FLAGS_GPIO is selected for group a and pin is set to
> +    flags mode.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-b-flag: An array with size 4 specifying flag assigned per pin,
> +    when function DIR_FLAGS_GPIO is selected for group b and pin is set to
> +    flags mode.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpio-c-flag: An array with size 4 specifying flag assigned per pin,
> +    when function DIR_FLAGS_GPIO is selected for group c and pin is set to
> +    flags mode.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,mpo-function: An array with size 2 specifying flag assigned per mpo
> +    pin.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,int0-function: Selects error/int0 pin function.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h
> +
> +  - ti,int1-function: Selects error/int1 pin function.
> +    Possible values are defined in dt-bindings/sound/pcm9211.h

This all looks like your own custom pinmuxing properties. We already 
have a common binding for that.

> +
> +Examples:
> +
> +	pcm9211: pcm9211@43 {
> +		compatible = "ti,pcm9211";
> +		reg = <0x43>;
> +
> +		VCCAD-supply = <&reg_5v0_analog>;
> +		VCC-supply = <&reg_3v3_pll_analog>;
> +		VDDRX-supply = <&reg_3v3>;
> +		DVDD-supply = <&reg_3v3>;
> +
> +		clocks = <&xti_clk>;
> +		clock-names = "xti";
> +	};
> +
> +
> +	pcm9211: pcm9211@43 {

audio-codec@...

> +		compatible = "ti,pcm9211";
> +		reg = <0x43>;
> +
> +		VCCAD-supply = <&reg_5v0_analog>;
> +		VCC-supply = <&reg_3v3_pll_analog>;
> +		VDDRX-supply = <&reg_3v3>;
> +		DVDD-supply = <&reg_3v3>;
> +
> +		clocks = <&xti_clk>;
> +		clock-names = "xti";
> +
> +		reset-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		int-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +
> +		ti,group-function = /bits/ 8
> +			<PCM9211_MPIO_A_GROUP_BIPHASE_INPUT,
> +			PCM9211_MPIO_B_GROUP_DIR_FLAGS_GPIO,
> +			PCM9211_MPIO_C_GROUP_AUXIN1>;
> +		ti,mpio-b-flags-gpio = /bits/ 8
> +			<PCM9211_MPIO_DIR_FLAGS,
> +			PCM9211_MPIO_DIR_FLAGS,
> +			PCM9211_MPIO_DIR_FLAGS,
> +			PCM9211_MPIO_DIR_FLAGS>;
> +		ti,mpio-b-flag = /bits/ 8
> +			<PCM9211_MPIO_FLAG_INT0,
> +			PCM9211_MPIO_FLAG_CLKST,
> +			PCM9211_MPIO_FLAG_CLKST,
> +			PCM9211_MPIO_FLAG_CLKST>;
> +	};
