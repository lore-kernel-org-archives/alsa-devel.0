From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - hdmi: Fix channel map switch
 not taking effect
Date: Thu, 24 Oct 2013 17:20:09 +0300
Message-ID: <52692C99.4010502@iki.fi>
References: <1380737612-16512-1-git-send-email-anssi.hannula@iki.fi>	<s5hzjqlseqt.wl%tiwai@suse.de>	<73e325dd7c696e2d16946890a66dc838@mail.onse.fi>	<s5h61t9s6n7.wl%tiwai@suse.de>	<884f0056bbbc27a2f35c581de11a07d9@mail.onse.fi>	<s5hsiwdqlc4.wl%tiwai@suse.de>	<s5hy55umtwv.wl%tiwai@suse.de>	<525D6BA8.3000804@iki.fi>
 <s5ha9hznd9q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id CF0312608CA
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 16:20:13 +0200 (CEST)
In-Reply-To: <s5ha9hznd9q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

24.10.2013 14:01, Takashi Iwai kirjoitti:
> At Tue, 15 Oct 2013 19:22:00 +0300,
> Anssi Hannula wrote:
>>
>> 15.10.2013 18:32, Takashi Iwai kirjoitti:
>>> At Mon, 07 Oct 2013 15:09:15 +0200,
>>> Takashi Iwai wrote:
>>>>
>>>> At Mon, 07 Oct 2013 15:45:09 +0300,
>>>> Anssi Hannula wrote:
>>>>>
>>>>> Takashi Iwai kirjoitti 2013-10-07 13:43:
>>>>>> At Mon, 07 Oct 2013 13:31:17 +0300,
>>>>>> Anssi Hannula wrote:
>>>>>>
>>>>>> Takashi Iwai kirjoitti 2013-10-07 10:48:
>>>>>>> At Wed,  2 Oct 2013 21:13:32 +0300,
>>>>>>> Anssi Hannula wrote:
>>>>>>>
>>>>>>> Currently hdmi_setup_audio_infoframe() reprograms the HDA channel
>>>>>>> mapping only when the infoframe is not up-to-date or the non-PCM flag
>>>>>>> has changed.
>>>>>>>
>>>>>>> However, when just the channel map has been changed, the infoframe may
>>>>>>> still be up-to-date and non-PCM flag may not have changed, so the new
>>>>>>> channel map is not actually programmed into the HDA codec.
>>>>>>>
>>>>>>> Notably, this failing case is also always triggered when the device is
>>>>>>> already in a prepared state and a new channel map is configured while
>>>>>>> changing only the channel positions (for example, plain
>>>>>>> "speaker-test -c2 -m FR,FL").
>>>>>>>
>>>>>>> Fix that by keeping track of the last programmed channel map and making
>>>>>>> hdmi_setup_audio_infoframe() always update the hardware mapping if the
>>>>>>> channel map has changed.
>>>>>>>
>>>>>>> Hmm, maybe it's easier (and safer) to remove the check and always call
>>>>>>> hdmi_setup_channel_mapping()?  Of course, the drawback is the
>>>>>>> unnecessary verbs, but it's not too much.
>>>>>>
>>>>>> Easier, yes. I don't really have that good of an idea how big of a 
>>>>>> delay
>>>>>> do 8 write verbs cause, so I'll rely on your judgment :)
>>>>>>
>>>>>> I guess I could replace the writes with read-and-write-if-differs 
>>>>>> cycles
>>>>>> when I add the set_slot ops for ATI/AMD, since it seems to be used for
>>>>>> other similar cases (like channel count)?
>>>>>>
>>>>>> Well, this would result in more cost, as read requires a sync.
>>>>>
>>>>> Hmm, so why does e.g. converter channel count set-up use that, then?
>>>>
>>>> It can be optimized as well :)
>>>>
>>>>>> If any, we can use the cached write/update.  But this assumes that the
>>>>>> hardware never clears the value by some operation internally.
>>>>>
>>>>> It should not, but better be safe than sorry here (at least for stable) 
>>>>> :)
>>>>>
>>>>>>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>> ---
>>>>>>>
>>>>>>> BTW, is there some mechanism preventing hdmi_chmap_ctl_put() to be
>>>>>>> called
>>>>>>> at the same time with generic_hdmi_playback_pcm_prepare() that I didn't
>>>>>>> see with a quick look?
>>>>>>> Both of them call hdmi_setup_audio_infoframe() which is not
>>>>>>> thread-safe.
>>>>>>>
>>>>>>> Yeah, we need to introduce a mutex there.
>>>>>>
>>>>>> I guess hdmi_present_sense() is the same, as it can also call
>>>>>> hdmi_setup_audio_infoframe()?
>>>>>>
>>>>>> Hm, looking at the code, we have already pin_eld->lock in
>>>>>> hdmi_present_sense().  This can be used in other places, too.
>>>>>
>>>>> Well, hdmi_setup_audio_infoframe() is non-threadsafe for other reasons 
>>>>> than
>>>>> eld as well (e.g. write verbs to hw), though, so it might be a bit 
>>>>> confusing
>>>>> as-is. Better move/rename the lock if we end up using it? Or not?
>>>>
>>>> Yeah, it'd make sense.
>>>>
>>>>>> (And pin_eld->monitor_present change at the beginning of
>>>>>> hdmi_present_sense() should be protected in the mutex, too...)
>>>>>>
>>>>>> BTW, shouldn't hdmi_present_sense() call hdmi_setup_audio_infoframe()
>>>>>> always
>>>>>> when eld_changed is true? hdmi_setup_audio_infoframe() does not do its
>>>>>> stuff if !monitor_present, so if one starts playback before plugging 
>>>>>> in,
>>>>>> the channel mappings etc will never be set even when plug-in happens
>>>>>> (from what I can see, that is -  did not test yet).
>>>>>>
>>>>>> Well, there is such a call but currently specific to Haswell because
>>>>>> it hasn't been tested for others.  Maybe we can simply get rid of
>>>>>> is_haswell() check there.
>>>>>
>>>>> OK, will test later and provide a patch if it works as expected.
>>>>
>>>> Thanks.
>>>
>>> [dropped stable from Cc]
>>>
>>> Anssi, is the lock fix/cleanup patch ready?
>>>
>>> I already have patche to extend mutex lock over other places and
>>> move it into per_pin, but if you have already similar patches, I'll
>>> take yours, hopefully together with other fixes.
>>
>> Nope, haven't had the time to work on it yet (my excuse is that I was at
>> XBMC DevCon last weekend :) ).
>>
>> So feel free to apply yours and I'll work on top of that (at some point
>> later this week I guess).
> 
> Anssi, do you have the merge-ready version of AMD HDMI fix patches?
> Since 3.13 merge window will be opened soon, I'd like to merge such
> big (and good) things now if possible.

Well, I have finished the hdmi_ops conversion, but the updated patchset
has not yet been tested on ATI/AMD. But I guess I could post the updated
patchset anyway (today), and fix any possible remaining issues afterwards...

-- 
Anssi Hannula
