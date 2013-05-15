From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PulseAudio and softvol
Date: Wed, 15 May 2013 13:22:03 +0200
Message-ID: <51936FDB.2050407@perex.cz>
References: <1368611744.6590.8.camel@localhost> <519362EB.7050603@perex.cz>
 <s5hd2ssmsd2.wl%tiwai@suse.de> <5193692A.4060007@perex.cz>
 <51936B74.6080105@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D00E2615D1
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 13:22:04 +0200 (CEST)
In-Reply-To: <51936B74.6080105@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Date 15.5.2013 13:03, David Henningsson wrote:
> On 05/15/2013 12:53 PM, Jaroslav Kysela wrote:
>> Date 15.5.2013 12:48, Takashi Iwai wrote:
>>> At Wed, 15 May 2013 12:26:51 +0200,
>>> Jaroslav Kysela wrote:
>>>>
>>>> Date 15.5.2013 11:55, Arun Raghavan wrote:
>>>>> Hello,
>>>>> A number of users have intermittently(?) been hitting a crash in
>>>>> alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
>>>>> reproduce this reliably, so can't find an easy way to debug/fix.
>>>>
>>>> The problem is that the offsets are not in sync in this case [1]:
>>>>
>>>> src_offset = 38560
>>>> dst_offset = 38568
>>>> frames = 16374
>>>>
>>>> Could you reproduce this bug in any way? At least snd_pcm_dump() before
>>>> the failing snd_pcm_mmap_commit() call might help to determine what was
>>>> the status before the assert() was entered.
>>>
>>> Yep.  And this path is actually with volume 0dB, that is, a simply
>>> passthrough in softvol.  Thus the bug may hit essentially any
>>> plugins, not specifically softvol.
>>>
>>>
>>>>> However, this raises a tangential question - why do we need softvol to
>>>>> be plugged for 'front' at all? David explained to me that this is to
>>>>> guarantee the existence of a PCM control. Perhaps I don't fully
>>>>> understand this, because I'm unconvinced by the reason. Could someone
>>>>> explain/refute?
>>>>>
>>>>> This is especially bad for us, from PulseAudio's perspective, because we
>>>>> aren't getting a zero-copy path.
>>>>
>>>> If the softvol is set to 0dB (no attenuation or gain), then the ring
>>>> buffer pointers are moved without any sample processing, so the
>>>> zero-copy functionality is kept.
>>>
>>> Yeah, a sort of.  The mmap is cleared in the slave PCM, so actually
>>> there will be copy operations in underlying layers even though softvol
>>> itself does zero copy.
>>>
>>> Actually it makes no sense to keep softvol for PA, but the problem is
>>> always the regression.  There are certainly users without PA, which
>>> might still rely on the softvol for such hardware without the amp
>>> control.
>>>
>>> Maybe We can add some flag to indicate whether to handle softvol or
>>> not, e.g. defaults.pcm.skip_softvol, and let PA set this in its config
>>> space.  Setting a config item itself would break anything, so it'll
>>> still work with old alsa-lib (but with softvol).
>>
>> We have already SND_PCM_NO_SOFTVOL open mode for this purpose, so I
>> wonder, why PA does not use it..
> 
> The problem is knowing whether PCM is a softvol or not. In some cases, 
> we need to set PCM to control hardware volume.
> 
> Maybe, if we could figure this out somehow, we could ignore the PCM 
> mixer control (or possibly set it to zero) in case PCM is a softvol,
> and actually use it if PCM is not a softvol.
> 
> It does not look like this is currently possible from the simple mixer 
> interface, but I might be missing something?

It is not possible. Perhaps, we may create a new dummy mixer control (in
an inactive state) which will identify the presence of the softvol
plugin, like:

"Softvol PCM Playback Volume" - full name for the raw control API
"Softvol PCM" - simple mixer name

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
