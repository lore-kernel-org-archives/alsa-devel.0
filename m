From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [RFC 1/4] ASoC SST: Add msic codec driver
Date: Tue, 28 Dec 2010 21:06:28 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104CF80@bgsmsx502.gar.corp.intel.com>
References: <1293538176-31853-1-git-send-email-vinod.koul@intel.com>
	<20101228144805.GC31883@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id B68531038DC
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 16:37:36 +0100 (CET)
In-Reply-To: <20101228144805.GC31883@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 08:18:27PM +0530, Mark Brown wrote:
> On Tue, Dec 28, 2010 at 05:39:36PM +0530, Koul, Vinod wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > This patch adds the msic asoc codec driver. This driver currently supports
> only playback.
> > Capture and jack detection to be added later
> 
> 
> >  sound/soc/codecs/msic.c |  721
> +++++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/msic.h |  102 +++++++
> >  2 files changed, 823 insertions(+), 0 deletions(-)
> 
> Makefile and Kconfig too please.
We added all make and kconfig changes in patch4, if you want this to be per
driver basic, next time I will do that way

> > +static inline int msic_modify(struct snd_soc_codec *codec,
> > +		unsigned int reg, unsigned int value, unsigned int mask)
> > +{
> > +	int ret;
> > +
> > +	pr_debug("Modify for %x with %x of mask %x\n", reg, value, mask);
> > +	ret = intel_scu_ipc_update_register(reg, value, mask);
> > +	if (ret)
> > +		pr_err("modify of %x failed, err %d\n", reg, ret);
> > +	return ret;
> > +}
> 
> snd_soc_update_bits().
Along with read and write the platform provides update bits api. So internally I
call this when I want to update a bit (instead of soc_update which does and read
and then write)
On this I have a proposal if system provides a modify api can we add one more 
function and use that in update bits. Like:
snd_soc_update_bits()
{
	if (codec->modif)
		codec->modify(....)
	rest of current update logic...
}

> > +static int headset_set_switch(struct snd_kcontrol *kcontrol,
> > +	struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
> > +	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
> > +
> > +	if (ucontrol->value.integer.value[0] == msic->hs_switch)
> > +		return 0;
> > +
> > +	if (ucontrol->value.integer.value[0]) {
> > +		pr_debug("hs_set HS path\n");
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
> > +	} else {
> > +		pr_debug("hs_set EP path\n");
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
> 
> This should be implemented in the machine driver if it's useful.
> Putting this in the CODEC driver restricts the system design as it
> prevents both outputs being simultaneously active and means that the
> system can't do things like drive selection between the headset and
> earpiece outputs automatically from jack detection.
This makes sense, I will move these to machine driver

> > +static void msic_lo_enable_out_pins(struct snd_soc_codec *codec)
> > +{
> > +	struct intel_msic_pvt *msic = snd_soc_codec_get_drvdata(codec);
> > +
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTL");
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "IHFOUTR");
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTL");
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "LINEOUTR");
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "VIB1OUT");
> > +	snd_soc_dapm_enable_pin(&codec->dapm, "VIB2OUT");
> > +	if (msic->hs_switch) {
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTL");
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "HPOUTR");
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "EPOUT");
> > +	} else {
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTL");
> > +		snd_soc_dapm_disable_pin(&codec->dapm, "HPOUTR");
> > +		snd_soc_dapm_enable_pin(&codec->dapm, "EPOUT");
> > +	}
> 
> This also looks like it's in the machine driver domain.
Agreed


> > +	switch (level) {
> > +	case SND_SOC_BIAS_PREPARE:
> > +	case SND_SOC_BIAS_STANDBY:
> > +		break;
> > +
> > +	case SND_SOC_BIAS_ON:
> > +		pr_debug("vaud_bias doing rail statup now\n");
> > +		/*power up the rail*/
> > +		msic_write(codec, MSIC_VAUD, BIT(2)|BIT(1)|BIT(0));
> > +		msleep(1);
> > +		/*power up the pll*/
> > +		msic_write(codec, MSIC_AUDPLLCTRL, BIT(5));
> 
> In general _ON should be doing the absolute minimum possible - it's done
> after everything else has been brought up.  Depending on what these are
> controlling they should be either in _PREPARE (audio is about to start)
> or _STANDBY (the system is idle).
The AUDPLLCTRL enable the codec pll. It needs to be done after turning the rails
on. I think I will move these out of _ON to _PREPARE.


> > +		/*adding pcm 2 here for a while*/
> > +		msic_modify(codec, MSIC_PCM2C2, BIT(0), BIT(0));
> > +		break;
> 
> Hrm?
This is PCM enable which I initially added in codec map and caused problems,
hence the comment. Does this look apt in this place?

> > +	/*playback paths speaker, dac, filter, rx selector*/
> > +	SND_SOC_DAPM_SWITCH("Headset Left Playback",
> > +		MSIC_DRIVEREN, 0, 0, &msic_driver_controls[0]),
> 
> Don't use big arrays of enumerated controls that you reference by
> number; use individually named variables.  The numeric references are
> error prone and hard to read.
Agreed will fix this


> Most of these look like they're just plain mute controls which would
> more normally be represented as regular sound controls not related to
> power, leaving these controls as PGAs (which is what they mostly appear
> to be).  That would make the sequencing better, I expect, and would give
> stereo controls to the application layer which is more normal. 
So what you are proposing is to add these playback switches as PGAs?
These are actually the output driver enable switches which should be turned on
only when stream is active, hence added these as DAPM_SWITCH.

> > +static int msic_pcm_hs_startup(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	pr_debug("pcm hs startup for %d\n", substream->pcm->device);
> > +
> > +	/*configure digital reciever here, add to DAPM later on*/
> > +	msic_write(dai->codec, MSIC_HSMIXER, BIT(0)|BIT(4));
> > +	msic_write(dai->codec, MSIC_HSEPRXCTRL, BIT(5)|BIT(4));
> 
> This does seem straightforward enough to handle using DAPM...
Yes, I do intend to add this is DAPM.

> No need for empty return statements.
> 
> > +static int msic_pcm_hs_mute(struct snd_soc_dai *dai, int mute)
> > +{
> > +	msic_modify(dai->codec, MSIC_HSLVOLCTRL, (!mute << 7), BIT(7));
> > +	msic_modify(dai->codec, MSIC_HSRVOLCTRL, (!mute << 7), BIT(7));
> > +	return 0;
> 
> It feels more idiomatic to just not implement a mute for these
> interfaces and make these regular user visible controls - these mutes
> are on the output rather than the digital mutes on the DAC that would
> normally be controllled by a mute() function.  Unless there's pop/click
> issues, in which case it's an OK workaround.  The user control is
> useful.
The intention is avoid pops and clicks.

> > +	/*fix the initial volume at 0dB*/
> > +	msic_write(codec, MSIC_HSLVOLCTRL, 0x08);
> > +	msic_write(codec, MSIC_HSRVOLCTRL, 0x08);
> > +	msic_write(codec, MSIC_IHFLVOLCTRL, 0x08);
> > +	msic_write(codec, MSIC_IHFRVOLCTRL, 0x08);
> 
> Leave these at the hardware defaults; 0dB may not be appropriate for
> other systems (it seems rather loud for a headphone output...).
The h/w default is +9dB hence setting it to 0.

> 
> > +	/*dac mode and lo w/a*/
> > +	msic_write(codec, MSIC_SSR2, 0x10);
> > +	msic_write(codec, MSIC_SSR3, 0x40);
> 
> "lo w/a"?
Lineout w/a, unless we program these they don't work as intended :(
> 
> > +	/*default is lineout NC, userspace sets it explcitly*/
> > +	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTL");
> > +	snd_soc_dapm_disable_pin(&codec->dapm, "LINEOUTR");
> 
> Let the machine driver do this.
Yup

~Vinod
