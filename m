From: Sangilikumar  <sangilikumar.muniyandi@marudham.co.in>
Subject: Re: wm8974 and sam9g45 atmel
Date: Fri, 11 Jul 2014 06:01:41 +0000 (UTC)
Message-ID: <loom.20140711T075321-187@post.gmane.org>
References: <4DF0E2B4.7040401@ecsproject.com>
 <20110610103118.GA26441@sirena.org.uk> <4DFB1CEA.2060308@ecsproject.com>
 <4DFB6CA5.9010202@ecsproject.com>
 <20110624120943.GG9483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id BF90C264F3D
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 08:01:53 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1X5Tu4-0000wT-Cr
 for alsa-devel@alsa-project.org; Fri, 11 Jul 2014 08:01:52 +0200
Received: from 115.114.95.155.static-Chennai.vsnl.net.in
 ([115.114.95.155.static-Chennai.vsnl.net.in])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 08:01:52 +0200
Received: from sangilikumar.muniyandi by
 115.114.95.155.static-Chennai.vsnl.net.in with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 08:01:52 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie <at> opensource.wolfsonmicro.com> writes:

> 
> On Fri, Jun 17, 2011 at 05:03:01PM +0200, Michele Da Rold wrote:
> 
> > it's better to use wm8974 like master? because I have see that the
> > atmel ssc is not so good generating clocks....
> 
> Probably in your system, yes.  The most important thing from an audio
> performance point of view is that the clocks are all derived from the
> same clock source - if this is like other Atmel systems then you need to
> make the CODEC clock master on the audio bus as the MCLK output from the
> CPU is not synchronous with the audio clocks.
> 

Me too working with WM8974 codec and integrating with AM1808 processor but i 
while i'm playing i can't hear the sound from speaker.

Configured the WM8974 as slave and connected the MCLK with 24.5MHz crystal.
I can probe the signal at WCLK,BCLK and MCLK while playing audio but can't 
hear the sound from speaker.

My modified machine driver is 


#define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | 
SND_SOC_DAIFMT_CBS_CFS )

static int evm_hw_params(struct snd_pcm_substream *substream,
			 struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *codec_dai = rtd->codec_dai;
	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
	int ret = 0;
	unsigned sysclk;

	/* ASP1 on DM355 EVM is clocked by an external oscillator */
	if (machine_is_davinci_dm355_evm() || 
machine_is_davinci_dm6467_evm() ||
	    machine_is_davinci_dm365_evm())
		sysclk = 27000000;

	/* ASP0 in DM6446 EVM is clocked by U55, as configured by
	 * board-dm644x-evm.c using GPIOs from U18.  There are six
	 * options; here we "know" we use a 48 KHz sample rate.
	 */
	if (machine_is_omapl138_lcdkboard())
	    sysclk = 24576000;
	else
		return -EINVAL;

	/* set codec DAI configuration */
	ret = snd_soc_dai_set_fmt(codec_dai, AUDIO_FORMAT);
	if (ret < 0)
		return ret;

	/* set cpu DAI configuration */
	ret = snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
	if (ret < 0)
		return ret;

	
	ret = snd_soc_dai_set_pll(codec_dai, 0, 1, 24576000,0);
	if (ret) {
		printk( ">>>couldn't set pll: %d\n", ret);
		return ret;
	}
	
	return 0;
}

static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
				struct snd_pcm_hw_params *params)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;

	/* set cpu DAI configuration */
	return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
}

/*
 * Since da850_sdi_shutdown() and da850_sdi_trigger() are invoked in 
interrupt 
 * context, they can't directly invoke da850_sdi_mute(), since 
da850_sdi_mute()
 * involves i2c communications (which is slow and can wait).  So, use the 
workqueue
 * mechanism to 'finish' processing.
 */
#ifdef CONFIG_MACH_DAVINCI_DA850_SDI
extern int da850_sdi_mute(int state);
static void muteTheOutputs( struct work_struct * work )
{
	da850_sdi_mute( 1 );
}
DECLARE_WORK( muteWorkElement, muteTheOutputs );

static void unmuteTheOutputs( struct work_struct * work )
{
	da850_sdi_mute( 0 );
}
DECLARE_WORK( unmuteWorkElement, unmuteTheOutputs );
 

static int da850_sdi_trigger(struct snd_pcm_substream *stream, int cmd)
{
    switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
	case SNDRV_PCM_TRIGGER_RESUME:
	    schedule_work( &unmuteWorkElement );
	    break;

	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
	case SNDRV_PCM_TRIGGER_SUSPEND:
	    schedule_work( &muteWorkElement );
	    break;
    }

    return 0;
}

static struct snd_soc_ops da850_sdi_ops = {
	.hw_params = evm_hw_params,
	.trigger = da850_sdi_trigger
};
#endif
static struct snd_soc_ops evm_ops = {
	.hw_params = evm_hw_params,
};

static struct snd_soc_ops evm_spdif_ops = {
	.hw_params = evm_spdif_hw_params,
};

static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
	SND_SOC_DAPM_MIC("Mic Jack", NULL),
	SND_SOC_DAPM_SPK("Ext Spk", NULL),
};
/* davinci-evm machine audio_mapnections to the codec pins */

static const struct snd_soc_dapm_route audio_map[] = {
	 
	/* Speaker output mixer */
 	{"Speaker Mixer", "PCM Playback Switch", "DAC"},
 	{"Speaker Mixer", "Aux Playback Switch", "Aux Input"},
 	{"Speaker Mixer", "Line Bypass Switch", "Boost Mixer"}, 
	/* speaker connected to SPKOUTP */ 
	{"SpkN Out", NULL, "Speaker Mixer"}, 
	{"SpkP Out", NULL, "Speaker Mixer"}, 
	{"SPKOUTN", NULL, "SpkN Out"}, 
	{"SPKOUTP", NULL, "SpkP Out"},  
	/* Input PGA */ 
	{"Input PGA", "Aux Switch", "Aux Input"}, 
	{"Input PGA", "MicN Switch", "MICN"}, 
	{"Input PGA", "MicP Switch", "MICP"}, 
};
/* Logic for a aic3x as connected on a davinci-evm */
static int evm_aic3x_init(struct snd_soc_pcm_runtime *rtd)
{
	struct snd_soc_codec *codec = rtd->codec;
	struct snd_soc_dapm_context *dapm = &codec->dapm;

	/* Add davinci-evm specific widgets */
	snd_soc_dapm_new_controls(dapm, aic3x_dapm_widgets,
				  ARRAY_SIZE(aic3x_dapm_widgets));

	/* Set up davinci-evm specific audio path audio_map */
	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
	snd_soc_dapm_enable_pin(dapm, "Ext Spk");

	return 0;
}

static struct snd_soc_card da850_snd_soc_card = {
	.name = "DA850/OMAP-L138 EVM",
	.owner = THIS_MODULE,
	.dai_link = &da850_evm_dai,
	.num_links = 1,
};

static struct platform_device *evm_snd_device;

static int __init evm_init(void)
{
	struct snd_soc_card *evm_snd_dev_data;
	int index;
	int ret;

	 if (machine_is_omapl138_lcdkboard()) {
		printk("LCDK HAWK board");
		evm_snd_dev_data = &da850_snd_soc_card;
		index = 0;
	} else
		return -EINVAL;

	evm_snd_device = platform_device_alloc("soc-audio", index);
	if (!evm_snd_device)
		return -ENOMEM;

	platform_set_drvdata(evm_snd_device, evm_snd_dev_data);
	ret = platform_device_add(evm_snd_device);
	if (ret)
		platform_device_put(evm_snd_device);

	return ret;
}

static void __exit evm_exit(void)
{
	platform_device_unregister(evm_snd_device);
}

module_init(evm_init);
module_exit(evm_exit);
root@omapl138-lcdk:~# amixer cset numid=61 1
numid=61,iface=MIXER,name='Speaker Mixer PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
root@omapl138-lcdk:~# amixer cset numid=46,iface=MIXER,name='Speaker 
Playback Vo
lume' 63
numid=46,iface=MIXER,name='Speaker Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=63,step=0
  : values=63
  | dBscale-min=-57.00dB,step=1.00dB,mute=0

Please help me to solve this problem. 
