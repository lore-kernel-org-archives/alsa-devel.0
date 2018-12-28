From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Date: Fri, 28 Dec 2018 17:32:26 -0600
Message-ID: <20181228233226.GA11728@bogus>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 18, 2018 at 04:30:01PM +0000, Viorel Suman wrote:
> This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> The Audio Mixer is a on-chip functional module that allows mixing of
> two audio streams into a single audio stream.
> 
> Audio Mixer datasheet is available here:
> https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++

This should be a separate patch.

>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++
>  5 files changed, 710 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,amix.txt
>  create mode 100644 sound/soc/fsl/fsl_amix.c
>  create mode 100644 sound/soc/fsl/fsl_amix.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> new file mode 100644
> index 0000000..049144f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> @@ -0,0 +1,45 @@
> +NXP Audio Mixer (AMIX).
> +
> +The Audio Mixer is a on-chip functional module that allows mixing of two
> +audio streams into a single audio stream. Audio Mixer has two input serial
> +audio interfaces. These are driven by two Synchronous Audio interface
> +modules (SAI). Each input serial interface carries 8 audio channels in its
> +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> +from two interfaces into a single sample. Before mixing, audio samples of
> +two inputs can be attenuated based on configuration. The output of the
> +Audio Mixer is also a serial audio interface. Like input interfaces it has
> +the same TDM frame format. This output is used to drive the serial DAC TDM
> +interface of audio codec and also sent to the external pins along with the
> +receive path of normal audio SAI module for readback by the CPU.
> +
> +The output of Audio mixer can be selected from any of the three streams
> + - serial audio input 1
> + - serial audio input 2
> + - Mixed audio
> +
> +Mixing operation is independent of audio sample rate but the two audio
> +input streams must have same audio sample rate with same number of channels
> +in TDM frame to be eligible for mixing.
> +
> +Device driver required properties:
> +=================================
> +  - compatible		: Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg" for register access.

Humm, no audio related clocks? 

> +
> +  - power-domains	: Must contain the phandle to the AMIX power domain node
> +
> +Device driver configuration example:
> +======================================
> +  amix: amix@59840000 {
> +    compatible = "fsl,imx8qm-amix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_amix>;
> +  };
> +
