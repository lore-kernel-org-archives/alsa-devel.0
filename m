From: Alexander Kappner <agk@godking.net>
Subject: Re: [snd_hda_intel] snd_hda_intel causes high CPU
 lockup and system instability if mic disabled in BIOS on Lenovo P50
Date: Sun, 6 Jan 2019 18:18:27 -0800 (PST)
Message-ID: <alpine.DEB.2.11.1901061816210.19003@REDDOT>
References: <alpine.DEB.2.11.1811251505140.20766@REDDOT>
 <s5hpnus6yb5.wl-tiwai@suse.de> <alpine.DEB.2.11.1811262126040.2578@REDDOT>
 <s5h8t1ey7tn.wl-tiwai@suse.de> <alpine.DEB.2.11.1812011117340.26587@REDDOT>
 <s5htvjst6b3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from godking.net (s18231873.onlinehome-server.info [217.160.179.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B8B267A86
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 03:18:36 +0100 (CET)
In-Reply-To: <s5htvjst6b3.wl-tiwai@suse.de>
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
Cc: Alexander Kappner <agk@godking.net>, alsa-devel@alsa-project.org, hdegoede@redhat.com, guneshwor.o.singh@intel.com, linux-kernel@vger.kernel.org, Jim.Qu@amd.com, lukas@wunner.de, bhelgaas@google.com
List-Id: alsa-devel@alsa-project.org



On Wed, 5 Dec 2018, Takashi Iwai wrote:

> On Sat, 01 Dec 2018 20:33:16 +0100,
> Alexander Kappner wrote:
>>
>> On Tue, 27 Nov 2018, Takashi Iwai wrote:
>>
>>> On Tue, 27 Nov 2018 06:34:02 +0100,
>>> Alexander Kappner wrote:
>>>>
>>>>
>>>>
>>>>
>>>> On Mon, 26 Nov 2018, Takashi Iwai wrote:
>>>>
>>>>> On Mon, 26 Nov 2018 00:17:15 +0100,
>>>>> Alexander Kappner wrote:
>>>>>>
>>>>>> My Lenovo P50 laptop has a BIOS option to disable the microphone. When
>>>>>> this option gets chosen, the snd_hda_intel driver causes high CPU load
>>>>>> on a single kworker thread, spinning on "process_unsol_events", and
>>>>>> system
>>>>>> instability. This behavior occurs from the time that the snd_hda_intel
>>>>>> module is loaded, irrespective of whether anything is attempting to access
>>>>>> the mic. The sound output still works.
>>>>>>
>>>>>> When in this state, the module cannot be removed cleanly; attempting to
>>>>>> remove it (even without rmmod -f) triggers an oops.
>>>>>>
>>>>>> I have attached two exemplary dmesg outputs. Strangely enough, the exact
>>>>>> location of the oops varies, but further up the call chain, I always see
>>>>>> process_unsol_events.
>>>>>>
>>>>>> When the mic is not disabled in the BIOS, the module works stable,
>>>>>> regardless whether or not the mic is muted in ALSA.
>>>>>>
>>>>>> I wasn't able to pinpoint the root cause. Any pointers on where to
>>>>>> start? Much appreciated.
>>>>>
>>>>> Could you load snd-hda-intel driver with probe_only=1 option, and give
>>>>> alsa-info.sh output (run it with --no-upload option)?  This should
>>>>> leave only the codec probing without configuring, so we can see the
>>>>> codec widget contents and check the emulator.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>> Hi Takashi,
>>>>
>>>> thank you for looking into this. Please see quoted below the output of
>>>> alsa-info.sh (after "modprobe snd_hda_intel probe_only=1").
>>>
>>> This is the state where BIOS disabled the mic, right?
>>> It seems that BIOS doesn't change the pin configuration.  The pin NID
>>> 0x18 and 0x19 still show up as the mic jack and dock mic jack, as well
>>> as the built-in mic on NID 0x12.  And I couldn't see anything wrong in
>>> the emulator with this input.
>>>
>>> When BIOS disables the mic, how is supposed?  Does it disable all
>>> mics, including built-in one?
>>>
>>> Could you check alsa-info.sh outputs on both BIOS mic disable and
>>> enabled (but keep probe_only=1 option in both cases)?
>>>
>>> Also alsa-info.sh outputs on both cases without probe_only=1 would be
>>> helpful, too.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> Hi Takashi,
>>
>> as requestd, please see attached four files, reflecting each
>> combination of probe_only and mic enabled/disabled. To answer your
>> question -- yes, the initial file I had sent reflected the mic
>> disabled state.
>>
>> The BIOS option definitely disables the internal microphone. I could
>> not test whether it would also disable other microphones
>> (e.g. externally connected) since I do not have an external mic, but I
>> will find out.
>
> Hrm, that's strange.  The mic_enabled_default.txt shows "Mic Jack"
> false while the mic_disabled_default.txt shows "Mic Jack" true.
> It sounds like other way round.  Could you confirm this behavior?
>
> In anyway, there seems no difference in the pin configs or such
> between BIOS mic enable/disable.  So this shouldn't be the cause.
>
> And I noticed that you're testing 4.19-rc4.  Could you test with 4.19
> final or 4.19.y stable, at least?
>
>
> thanks,
>
> Takashi
>
Hi Takashi,

I have been trying to reproduce 
this issue with the more recent 4.20-rc6 kernel, and it has not 
reoccurred. As such, I tentatively consider this issue resolved. Thank you 
for your help.

Best regards
Alexander
