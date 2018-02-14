From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: rt5640,
 rt5651 jack-detect and BYT SST suspend/resume patches / status
 update
Date: Wed, 14 Feb 2018 15:54:16 +0100
Message-ID: <006845ca-357d-6407-2fb4-8dd1e79353be@redhat.com>
References: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
 <CAL9uMOGAMz9MT6rz2-RnwtJyKnpORGcTgJ0JNBVQzyqzaOkAjg@mail.gmail.com>
 <6d689bd8-99ae-3f48-139c-f08f6399f72f@redhat.com>
 <44a0f455-94b5-0c79-87d5-3b2dd2bee524@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6E2267B0E
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 15:54:18 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id a84so11882949wmi.5
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 06:54:18 -0800 (PST)
In-Reply-To: <44a0f455-94b5-0c79-87d5-3b2dd2bee524@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 14-02-18 15:51, Pierre-Louis Bossart wrote:
> 
>>>> Carlo or Pierre-Louis can one of you check using e.g.
>>>> the left + right speaker test in gnome-control-panel's
>>>> sound config-applet if that left only goes to the left
>>>> speaker and right only goes to the right speaker?
>>>>
>>>> My bytcr-rt5651 tablet has only one speaker, but I
>>>> here sound for both the left and right speaker tests
>>>> which suggests some right-to-left mixing is happening
>>>> which we don't want on devices with stereo speakers.
>>>> Could be there is some mixing happening outside of the
>>>> codec on this tablet, still it would be good to test
>>>> this.
>>>
>>> Just tested this and it works fine on my hardware.
>>
>> Great, thank you.
>>
>> Note I've seem the same magic mono mixing happening on a
>> CHT + rt5651 tablet I've also been testing on. It is weird
>> how the hardware seems to magically mix the left and
>> right channels to the mono speaker without explicitly
>> enabling that in the codec/mixer settings as one needs
>> to do for the rt5640 and rt5645. But hey if it works
>> it works :)
> 
> The rt5651 does not have a built-in amplifier, it provides a line out that is then fed into a discrete amplifier, the mixing could happen at that level too.

Yes I think that that is what is happening, thank you for your answer.

Regards,

Hans
