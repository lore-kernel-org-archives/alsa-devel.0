From: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Subject: Re: How to add full duplex capture and playback?
Date: Fri, 19 May 2006 12:44:58 +0200
Message-ID: <446DA1AA.1080907@atmel.com>
References: <446D9014.1070300@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <446D9014.1070300@atmel.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hans-Christian Egtvedt wrote:
> Hello
> 
> I'm strugling a bit with getting my AC97 driver to be full duplex. The
> hardware supports it, but I can't seem to enable it correctly in the driver.
> 
> Is there anything I've missed other than this?
> err = snd_pcm_new(chip->card, "Atmel AC97", 0, 1, 1, &pcm);

This is actually correct I see, I have both a substream for capture and
a substream for playback:
~ # aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: AC97 [Atmel AVR32 AC97], device 0: Atmel AC97 [Atmel AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
~ # arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: AC97 [Atmel AVR32 AC97], device 0: Atmel AC97 [Atmel AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

I assume this is a "good" output from the utils.

> AFAIK this should give me two substreams, one for capture and one for
> playback. Do I have to take some care with other calls?
> 
> When I try to playback and record simultaneously I get the following error:
> ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usable
> aplay: set_params:879: Broken configuration for this PCM: no
> configurations available

This problem is due to the following open call, and was solved by
commenting it out, which is not an option for the final driver.

Open call:
static int
snd_atmel_ac97_playback_open(snd_pcm_substream_t *substream)
{
	atmel_ac97_t *chip = snd_pcm_substream_chip(substream);
	snd_pcm_runtime_t *runtime = substream->runtime;

	chip->playback_active = 1;

	printk(KERN_INFO "atmel-ac97: entering playback open\n");

	runtime->hw = snd_atmel_ac97_playback_hw;

	/* Setup hardware to match capture settings */
#if 0
	if (chip->capture_active) {
		int err = 0;
		snd_pcm_runtime_t *capture_runtime =
			chip->capture_substream->runtime;

		hw_rates[0] = (unsigned int)capture_runtime->rate;
		hw_constraint_rates.count	= ARRAY_SIZE(hw_rates);
		hw_constraint_rates.list	= hw_rates;
		hw_constraint_rates.mask	= 0;

		hw_formats[0] = (unsigned int)capture_runtime->format;
		hw_constraint_formats.count	= ARRAY_SIZE(hw_formats);
		hw_constraint_formats.list	= hw_formats;
		hw_constraint_formats.mask	= 0;

		printk(KERN_INFO "atmel_ac97: capture active, set limits to playback\n");

		err = snd_pcm_hw_constraint_list(substream->runtime, 0,
				SNDRV_PCM_HW_PARAM_RATE,
				&hw_constraint_rates);

		err = snd_pcm_hw_constraint_list(substream->runtime, 0,
				SNDRV_PCM_HW_PARAM_FORMAT,
				&hw_constraint_formats);

		printk(KERN_INFO "atmel-ac97: limiting playback rate to %d\n",
capture_runtime->rate);

		if (err < 0)
			return err;
	}
#endif

	chip->playback_substream = substream;
	chip->period = 0;
	return 0;
}

Seems like this open call (without #if 0) clear the configuration for
the PCM, basicly leaving it unusable.

Any comments?

-- 
With kind regards,
Med vennlig hilsen,

Hans-Christian Egtvedt
Applications Engineer - AVR Applications Lab
Atmel Norway


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
