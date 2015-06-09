From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - PCH HDA controller not
 controlled by i915 power
Date: Tue, 09 Jun 2015 08:46:35 +0200
Message-ID: <55768BCB.3060001@canonical.com>
References: <1433829918-5807-1-git-send-email-libin.yang@intel.com>
 <s5h1thlbder.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 256F7260508
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 08:46:37 +0200 (CEST)
In-Reply-To: <s5h1thlbder.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, libin.yang@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-09 08:31, Takashi Iwai wrote:
> At Tue,  9 Jun 2015 14:05:18 +0800,
> libin.yang@intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> On some Intel platforms, the HDMI codec is connected to PCH HDA
>> controller. In this case, AZX_DCAPS_I915_POWERWELL is set and
>> the i915 power well failure should not block the hda controller
>> initialization.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>
> Is this fix needed for 4.1, or it's only for 4.2?

It's a bug fix, and as such should go to all kernels, even with cc to 
stable. That said, it mainly concerns Skylake, so kernels that don't 
support Skylake would not need a backport.

> I vaguely remember of a bug report.  If there is any relevant bug
> report, please give the link, too.

I think this was raised to Intel by us. The use case is when the 
integrated GPU is disabled and a discrete GPU is used. In this case the 
i915 module fails to load. If then the HDMI and analog codec are both on 
the same controller, the entire controller fails instead of just the 
HDMI codec.

I'll see if I can get the patch tested ASAP.

>
>
> Takashi
>
>> ---
>>   sound/hda/hdac_i915.c     |  6 +++---
>>   sound/pci/hda/hda_intel.c | 11 +++++++++--
>>   2 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
>> index cb78c25..4f4036a 100644
>> --- a/sound/hda/hdac_i915.c
>> +++ b/sound/hda/hdac_i915.c
>> @@ -27,7 +27,7 @@ int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
>>   {
>>   	struct i915_audio_component *acomp = bus->audio_component;
>>
>> -	if (!acomp->ops)
>> +	if (!acomp || !acomp->ops)
>>   		return -ENODEV;
>>
>>   	if (!acomp->ops->codec_wake_override) {
>> @@ -49,7 +49,7 @@ int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
>>   {
>>   	struct i915_audio_component *acomp = bus->audio_component;
>>
>> -	if (!acomp->ops)
>> +	if (!acomp || !acomp->ops)
>>   		return -ENODEV;
>>
>>   	dev_dbg(bus->dev, "display power %s\n",
>> @@ -72,7 +72,7 @@ int snd_hdac_get_display_clk(struct hdac_bus *bus)
>>   {
>>   	struct i915_audio_component *acomp = bus->audio_component;
>>
>> -	if (!acomp->ops)
>> +	if (!acomp || !acomp->ops)
>>   		return -ENODEV;
>>
>>   	return acomp->ops->get_cdclk_freq(acomp->dev);
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 7933fb0..775e020 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1986,14 +1986,21 @@ static int azx_probe_continue(struct azx *chip)
>>   			hda->need_i915_power = 1;
>>
>>   		err = snd_hdac_i915_init(bus);
>> +		/* if controller is located in powerwell,
>> +		 * the initialization should be stopped.
>> +		 * if only codec is located in powerwell,
>> +		 * the hd audio is still ok for analog audio
>> +		 */
>>   		if (err < 0)
>> -			goto i915_power_fail;
>> +			if (hda->need_i915_power)
>> +				goto i915_power_fail;
>>
>>   		err = snd_hdac_display_power(bus, true);
>>   		if (err < 0) {
>>   			dev_err(chip->card->dev,
>>   				"Cannot turn on display power on i915\n");
>> -			goto i915_power_fail;
>> +			if (hda->need_i915_power)
>> +				goto i915_power_fail;
>>   		}
>>   	}
>>
>> --
>> 1.9.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
