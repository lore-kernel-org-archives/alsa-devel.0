From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 1/4] ASoC SST: Add msic codec driver
Date: Tue, 28 Dec 2010 14:48:05 +0000
Message-ID: <20101228144805.GC31883@opensource.wolfsonmicro.com>
References: <1293538176-31853-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5EB421038CE
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 15:47:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293538176-31853-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 05:39:36PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch adds the msic asoc codec driver. This driver currently supports only playback.
> Capture and jack detection to be added later


>  sound/soc/codecs/msic.c |  721 +++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/msic.h |  102 +++++++
>  2 files changed, 823 insertions(+), 0 deletions(-)

Makefile and Kconfig too please.

> +static inline int msic_modify(struct snd_soc_codec *codec,
> +		unsigned int reg, unsigned int value, unsigned int mask)
> +{
> +	int ret;
> +
> +	pr_debug("Modify for %x with %x of mask %x\n", reg, value, mask);
> +	ret = intel_scu_ipc_update_register(reg, value, mask);
> +	if (ret)
> +		pr_err("modify of %x failed, err %d\n", reg, ret);
> +	return ret;
> +}

snd_soc_update_bits().

> +/*sound controls*/
> +static const char *headset_switch_text[] = {"Earpiece", "HeadSet"};

Headset.

> +static int headset_set_switch(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> +	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
> +
> +	if (ucontrol->value.integer.value[0] == msic->hs_switch)
> +		return 0;
> +
> +	if (ucontrol->value.integer.value[0]) {
> +		pr_debug("hs_set HS path\n");
> +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
> +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
> +		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
> +	} else {
> +		pr_debug("hs_set EP path\n");
> +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
> +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
> +		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");

This should be implemented in the machine driver if it's useful.
Putting this in the CODEC driver restricts the system design as it
prevents both outputs being simultaneously active and means that the
system can't do things like drive selection between the headset and
earpiece outputs automatically from jack detection.

> +static void msic_lo_enable_out_pins(struct snd_soc_codec *codec)
> +{
> +	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
> +
> +	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTL");
> +	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTR");
> +	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTL");
> +	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTR");
> +	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
> +	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
> +	if (msic->hs_switch) {
> +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
> +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
> +		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
> +	} else {
> +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
> +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
> +		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
> +	}

This also looks like it's in the machine driver domain.

> +	switch (level) {
> +	case SND_SOC_BIAS_PREPARE:
> +	case SND_SOC_BIAS_STANDBY:
> +		break;
> +
> +	case SND_SOC_BIAS_ON:
> +		pr_debug("vaud_bias doing rail statup now\n");
> +		/*power up the rail*/
> +		msic_write(codec, MSIC_VAUD, BIT(2)|BIT(1)|BIT(0));
> +		msleep(1);
> +		/*power up the pll*/
> +		msic_write(codec, MSIC_AUDPLLCTRL, BIT(5));

In general _ON should be doing the absolute minimum possible - it's done
after everything else has been brought up.  Depending on what these are
controlling they should be either in _PREPARE (audio is about to start)
or _STANDBY (the system is idle).

> +		/*adding pcm 2 here for a while*/
> +		msic_modify(codec, MSIC_PCM2C2, BIT(0), BIT(0));
> +		break;

Hrm?

> +static int msic_vhs_event(struct snd_soc_dapm_widget *w,
> +		    struct snd_kcontrol *kcontrol, int event)
> +{
> +	pr_debug("msic_vhs_event %d\n", event);
> +	if (event == SND_SOC_DAPM_PRE_PMU) {

SND_SOC_DAPM_EVENT_ON().

> +	/*playback paths speaker, dac, filter, rx selector*/
> +	SND_SOC_DAPM_SWITCH("Headset Left Playback",
> +		MSIC_DRIVEREN, 0, 0, &msic_driver_controls[0]),

Don't use big arrays of enumerated controls that you reference by
number; use individually named variables.  The numeric references are
error prone and hard to read.

Most of these look like they're just plain mute controls which would
more normally be represented as regular sound controls not related to
power, leaving these controls as PGAs (which is what they mostly appear
to be).  That would make the sequencing better, I expect, and would give
stereo controls to the application layer which is more normal.

> +
> +	/*SND_SOC_DAPM_MICBIAS("Mic Bias", MICBIAS, 0, 0),*/

Remove the commented code; you can add it later when you add capture
support.

> +static int msic_pcm_hs_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	pr_debug("pcm hs startup for %d\n", substream->pcm->device);
> +
> +	/*configure digital reciever here, add to DAPM later on*/
> +	msic_write(dai->codec, MSIC_HSMIXER, BIT(0)|BIT(4));
> +	msic_write(dai->codec, MSIC_HSEPRXCTRL, BIT(5)|BIT(4));

This does seem straightforward enough to handle using DAPM...

> +	pr_debug("pcm hs shutdown\n");
> +	msic_write(dai->codec, MSIC_HSEPRXCTRL, 0);
> +	return ;

No need for empty return statements.

> +static int msic_pcm_hs_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	msic_modify(dai->codec, MSIC_HSLVOLCTRL, (!mute << 7), BIT(7));
> +	msic_modify(dai->codec, MSIC_HSRVOLCTRL, (!mute << 7), BIT(7));
> +	return 0;

It feels more idiomatic to just not implement a mute for these
interfaces and make these regular user visible controls - these mutes
are on the output rather than the digital mutes on the DAC that would
normally be controllled by a mute() function.  Unless there's pop/click
issues, in which case it's an OK workaround.  The user control is
useful. 

> +	.capture = {
> +		.stream_name = "Capture",
> +		.channels_min = 1,
> +		.channels_max = 5,
> +		.rates = MSIC_RATES,
> +		.formats = MSIC_FORMATS,
> +	},

Remove this until you implement capture.

> +},
> +};
> +EXPORT_SYMBOL_GPL(intel_msic_dais);

No need to export this with current ASoC APIs.

> +	/*fix the initial volume at 0dB*/
> +	msic_write(codec, MSIC_HSLVOLCTRL, 0x08);
> +	msic_write(codec, MSIC_HSRVOLCTRL, 0x08);
> +	msic_write(codec, MSIC_IHFLVOLCTRL, 0x08);
> +	msic_write(codec, MSIC_IHFRVOLCTRL, 0x08);

Leave these at the hardware defaults; 0dB may not be appropriate for
other systems (it seems rather loud for a headphone output...).

> +	/*dac mode and lo w/a*/
> +	msic_write(codec, MSIC_SSR2, 0x10);
> +	msic_write(codec, MSIC_SSR3, 0x40);

"lo w/a"?

> +	/*default is lineout NC, userspace sets it explcitly*/
> +	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTL");
> +	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTR");

Let the machine driver do this.

> +	.set_bias_level	= msic_set_vaud_bias,
> +/*	.suspend =	msic_codec_suspend,
> +	.resume =	msic_codec_resume,
> +*/

Remove these until you implement them.

> +MODULE_DESCRIPTION("ASoC Intel(R) MSIC codec driver");
> +MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
> +MODULE_AUTHOR("Harsha Priya <priya.harsha@intel.com>");
> +MODULE_LICENSE("GPL v2");

MODULE_ALIAS() too.

> +extern struct snd_soc_dai_driver intel_msic_dais[4];
> +extern struct snd_soc_codec_driver intel_msic_codec;

Remove these.
