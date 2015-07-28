From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Tue, 28 Jul 2015 20:43:13 +0500
Message-ID: <55B7A311.5070905@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <55A14D23.3070600@gmail.com> <55B78F74.1020601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id A09012616C9
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 17:43:16 +0200 (CEST)
Received: by wibud3 with SMTP id ud3so165511120wib.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 08:43:16 -0700 (PDT)
In-Reply-To: <55B78F74.1020601@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

28.07.2015 19:19, Pierre-Louis Bossart wrote:
> On 7/11/15 12:06 PM, Alexander E. Patrakov wrote:

>> 3. I have not seen any justification for the drastic measure of making a
>> DMA-based device completely unrewindable. Maybe a more polite "please
>> make this a batch/blocktransfer card" request, thus disallowing only
>> sub-period rewinds, would still be useful for powersaving, without
>> killing dmix.
>>
>> 4. If this "no rewinds" mode is not made the default, then exactly
>> nobody will use it. Everyone except sound servers opens the default
>> device with the default flags. I understand the potential to break
>> existing userspace, especially PulseAudio, but we really need to think
>> more here.
>
> Not sure I understand the issue. when a new functionality is added it
> takes time to be adopted. If we can push it in sound servers first then
> it creates a wide pool of users from day1.

The issue is that the proposed functionality, in the currently proposed 
"I promise to never rewind" form, is nearly useless by its very nature 
for any sound server that cares about power consumption significantly 
more than dmix does. It is indeed usable by JACK (by its design, it 
doesn't rewind, and uses low latency) and CRAS (which currently doesn't 
rewind, but I am not sure whether this is a bug or a deliberate decision 
based on non-public measurements of extra power savings that "rewinds + 
high latency" would allow).

As I have already explained, dmix, when mixing, writes to the hardware 
buffer multiple times, which is equivalent to rewinding. PulseAudio uses 
rewinds for a very specific purpose - to avoid CPU wakeups in the common 
"nothing unexpected happened" case, i.e. to allow very high average 
latency while keeping the latency of reaction to unexpected events low. 
So, by convincing PulseAudio to never rewind and to tell the driver 
about this fact, you can save some power in the card, but (if the 
proponents of rewinds are right - see my earlier request for non-public 
information) will waste way more power due to the need for much more 
frequent CPU wakeups ("cannot rewind but have to react to unexpected 
events within 20 ms" = "must wake up every 20 ms").

The only cases where this flag can be useful for sound servers are:

1. Sound servers that already, by design, always waste CPU power by 
running at low latency;

2. Sound cards like USB audio where the kernel already contains a 
low-latency thread that copies data to the card in the serialized way.

For PulseAudio on Intel hardware and HDA-compatible card, it would (if 
the situation on my Sony laptop is an exception and not the rule), as I 
have already mentioned, only trade some power consumption improvement in 
the card for bigger losses in the CPU.

And with (2), I am not sure whether this is a win at all: you are likely 
trading a kernel thread that wakes up, say, every 6 ms (with userspace 
waking up very rarely), to a userspace wakeup that happens every 6 or 
maybe 20 ms (as the sound server chooses), but incurs more context 
switches. It does shift the policy decision about the wakeup rate to 
userspace, though.

-- 
Alexander E. Patrakov
