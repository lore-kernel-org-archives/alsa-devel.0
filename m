From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ASoC: rt5640,
 rt5651 jack-detect and BYT SST suspend/resume patches / status
 update
Date: Wed, 14 Feb 2018 11:08:01 +0100
Message-ID: <6d689bd8-99ae-3f48-139c-f08f6399f72f@redhat.com>
References: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
 <CAL9uMOGAMz9MT6rz2-RnwtJyKnpORGcTgJ0JNBVQzyqzaOkAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FD7D2677B9
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 11:08:03 +0100 (CET)
Received: by mail-wm0-f50.google.com with SMTP id x4so17027930wmc.0
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 02:08:03 -0800 (PST)
In-Reply-To: <CAL9uMOGAMz9MT6rz2-RnwtJyKnpORGcTgJ0JNBVQzyqzaOkAjg@mail.gmail.com>
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
To: Carlo Caione <carlo@endlessm.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 14-02-18 10:59, Carlo Caione wrote:
> On Sun, Feb 11, 2018 at 12:00 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi Pierre-Louis, Carlo, et al,
> 
> Hey Hans,
> 
>> This mail is mostly just FYI, I've been doing a lot of work
>> on $subject lately and the purpose of this mail is to avoid
>> people doing double work.
> 
> really nice. Thank you for this.
> 
> /cut
> 
>> Note the rt5651 jack change to fix headset vs headphone
>> detection does not work yet, now it sees everything as
>> headphones ...
> 
> I tried your latest kernel and it works fine detecting my headset.

Yes I've fixed that since writing the mail :)

> AFAICT the problem (that I have also with the current driver shipped
> in the latest mainline kernel) is that the headset/mic detection _does
> not always work fine_. Sometimes the headset is only recognized as
> headphones but if you keep trying (usually detaching and attaching
> again the jack) then the driver is able to recognize it as headset
> (usually after a few tries).

Ack, I've seen the same on the rt5640 I've a better algorithm
for headset vs headphone detection in the patch adding jack-detect
to the rt5640 driver. I plan to port (copy and paste mostly) that to
the rt5651 driver soonish, once that is done and I've run some final
tests I plan to submit the whole bunch of patches (minus the rt5640
support which actually started all this) upstream, I will try to
remember to put you in the Cc.

>> I probably won't have much time to continue work on this
>> today and as said the main purpose of this mail is to get
>> you aware of these patches to avoid double work. I hope to
>> be able to rebase on top of 4.16-rc1, and do an upstream
>> submission of everything except for the rt5640 jack-detect
>> code sometime the next week.
>>
>> Regards,
>>
>> Hans
>>
>> p.s.
>>
>> Carlo or Pierre-Louis can one of you check using e.g.
>> the left + right speaker test in gnome-control-panel's
>> sound config-applet if that left only goes to the left
>> speaker and right only goes to the right speaker?
>>
>> My bytcr-rt5651 tablet has only one speaker, but I
>> here sound for both the left and right speaker tests
>> which suggests some right-to-left mixing is happening
>> which we don't want on devices with stereo speakers.
>> Could be there is some mixing happening outside of the
>> codec on this tablet, still it would be good to test
>> this.
> 
> Just tested this and it works fine on my hardware.

Great, thank you.

Note I've seem the same magic mono mixing happening on a
CHT + rt5651 tablet I've also been testing on. It is weird
how the hardware seems to magically mix the left and
right channels to the mono speaker without explicitly
enabling that in the codec/mixer settings as one needs
to do for the rt5640 and rt5645. But hey if it works
it works :)

Regards,

Hans
