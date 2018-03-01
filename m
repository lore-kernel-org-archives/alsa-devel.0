From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 06/32] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Thu, 1 Mar 2018 23:35:30 +0100
Message-ID: <032d0e59-0d64-7df1-4fca-1709430b754c@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
 <20180225104713.4745-7-hdegoede@redhat.com>
 <20180301193046.GJ12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id F1491267C7E
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 23:35:31 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id h21so15047715wmd.1
 for <alsa-devel@alsa-project.org>; Thu, 01 Mar 2018 14:35:31 -0800 (PST)
In-Reply-To: <20180301193046.GJ12864@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 01-03-18 20:30, Mark Brown wrote:
> On Sun, Feb 25, 2018 at 11:46:47AM +0100, Hans de Goede wrote:
>> Configure the jack-detect source through a device-property which can be
>> set by code outside of the codec driver. Rather then putting platform
>> specific DMI quirks inside the generic codec driver.
> 
>> And move the jack-detect-source quirk for the KIANO SlimNote 14.2, which
>> was present inside the codec driver to the machine driver, where we can
>> bundle it together with the other quirks already present for this laptop.
> 
> Multiple things in a patch again :/

Yes because the property replaces the quirk, I can split the changes between
the codec and machine driver into 2 patches but then the intermediate state
will be that the jack-detection no longer works.

> The property itself is fine but...
> 
>> @@ -360,6 +377,13 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
>>   			dev_err(card->dev, "unable to set MCLK rate\n");
>>   	}
>>   
>> +	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
>> +				BYT_RT5651_JDSRC(byt_rt5651_quirk));
>> +
>> +	ret = device_add_properties(codec->dev, props);
>> +	if (ret)
>> +		return ret;
>> +
>>   	ret = snd_soc_card_jack_new(runtime->card, "Headset",
> 
> I'm having a hard time geting comfortable with this; it's all a bit
> fragile feeling to me - someone deciding to centralise the property
> parsing (eg, if they are using a platform where platform data makes
> sense or want to cross-validate with some other property on probe) could
> easily break things and there's not even a comment in the CODEC driver.

It is not _that_ fragile, but I agree that it would be good to add
a comment about not moving the property-parsing to the codec driver.

I will rebase and submit a new version with a comment added.
Do you want me to split this patch into separate codec and machine
driver patches while at it?

> It'll work but it doesn't seem to match expectations for how firmware
> data is provided which is what's bugging me here.

The problem here is that the data is not coming from the firmware,
which is a reality we have to deal with leading to some sort of
compromise.

> It at least needs a
> "here be dragons" style comment in the code.

Ack.

> Ideally we'd have a general way to massage the ACPI data at init time
> and could have board files that are instantiated from DMI to do that
> (like are needed even more for SFI) but that's a long way off.

Something like DT overlays for ACPI? With the overlays being triggered
by a DMI match? Interesting concept, but given how much discussion there
still is surrounding DT overlays I don't see this happening anytime soon.

Regards,

Hans
