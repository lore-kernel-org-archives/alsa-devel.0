From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RESEND][PATCH v4 1/3] ALSA: core: let low-level
 driver or userspace disable rewinds
Date: Thu, 29 Mar 2018 14:16:58 -0500
Message-ID: <6d209396-bfad-b210-cb83-73b4be4aa360@linux.intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
 <1521561668-28613-2-git-send-email-sriramx.periyasamy@intel.com>
 <s5ho9jiu3fk.wl-tiwai@suse.de> <20180325104643.GA13721@intel.com>
 <s5h1sg88aml.wl-tiwai@suse.de>
 <c5967958-7bb0-3351-f818-549675645a1d@linux.intel.com>
 <s5h1sg4mdlf.wl-tiwai@suse.de>
 <53f5df7e-0162-9a4a-ea2d-a8beb4c14b89@linux.intel.com>
 <s5hk1tw82vt.wl-tiwai@suse.de>
 <bdd9eb75-b145-963b-3c8d-d7577bf81efd@linux.intel.com>
 <s5hd0zn9abs.wl-tiwai@suse.de>
 <1714954c-0703-d397-ae08-24f3359f6af4@linux.intel.com>
 <s5h8taakhwg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E521267194
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 21:17:02 +0200 (CEST)
In-Reply-To: <s5h8taakhwg.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org



On 03/29/2018 10:42 AM, Takashi Iwai wrote:
> On Wed, 28 Mar 2018 23:51:46 +0200,
> Pierre-Louis Bossart wrote:
>>>> Chrome can be benefit immediately since rewinds are never used.
>>>> Jack can benefit immediately since rewinds are never used
>>>> Android HALs can benefit immediately since rewinds are never used.
>>> ... if you patch all these.  That's not immediate.
>> It's a single flag to add to the hw_params. It'll take time to ripple
>> to distros but it's not really complex.
> Yes, but you have to modify *each* of them.  That's flaky.
> Sure, it's safer for not enabling it as default, but is it your goal?
>
>>> OTOH, if you do introduce a single switch, it's immediately
>>> effective, even with the old user-space without compilation.
>> Humm, now you lost me.
>> In your replies, you stated that the applications need to tell the
>> driver - but disagreed that a hw_params flag was the right way. I am
>> not religious here, as long as it remains simple enough we can look at
>> other options.
>>
>> I don't get however what 'single switch' are you referring to here?
> Just a simple module option or a kctl, for example.
> That is, if we can forget about the ability for adjustment per stream,
> the operation mode can be flipped by a switch on the fly.  This makes
> things a lot easier.
>
>> In all cases, I don't see how we can enable this without rebuilding
>> the apps.
>> Except for ChromeOS, I don't know how a distro would enable a switch
>> that would impact all apps using the ALSA API.
> So here came the question how it would impact on PA.
> If it doesn't work for PA, it means that essentially all traditional
> Linux distros will turn it off as default.  It's only for Android and
> Chrome OS, and they have own setup.  They can turn it on as default.
>
> If anyone wants to turn it on for JACK, they can do it.  But I don't
> think people would mix up JACK and PA on the same system at the very
> same time.  (One can hook up as a client, but then it doesn't matter
> about this hardware feature.)
I do recall Lennart implementing a mechanism to hand-over the ALSA 
resources between PulseAudio and Jack so there is a precedent here.
>
>>> And, now back to the question: in which situation you'll have to mix
>>> both no-rewind and rewind operations on a single machine?  In theory,
>>> yes, we may keep rewind working, but from the practical POV, it is
>>> only PA who uses the rewind feature.  And, even if we disable rewind,
>>> PA will still work as is.  (I know it because I broke it previously :)
>> define 'work'. If PulseAudio cannot use the rewinds, then the system
>> sounds will be heard with a delay and transitions between use cases
>> will only happen when the queued audio is finished playing.
> I just tried music players with PA, and disabled the rewind forcibly
> (by putting return 0 in rewind_appl_ptr() in pcm_native.c).  I
> couldn't hear any audible difference in its response for changing the
> stream position, etc, interactively.  There was no audible latency
> increase by that change.
>
> It was the test weeks ago, so I refreshed testing now.  And the
> result is same, I saw no response difference.
> Any specific workload to make the clear difference in your mind?
It depends on how the app is written and what the configuration of the 
server is. Back in the Meego days the plan was to use very long buffers 
and not rewinding did impact user experience. It's the same issue on 
Windows and Android with deep buffers, source transitions, volume 
changes can be painful when the committed samples cannot be invalidated.
>
>> If an app wants to play a sound immediately due to user interaction
>> requirements, rewinds are an attractive solution. I don't know how we
>> could determine ahead of time what userspace will do, certainly the
>> use of rewinds is on a per-card basis and likely a per-stream
>> decision.
>>
>>> So, what's wrong with introducing a global switch instead of changing
>>> the existing API and requiring the code change in each application and
>>> rebuild?
>> I totally agree that pretty much all apps don't do any rewinds, and
>> rewinds on capture is quite useless. But I stuck to the 'we don't
>> break userspace' mantra with the idea of an opt-in flag requiring an
>> explicit code change to take effect. we will break userspace if we add
>> a kernel-level switch, and the net result is that no one will ever use
>> this option.
> Sure, I agree with the golden "no regression" rule, too.  So I thought
> of some switch that is default off for the systems that may use
> rewind, while turning it on as default on the known systems like
> Android.  As PA is the sole user of rewind, here we won't see any
> regression, in theory.
The regression will depend on the depth of the buffer and whether apps 
are ok to indicate the max latency when connecting with PulseAudio. 
we've done crazy things with PulseAudio in the past and things will go 
wrong.

>
> And, such a system-level switch is preferable from the system
> management POV.  It's easier than a hard-coded API extension flag, and
> you can toggle it at any time for debugging if a problem happens.
>
> *IFF* the no-rewind feature is required by other multiple systems,
> adding some API would make sense.  But, currently, no-rewind is needed
> only for enabling some feature that is indirectly involved with the
> rewind on Intel chips.  To my eyes, it's too far away from the purpose
> of the PCM hw_params API.
>
> (Again, no-irq was in a different situation; it's a flag for a mode
>   that didn't exist (zero period) in the hw_params space.  But
>   no-rewind is irrelevant with the hw_params configuration itself.)

I hope we didn't give you the wrong impression that we are abusing the 
API for nefarious or Intel-specific views.
In the initial patchset some 2+ years ago, there was this change that 
disabled rewinds but also an additional functionality that let drivers 
expose the granularity of the DMA bursts to userspace (I think Jaroslav 
wanted it to be called in-flight-bytes), and possibly set them depending 
on the application need. The latter part is of interest to others, and I 
don't think removing the rewinds is useful only to Intel, as soon as 
people use a second-level buffer rewinds are problematic for everyone.

So maybe a way to progress is to leave this flag set as a module 
parameter as you suggested for now, but with the information known to 
the core, which lets Intel enable functionality on Google OSes 
(Android/Chrome), and in a second step (when we are done with SOF 
upstream) suggest a more generic API enhancement related to DMA handling 
which is not Intel specific.

Would that be agreeable?

Thanks
-Pierre
