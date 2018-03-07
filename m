From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 03/22] ASoC: rt5651: Configure
 jack-detect source through a device-property
Date: Wed, 7 Mar 2018 14:49:05 +0100
Message-ID: <42832c38-2c57-5083-e1fc-0911a8d88384@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
 <20180304143610.21125-4-hdegoede@redhat.com>
 <20180307123425.GC7290@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id E275126705A
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 14:49:07 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id s206so22821084wme.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2018 05:49:07 -0800 (PST)
In-Reply-To: <20180307123425.GC7290@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 07-03-18 13:34, Mark Brown wrote:
> On Sun, Mar 04, 2018 at 03:35:51PM +0100, Hans de Goede wrote:
> 
>> +/*
>> + * Note these MUST match the values from the DT binding:
>> + * Documentation/devicetree/bindings/sound/rt5651.txt
>> + */
>>   enum rt5651_jd_src {
>>   	RT5651_JD_NULL,
>>   	RT5651_JD1_1,
> 
> It's normal to put values like this in a header in include/dt-bindings
> so it's easy to get things right in actual DT bindings (and possibly
> ACPI tables as well if the machinery for that does the right thing) -
> can you send a followup doing that please?

Good point, yes I will send a follow-up patch.

>> -static const struct dmi_system_id rt5651_quirk_table[] = {
>> -	{
>> -		.callback = rt5651_quirk_cb,
>> -		.matches = {
>> -			DMI_MATCH(DMI_SYS_VENDOR, "KIANO"),
>> -			DMI_MATCH(DMI_PRODUCT_NAME, "KIANO SlimNote 14.2"),
>> -		},
>> -		.driver_data = (unsigned long *) RT5651_JD1_1,
>> -	},
>> -	{}
>> -};
>> -
> 
> I'm still not thrilled about this bit but oh well :(

Hmm, I'm planning on doing something very similar for the rt5640 code.

That is I'm working on jack-detect for the rt5640 too, and that will
need some platform data like which pin to use and OVCD settings,
I plan to once again use device-properties for this to have a
platform agnostic solution at the codec driver level.

And then in the Intel machine driver attach the device properties
based on dmi quirks (like bytcr_rt5651 the machine driver already
has DMI based quirks for a bunch of boards, which I will re-use).

Although I agree that ideally we would be able to get all this
directly from the firmware, to me fixing the x86 specific problem
of that info missing using quirks in the Intel machine driver seems
like the right place to fix this, so that we are not "poluting"
generic code with these Intel specific workarounds.

I know that second best would be some generic mechanism in the
kernel to attach extra device-properties based on the board we're
booting on, but alas currently that does not exist. One advantage
of using device-properties for this as this series is doing, is
that if such a mechanism gets added moving the info over should
be easy.

TL;DR: I know this is not the prettiest thing ever, but as you
said: "oh well".

So as said I plan to do something very similar for the rt5640 code,
if you've any objections against that I would like to hear those
objections sooner rather then later to avoid throwing away work.

Regards,

Hans
