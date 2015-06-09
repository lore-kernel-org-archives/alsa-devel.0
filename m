From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: wm8731 - redundant register initialization,
 stream name vs DAPM widgets, snd_soc_io to regmap_io conversion
Date: Tue, 09 Jun 2015 20:24:59 +0200
Message-ID: <55772F7B.8020709@metafoo.de>
References: <20150605122748.b7534fc4900573ed497928ce@intel.com>
 <20150608095111.GE32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-214.synserver.de (smtp-out-214.synserver.de
 [212.40.185.214])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA8D26147A
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 20:25:01 +0200 (CEST)
In-Reply-To: <20150608095111.GE32730@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 06/08/2015 11:51 AM, Charles Keepax wrote:
> On Fri, Jun 05, 2015 at 12:27:48PM -0700, Sergey Kiselev wrote:
>> Hi,
>>
>> I have a few questions regarding wm8731. Some might be applicable to other
>> codecs as well.
>>
>> 1. According to the datasheet bit #8 of all the registers below is set to
>> '0' by the hardware reset. Is there a good reason to set them anyway?
>> (Perhaps an errata in previous chip version?)
>> 	/* Latch the update bits */
>> 	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
>> 	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
>> 	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
>> 	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
>
> Hmm... this does actually look like it is probably redundant, it
> looks like initially these set the simultaneous load bits (commit
> 40e0aa64660b [ALSA] ASoC codecs: WM8731 support), but this caused
> problems with the Stereo controls so it was changed in (commit
> 389619f1063e [ALSA] soc/wm8731: Fix stereo mixer controls). I
> think it was just overlooked in that second commit that these are
> the defaults and I would expect that those lines could now be
> removed with no ill effects.
>
>>
>> 2. In wm8731's snd_soc_dai_driver structure the steam names are 'Playback'
>> and 'Capture', while DAPM widgets have 'HiFi' prepended to the names:
>> SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8731_PWR, 3, 1),
>> SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8731_PWR, 2, 1),
>> Should the name match? DAPM.txt says so, but the DAPM code actually looks
>> for a substring match (DAI name as a substring in widget name).
>
> The documentation is fairly out of date here I think and even so
> it decidely implies a substring match looking at the examples it
> gives. I might defer to Mark or Lars for the definitive answer on
> this one.

It looks as if the code itself always used substring matching.

These days the preferred method for connecting the stream is to directly 
connect the widget that is created for the stream by the core directly in 
the DAPM route table to the DAC/ADC widget rather than setting the stream name.

>
>>
>> 3. Do I understand correctly the direction is to move from snd_soc_${io}
>> to more generic regmap_${io}? If so, I'll submit a patch.
>
> Don't think I really have a strong opinion on this. I do tend to
> prefer to use the regmap calls, but I doubt the snd_soc helpers
> are going away anytime soon.

They wont be going to go away, but hopefully soon they'll be direct static 
inline wrappers around the regmap function. But as long as the driver is 
consistent it doesn't really matter which functions are used.

- Lars
