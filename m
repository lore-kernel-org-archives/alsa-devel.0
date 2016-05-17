From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 17 May 2016 16:43:33 -0700
Message-ID: <20160517234333.GB29471@Asurada-Nvidia>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A87A62651D3
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 01:43:12 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id 145so3236923pfz.1
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 16:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

   I have two quick questions regarding the DAI and its TDM support.

On Tue, Mar 15, 2016 at 05:47:46PM -0500, tim.howe@cirrus.com wrote:

> +static const struct snd_soc_dapm_route cs53l30_audio_map[] = {
> +
> +	/* ADC Input Paths */
> +	{"ADC1A", NULL, "IN1_DMIC1"},
> +	{"Input Mux 1", "ADC1_SEL", "ADC1A"},
> +	{"ADC1B", NULL, "IN2"},
> +
> +	{"ADC2A", NULL, "IN3_DMIC2"},
> +	{"Input Mux 2", "ADC2_SEL", "ADC2A"},
> +	{"ADC2B", NULL, "IN4"},
> +
> +	/* MIC Bias Paths */
> +	{"ADC1A", NULL, "MIC1 Bias"},
> +	{"ADC1B", NULL, "MIC2 Bias"},
> +	{"ADC2A", NULL, "MIC3 Bias"},
> +	{"ADC2B", NULL, "MIC4 Bias"},
> +
> +	/* DMIC Paths */
> +	{"DMIC1", NULL, "IN1_DMIC1"},
> +	{"Input Mux 1", "DMIC1_SEL", "DMIC1"},
> +
> +	{"DMIC2", NULL, "IN3_DMIC2"},
> +	{"Input Mux 2", "DMIC2_SEL", "DMIC2"},
> +
> +	/* Output Paths */
> +	{"ASP_SDOUT1", NULL, "ADC1A" },
> +	{"ASP_SDOUT1", NULL, "Input Mux 1"},
> +	{"ASP_SDOUT1", NULL, "ADC1B"},
> +
> +	{"ASP_SDOUT2", NULL, "ADC2A"},
> +	{"ASP_SDOUT2", NULL, "Input Mux 2"},
> +	{"ASP_SDOUT2", NULL, "ADC2B"},
> +
> +	{"ASP1 Capture", NULL, "ASP_SDOUT1"},
> +	{"ASP2 Capture", NULL, "ASP_SDOUT2"},
> +};

This codec chip has two SDOUT (Serial Data Output) pins while sharing
one serial port -- there's only one pair of bit clock and fsync clock.

> +static struct snd_soc_dai_driver cs53l30_dai[] = {
> +	{
> +		.name = "cs53l30-asp1",
> +		.id = CS53L30_ASP1,
> +		.capture = {
> +			.stream_name = "ASP1 Capture",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = CS53L30_RATES,
> +			.formats = CS53L30_FORMATS,
> +		},
> +		.ops = &cs53l30_ops,
> +		.symmetric_rates = 1,
> +	 },
> +	{
> +		.name = "cs53l30-asp2",
> +		.id = CS53L30_ASP2,
> +		.capture = {
> +			.stream_name = "ASP2 Capture",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = CS53L30_RATES,
> +			.formats = CS53L30_FORMATS,
> +		},
> +		.ops = &cs53l30_ops,
> +		.symmetric_rates = 1,
> +	 }
> +};

In this case, would it be more appropriate to create one single DAI
with channels_max = 4 over here?

Another question is for its TDM support. This chip outputs 4-channel
data on two data output pins (SDOUT1 and SDOUT2) as normal mode; it
outputs 4-channel data on one data output pin (SDOUT1) as TDM mode.
However, the mode selection for a 4-channel recording should depend
on the hardware design: whether the SDOUT2 is connected or not. So
I am wondering if there is a common way or existing way to indicate
this hardware design. Or just by simply defining a new DT property?

Thank you
Nicolin
