From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC: rt5640,
 rt5651 jack-detect and BYT SST suspend/resume patches / status
 update
Date: Wed, 14 Feb 2018 08:51:23 -0600
Message-ID: <44a0f455-94b5-0c79-87d5-3b2dd2bee524@linux.intel.com>
References: <98d557fa-0c5d-0955-0987-0b5dc6764282@redhat.com>
 <CAL9uMOGAMz9MT6rz2-RnwtJyKnpORGcTgJ0JNBVQzyqzaOkAjg@mail.gmail.com>
 <6d689bd8-99ae-3f48-139c-f08f6399f72f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id F2544266EDF
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 15:51:23 +0100 (CET)
In-Reply-To: <6d689bd8-99ae-3f48-139c-f08f6399f72f@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Carlo Caione <carlo@endlessm.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


>>> Carlo or Pierre-Louis can one of you check using e.g.
>>> the left + right speaker test in gnome-control-panel's
>>> sound config-applet if that left only goes to the left
>>> speaker and right only goes to the right speaker?
>>>
>>> My bytcr-rt5651 tablet has only one speaker, but I
>>> here sound for both the left and right speaker tests
>>> which suggests some right-to-left mixing is happening
>>> which we don't want on devices with stereo speakers.
>>> Could be there is some mixing happening outside of the
>>> codec on this tablet, still it would be good to test
>>> this.
>>
>> Just tested this and it works fine on my hardware.
> 
> Great, thank you.
> 
> Note I've seem the same magic mono mixing happening on a
> CHT + rt5651 tablet I've also been testing on. It is weird
> how the hardware seems to magically mix the left and
> right channels to the mono speaker without explicitly
> enabling that in the codec/mixer settings as one needs
> to do for the rt5640 and rt5645. But hey if it works
> it works :)

The rt5651 does not have a built-in amplifier, it provides a line out 
that is then fed into a discrete amplifier, the mixing could happen at 
that level too.
We use the rt5651 for validation with a line-out -> line-in loopback and 
there is no issue with implicit mixing with the UCM files I pushed on my 
github (evolved from Carlo's rework).
