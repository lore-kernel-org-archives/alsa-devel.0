From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031 codec - adding jack
 detection/reporting
Date: Fri, 4 Feb 2011 11:19:24 +0530
Message-ID: <98769532B4BB14429434178695419EAE08C107FDA5@bgsmsx501.gar.corp.intel.com>
References: <1296732382-923-1-git-send-email-priya.harsha@intel.com>
	<20110203160640.GD2576@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1129C103876
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 06:49:30 +0100 (CET)
In-Reply-To: <20110203160640.GD2576@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>> This patch adds the jack detection logic in sn95031 codec.
>> This also adds code for reading the ADC to figure out the
>> mic bias and therby report jack type detected
>
>In order to reduce the amount of reposting and review we all need to do
>it might be worth restructuring this to get some of the functionality in
>independantly of the actual jack detection.
I will add just jack detection in this patch series and create another patch
set for parsing mic voltages and returning the jack type

>> +/* enables mic bias voltage */
>> +void sn95031_enable_mic_bias(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_write(codec, SN95031_VAUD, BIT(2)|BIT(1)|BIT(0));
>> +	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(2), BIT(2));
>> +}
>
>The micbias control looks like one of the things that could go in
>independently.  Though looking at the code it looks like this could
>actually just be patch 1/3 anyway?
I will send it as a separate patch. 

>
>> +/* Enable/Disable the ADC depending on the argument */
>> +static void configure_adc(struct snd_soc_codec *sn95031_codec, int val)
>> +{
>> +	int value = snd_soc_read(sn95031_codec, SN95031_ADC1CNTL1);
>> +
>> +	if (val) {
>> +		/* Enable and start the ADC */
>> +		value |= (SN95031_ADC_ENBL | SN95031_ADC_START);
>> +		value &= (~ADC_NO_LOOP);
>> +	} else
>> +		/* Just stop the ADC */
>> +		value &= (~SN95031_ADC_START);
>
>Use {} on both branches for clarity.
I will add them

>
>> +/* Initialize the ADC for reading thermistor values. Can sleep. */
>> +static int sn95031_initialize_adc(struct snd_soc_codec *sn95031_codec)
>
>Cut'n'paste error with the comment?  The comment does suggest that this
>is a general purpose ADC and therefore we ought to implement the ADC
>support and then layer the mic detection on top of it so the ADC can be
>used for other applications like hardware monitoring.
>
>> +/* end - codec read/write functions */
>> +
>
>Unrelated change?
I actually added this comment to virtually tell that the above functions were
for ADC and this was for read/write. I will add them another time.

>
>> +int sn95031_get_headset_state(struct snd_soc_jack *mfld_jack,
>> +				struct snd_soc_codec *codec)
>> +{
>> +	int micbias = sn95031_get_mic_bias(codec);
>> +
>> +	int jack_type = snd_soc_jack_get_type(mfld_jack, micbias);
>> +
>> +	/* If american headest, program the gpio control registers */
>> +	if (micbias >=  SN95031_VOL_HP && micbias <  SN95031_VOL_AM_HS)
>> +		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(1));
>> +	else
>> +		snd_soc_update_bits(codec, AUDIO_GPIO_CTRL, BIT(1), BIT(0));
>> +
>> +	pr_debug("jack type detected = %d\n", jack_type);
>> +	if (jack_type == SND_JACK_HEADSET)
>> +		enable_jack_btn(codec);
>> +	return jack_type;
>> +}
>> +
>
>Should be either static or have an EXPORT_SYOMBOL_GPL?
This should be EXPORT_SYOMBOL_GPL. Will add the same.

>
>> +void sn95031_jack_detection(struct snd_soc_jack *mfld_jack,
>> +		struct mfld_jack_msg_wq *jack_msg)
>
>> +	pr_debug("interrupt id read in sram = 0x%x\n", jack_msg->intr_id);
>> +	if (jack_msg->intr_id & 0x1) {
>> +		pr_debug("short_push detected\n");
>> +		mask = status = SND_JACK_BTN_0;
>> +	} else if (jack_msg->intr_id & 0x2) {
>> +		pr_debug("long_push detected\n");
>> +		mask = status = SND_JACK_BTN_1;
>
>Shouldn't this be using a mask of BTN_0 and BTN_1 for both buttons, they
>can't be detected simultaneously?
No. They can't be detected simultaneously. It's the same button giving 
Interrupts for long press and short press based on the duration of the press

>
>> +#define ADC_CHANLS_MAX 15 /* Number of ADC channels */
>> +#define ADC_LOOP_MAX (ADC_CHANLS_MAX - 1)
>> +#define ADC_NO_LOOP 0x07
>
>Namespacing for this and most of the other stuff below this.
I will add them.

>
>> +
>> +/* ADC channel code values */
>> +#define AUDIO_DETECT_CODE 0x06
>> +#define AUDIO_GPIO_CTRL 0x070
>
>What exactly is the GPIO configuration done here, BTW - GPIO makes it
>sound like this is somehow board specific?
This is board specific to handle different types of jack and I will move it machine driver. Sorry that I missed it.

>
>> +static inline void disable_jack_btn(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_write(codec, SN95031_BTNCTRL2, 0x00);
>> +}
>> +
>> +static inline void enable_jack_btn(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_write(codec, SN95031_BTNCTRL1, 0x77);
>> +	snd_soc_write(codec, SN95031_BTNCTRL2, 0x01);
>> +}
>
>Put these in the source file.
I will move them to source file.

-Harsha
