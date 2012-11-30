From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 2/5] ALSA: hda - More generic auto-mic
 switching for Realtek codecs
Date: Fri, 30 Nov 2012 08:54:43 +0100
Message-ID: <50B86643.4010900@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-3-git-send-email-tiwai@suse.de>
 <50B7F9C7.9040801@canonical.com> <s5hboef4l17.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CAAED2615F7
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 08:54:45 +0100 (CET)
In-Reply-To: <s5hboef4l17.wl%tiwai@suse.de>
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

On 11/30/2012 08:17 AM, Takashi Iwai wrote:
> At Fri, 30 Nov 2012 01:11:51 +0100,
> David Henningsson wrote:
>>
>> On 11/29/2012 04:21 PM, Takashi Iwai wrote:
>>> Instead of limiting the automatic input-source selection only to the
>>> mics (internal, external and dock mics), allow it for generic inputs,
>>> e.g. switching between the rear line-in and the front mic.
>>>
>>> It's been a frequent demand from desktop machines, and we already do
>>> it for the headphone auto-mute, so no reason to avoid it now.
>>>
>>> The logic is to check the attribute and location of input pins, and
>>> enable the automatic selection feature only if all such pins are in
>>> different locations (e.g. internal, front, rear, etc) and line-in or
>>> mic pins.  That is, if multiple input pins are assigned to a single
>>> location, the feature isn't enabled because we don't know the
>>> priority.
>>
>> Hmm, I'm a bit worried about this, partially because it makes things
>> inconsistent between codecs (and kernel versions, too).
>
> The behavior change is an open question, yes.
> If we'd like to be conservative, auto_mic can be set to 0 except for
> non-laptop cases.

I'm not sure which one is better, really. If Windows/Mac does it in a 
specific way then maybe people are used to that and want it to work that 
way with Linux too. Maybe I should ask some design people about it...

>> In current PulseAudio, we disable the internal mic if any other mic is
>> being detected as plugged in.
>> But if there are other switches, say "front mic" and "rear mic", we
>> don't do such disabling. Now you're disabling one of them automatically
>> in the kernel, but for one codec only.
>
> Porting this to other codecs shouldn't be too hard.
>
>> So my point is, when both "Front mic" and "Rear mic" are plugged in, we
>> don't know whether to present to the user to choose between "Front Mic"
>> and "Rear Mic", or to disable one of them.
>
> The input is exclusive, so one of them is chosen.  It's the front one.

Right, but this goes only for Realtek (given the current set of patches).

But thinking some more about it, I guess we could implement the same 
priority order in PulseAudio, so that the mic will autoswitch regardless 
of codec. That would ensure a consistent experience between codecs, and 
would be easier (and better) than trying to detect if the current codec 
is a Realtek or not.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
