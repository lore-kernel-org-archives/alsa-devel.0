From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Sun, 2 Oct 2011 19:40:34 +0100
Message-ID: <20111002184033.GD2857@opensource.wolfsonmicro.com>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C5C1103819
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 20:40:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, lrg@ti.com, ramesh.babu@intel.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2011 at 11:41:52AM -0500, Brian Austin wrote:
> This patch adds support for the Cirrus Logic CS42L73
> low power stereo codec.

A few comments here beyond those others made (though I may be
replicating some of what they said) but overall this is shaping up
well - hopefully next version we can get this merged.

Folks: when replying to patches (or mails in general) you should delete
unneeded context.  This makes it much easier to find the text you wrote,
all the stuff about cutting text improving bandwidth usage applies just
as much to the humans reading your mail as to the computers moving it.

> This patch has cleared checkpatch.pl with no warnings or errors.
> Code changes requested were implemented.
> ASoC API changes requested were implemented.

Stuff like this should go after the ---.

> + * cs42l73.c  --  CS42L73 ALSA Soc Audio driver
> + *
> + * Copyright 2011 Cirrus Logic, Inc.
> + *
> + * Authors: Georgi Vlaev, Nucleus Systems Ltd, <office@nucleusys.com>

Who's not CCed on the patch, and who hasn't signed it off?

> +	SOC_DOUBLE("Input Path Digital Switch", CS42L73_ADCIPC, 0, 4, 1, 1),

s/Input Path/Capture/

> +	SOC_DOUBLE("Invert ADC Signal Polarity Switch", CS42L73_ADCIPC, 1, 5, 1,
> +			0),

ADC Signal Polarity Switch.

> +	SOC_DOUBLE("ADC Boost Switch", CS42L73_ADCIPC, 2, 6, 1, 0),

This should be a Volume control with TLV information assuming it does
what it sounds like and makes the signal louder.

> +	SOC_SINGLE("Charge Pump Frequency Volume", CS42L73_CPFCHC, 4, 15, 0),

No Volume (clearly this isn't a volume control), this should probably be
an enum listing the rates.

> +	SOC_SINGLE("HL Limiter Attack Rate Volume", CS42L73_LIMARATEHL, 0, 0x3F,
> +			0),
> +	SOC_SINGLE("HL Limiter Release Rate Volume", CS42L73_LIMRRATEHL, 0,
> +			0x3F, 0),

Similarly here, you probably want an enumaration showing the rates.

> +	SOC_DOUBLE_R_TLV("XSP-IP Attenuation Volume",
> +			CS42L73_XSPAIPAA, CS42L73_XSPBIPBA, 0, 0x3F, 1,
> +			attn_tlv),

Attenuation Volume makes no sense - they're approximate synonyms.  Just
Volume.

> +	if (clk_id != CS42L73_CLKID_MCLK1 && clk_id != CS42L73_CLKID_MCLK2) {
> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
> +		return -EINVAL;
> +	}

A switch statement would be more idomatic.

> +	if (spc & xSPDIF_PCM) {
> +		spc &= (31 << 3);	/* Clear PCM mode, set MSB->LSB */
> +		if (format == SND_SOC_DAIFMT_DSP_B
> +		    && inv == SND_SOC_DAIFMT_IB_IF)
> +			spc |= (xPCM_MODE0 << 4);
> +		else
> +
> +		    if (format == SND_SOC_DAIFMT_DSP_B
> +				&& inv == SND_SOC_DAIFMT_IB_NF)
> +			spc |= (xPCM_MODE1 << 4);
> +		else
> +
> +		    if (format == SND_SOC_DAIFMT_DSP_A
> +				&& inv == SND_SOC_DAIFMT_IB_IF)
> +			spc |= (xPCM_MODE1 << 4);
> +		else
> +			return -EINVAL;

I can't help but feel this would be clearer with a switch statement.

> +static int cs42l73_set_tristate(struct snd_soc_dai *dai, int tristate)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	int id = dai->id;
> +
> +	return snd_soc_update_bits(codec, CS42L73_SPC(id), 0x7F, tristate << 7);

This is going to fail if someone passes a non-boolean value in - better
make sure that tristate is actually 1 or 0.

> +
> +	 .ops = &cs42l73_ops,
> +	 .symmetric_rates = 1,
> +	 },
> +	{

Please use the kernel coding style for indentation.

> +
> +/* CS42L73_PWRCTL1 */
> +#define PDN_ADCB	(1 << 7)
> +#define PDN_DMICB	(1 << 6)
> +#define PDN_ADCA        (1 << 5)
> +#define PDN_DMICA       (1 << 4)
> +#define PDN_LDO         (1 << 2)
> +#define DISCHG_FILT     (1 << 1)
> +#define PDN             (1 << 0)

All the identifiers in the header need to be namespaced.
