From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: wm8731 - redundant register initialization,
	stream name vs	DAPM widgets, snd_soc_io to regmap_io conversion
Date: Mon, 8 Jun 2015 10:51:11 +0100
Message-ID: <20150608095111.GE32730@opensource.wolfsonmicro.com>
References: <20150605122748.b7534fc4900573ed497928ce@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FCB72604E1
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:51:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150605122748.b7534fc4900573ed497928ce@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2015 at 12:27:48PM -0700, Sergey Kiselev wrote:
> Hi,
> 
> I have a few questions regarding wm8731. Some might be applicable to other
> codecs as well.
> 
> 1. According to the datasheet bit #8 of all the registers below is set to
> '0' by the hardware reset. Is there a good reason to set them anyway?
> (Perhaps an errata in previous chip version?)
> 	/* Latch the update bits */
> 	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
> 	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
> 	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
> 	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);

Hmm... this does actually look like it is probably redundant, it
looks like initially these set the simultaneous load bits (commit
40e0aa64660b [ALSA] ASoC codecs: WM8731 support), but this caused
problems with the Stereo controls so it was changed in (commit
389619f1063e [ALSA] soc/wm8731: Fix stereo mixer controls). I
think it was just overlooked in that second commit that these are
the defaults and I would expect that those lines could now be
removed with no ill effects.

> 
> 2. In wm8731's snd_soc_dai_driver structure the steam names are 'Playback'
> and 'Capture', while DAPM widgets have 'HiFi' prepended to the names:
> SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8731_PWR, 3, 1),
> SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8731_PWR, 2, 1),
> Should the name match? DAPM.txt says so, but the DAPM code actually looks
> for a substring match (DAI name as a substring in widget name).

The documentation is fairly out of date here I think and even so
it decidely implies a substring match looking at the examples it
gives. I might defer to Mark or Lars for the definitive answer on
this one.

> 
> 3. Do I understand correctly the direction is to move from snd_soc_${io}
> to more generic regmap_${io}? If so, I'll submit a patch.

Don't think I really have a strong opinion on this. I do tend to
prefer to use the regmap calls, but I doubt the snd_soc helpers
are going away anytime soon.

Thanks,
Charles
