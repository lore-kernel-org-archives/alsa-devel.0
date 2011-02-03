From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding jack
 detection/reporting
Date: Thu, 3 Feb 2011 16:06:40 +0000
Message-ID: <20110203160640.GD2576@opensource.wolfsonmicro.com>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA6FC103A66
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 17:06:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 04:56:22PM +0530, Harsha Priya wrote:
> This patch adds the jack detection logic in sn95031 codec.
> This also adds code for reading the ADC to figure out the
> mic bias and therby report jack type detected

In order to reduce the amount of reposting and review we all need to do
it might be worth restructuring this to get some of the functionality in
independantly of the actual jack detection.

> +/* enables mic bias voltage */
> +void sn95031_enable_mic_bias(struct snd_soc_codec *codec)
> +{
> +	snd_soc_write(codec, SN95031_VAUD, BIT(2)|BIT(1)|BIT(0));
> +	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(2), BIT(2));
> +}

The micbias control looks like one of the things that could go in
independently.  Though looking at the code it looks like this could
actually just be patch 1/3 anyway?

> +/* Enable/Disable the ADC depending on the argument */
> +static void configure_adc(struct snd_soc_codec *sn95031_codec, int val)
> +{
> +	int value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
> +
> +	if (val) {
> +		/* Enable and start the ADC */
> +		value |= (SN95031_ADC_ENBL | SN95031_ADC_START);
> +		value &= (~ADC_NO_LOOP);
> +	} else
> +		/* Just stop the ADC */
> +		value &= (~SN95031_ADC_START);

Use {} on both branches for clarity.

> +/* Initialize the ADC for reading thermistor values. Can sleep. */
> +static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)

Cut'n'paste error with the comment?  The comment does suggest that this
is a general purpose ADC and therefore we ought to implement the ADC
support and then layer the mic detection on top of it so the ADC can be
used for other applications like hardware monitoring.

> +/* end - codec read/write functions */
> +

Unrelated change?

> +int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack,
> +				struct snd_soc_codec *codec)
> +{
> +	int micbias = sn95031_get_mic_bias(codec);
> +
> +	int jack_type = snd_soc_jack_get_type(mfld_jack, micbias);
> +
> +	/* If american headest, program the gpio control registers */
> +	if (micbias >=  SN95031_VOL_HP && micbias <  SN95031_VOL_AM_HS)
> +		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(1));
> +	else
> +		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(0));
> +
> +	pr_debug("jack type detected = %d\n", jack_type);
> +	if (jack_type == SND_JACK_HEADSET)
> +		enable_jack_btn(codec);
> +	return jack_type;
> +}
> +

Should be either static or have an EXPORT_SYOMBOL_GPL?

> +void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
> +		struct mfld_jack_msg_wq *jack_msg)

> +	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
> +	if (jack_msg->intr_id & 0x1) {
> +		pr_debug("short_push detected\n");
> +		mask = status = SND_JACK_BTN_0;
> +	} else if (jack_msg->intr_id & 0x2) {
> +		pr_debug("long_push detected\n");
> +		mask = status = SND_JACK_BTN_1;

Shouldn't this be using a mask of BTN_0 and BTN_1 for both buttons, they
can't be detected simultaneously?

> +#define ADC_CHANLS_MAX 15 /* Number of ADC channels */
> +#define ADC_LOOP_MAX (ADC_CHANLS_MAX - 1)
> +#define ADC_NO_LOOP 0x07

Namespacing for this and most of the other stuff below this.

> +
> +/* ADC channel code values */
> +#define AUDIO_DETECT_CODE 0x06
> +#define AUDIO_GPIO_CTRL 0x070

What exactly is the GPIO configuration done here, BTW - GPIO makes it
sound like this is somehow board specific?

> +static inline void disable_jack_btn(struct snd_soc_codec *codec)
> +{
> +	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
> +}
> +
> +static inline void enable_jack_btn(struct snd_soc_codec *codec)
> +{
> +	snd_soc_write(codec, SN95031_BTNCTRL1, 0x77);
> +	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
> +}

Put these in the source file.
