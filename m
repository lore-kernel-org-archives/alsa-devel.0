From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: PulseAudio and softvol
Date: Thu, 16 May 2013 08:31:33 +0200
Message-ID: <51947D45.1040003@canonical.com>
References: <1368611744.6590.8.camel@localhost> <519362EB.7050603@perex.cz>
 <s5hd2ssmsd2.wl%tiwai@suse.de> <5193692A.4060007@perex.cz>
 <51936B74.6080105@canonical.com> <51936FDB.2050407@perex.cz>
 <s5h1u98mn2y.wl%tiwai@suse.de> <519383D3.3000303@canonical.com>
 <51938525.4090208@perex.cz> <s5hr4h8l7fx.wl%tiwai@suse.de>
 <519389B1.6080400@perex.cz> <s5hli7gl6hf.wl%tiwai@suse.de>
 <5193A1C9.9010108@perex.cz> <s5ha9nwl1ut.wl%tiwai@suse.de>
 <5193A8D4.4090008@perex.cz> <s5h4ne4ky13.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 092352617B4
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 08:31:36 +0200 (CEST)
In-Reply-To: <s5h4ne4ky13.wl%tiwai@suse.de>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>, pulseaudio-discuss@lists.freedesktop.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/15/2013 06:28 PM, Takashi Iwai wrote:
> At Wed, 15 May 2013 17:25:08 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 15.5.2013 17:06, Takashi Iwai wrote:
>>> Enough for...?  It restores the value without the new TLV, thus it
>>> doesn't show it's a softvol element.
>>
>> Yes, for the first call, but then PA will open the pcm device and this
>> call will add the softvol information to TLV which inactivates the
>> softvol control in the mixer.
>
> Yes, but the invocation of PCM softvol isn't guaranteed to be first
> before the reference to the already existing user ctl element.
> snd_mixer_open() can be called before that.

So this is a transient problem, right? As soon as the first PCM is 
opened, the TLV would be corrected, and then stay corrected for all 
times to come.

And looking at the current PulseAudio code, it does open the pcm device 
before it opens the mixer/ctl device.
So, if this isn't possible to solve in a better way, maybe we need to be 
pragmatic about it - PulseAudio is the only application we know that 
would care, and it opens the pcm device first. So in practice, it looks 
like the TLV approach would work.


>>>>> You may think of adding the code to softvol plugin to automatically
>>>>> rewrite TLV of the existing ctl element if it contains no new TLV
>>>>> type.  But, PA shall skip softvol.  Thus, it won't be touched.  And
>>>>> yet, PA would like to skip the control elements that have been created
>>>>> beforehand.
>>>>
>>>> The alsa-lib code can be modified to create or modify the user space
>>>> control also in the SND_PCM_NO_SOFTVOL case, so the mixer API will be
>>>> informed that the PCM controls belongs to softvol.
>>>
>>> But how would you know exactly?  Parsing the PCM definition at each
>>> time if a user ctl element is found and check whether it *might*
>>> belong to softvol plugin defined in some of card's default config?
>>
>> No. The information in TLV would be enough to determine the softvol
>> functionality.
>>
>>> What if a user takes own definition temporarily?
>>
>> Then user is responsible to remove this control later.
>
> That's messy.  We provide no such tool.
>
>>> There can be endless corner cases.
>>
>> I'm not sure what you talk about. Yes, everything can be misused, but
>> we're talking about the standard usage. You can do weird things with the
>> softvol user controls anyway (remove them during runtime, because
>> they're not locked).
>
> I know I'm picky, but adding a new metadata *onto* the existing data
> structure has to be always done carefully.  Otherwise it'll hit back
> us later.

I think it's good that you are picky. Missing a use case can cause 
problems indeed. But is there another solution to this problem which is 
better?

> For example, another corner case I can think of easily is that user
> downgrades alsa-lib.  Then softvol overrides the TLV again without the
> new tag (the current softvol code assumes the single TLV and overrides
> if it doesn't fit), and it can be saved so...
>
>>> BTW, does the alsaloop device just work as is, i.e. without specifying
>>> anything in PA's configuration?
>>
>> The alsaloop can run on top of the snd-aloop, so it behaves like a
>> standard hardware, only the mixer controls can be rerouted using the
>> user controls to the real card.
>
> OK.  But, looking at the current implementation, you are allowed to
> map freely the source ctl element.  It can lead to the same problem in
> PA.
>
> The very reason we'd like to filter out the mixer control created by
> softvol is that this mixer element confuses PA as if it actually
> changes the volume (e.g. "PCM") although PA ignores the softvol.  If
> user creates PCM volume in alsaloop in a different fashion as PA
> expected, the similar problem may happen.  How can we detect this
> logically...?  In other words, how can PA adjust the mixer elements
> for alsaloop properly?

So if alsaloop is run, only once, that could cause a control to be added 
for all future, due to alsactl saving and restoring it?

If so, that looks like a problem with alsaloop. If it adds controls, it 
should also remove them.

If no, I don't think we need to worry. Alsaloop is probably mostly used 
on non-PA systems (as PA has module-loopback which does the same thing).


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
