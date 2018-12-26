From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Date: Thu, 27 Dec 2018 01:24:22 +0800
Message-ID: <CAGoOwPQvc5w05NOVsp6Qw-Ee3CJJCcaU2Dtzwbf+7bUe_kFEbA@mail.gmail.com>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Viorel,

Sorry for the late response, having been on a long vacation.

The code looks pretty clean. Just some small concerns/questions below.

On Wed, Dec 19, 2018 at 12:30 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
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
>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++

I aimn't against the naming here, but it seems to be AUDMIX in RM?

Would it be better to align with that? It's your decision though.

> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> +=================================
> +  - compatible         : Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg                        : Offset and length of the register set for the device.
> +
> +  - clocks             : Must contain an entry for each entry in clock-names.
> +
> +  - clock-names                : Must include the "ipg" for register access.
> +
> +  - power-domains      : Must contain the phandle to the AMIX power domain node
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

>From the description of DT and RM, I don't see how it connects to SAIs.

Are they fixed to SAI0 and SAI1 in imx8qm? Wondering if it'd be better
to have such information in the doc.

> diff --git a/sound/soc/fsl/fsl_amix.c b/sound/soc/fsl/fsl_amix.c

+static const char
+ *width_sel[] = { "16b", "18b", "20b", "24b", "32b", },
+ *pol_sel[] = { "Positive edge", "Negative edge", },
[...]
+static const struct soc_enum fsl_amix_enum[] = {
+/* FSL_AMIX_CTR enums */
[...]
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTWIDTH_SHIFT, width_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTCKPOL_SHIFT, pol_sel),

Should we handle the width in hw_param()?

Why do we change pol here? It feels like against set_fmt().

> +static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +       /* For playback the AMIX is slave, and for record is master */
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +       case SND_SOC_DAIFMT_CBS_CFS:

So it's used either for playback or capture only, not both at same time?

Thanks
Nicolin
