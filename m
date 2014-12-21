From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 00/10]  audio timestamping evolutions
Date: Sun, 21 Dec 2014 14:14:42 +0100
Message-ID: <5496C7C2.5060406@perex.cz>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <54948CD1.4080309@perex.cz> <549495E2.5040701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C308E26059D
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 14:14:44 +0100 (CET)
In-Reply-To: <549495E2.5040701@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dne 19.12.2014 v 22:17 Pierre-Louis Bossart napsal(a):
> Thanks for the review Jaroslav
> 
>> 1) ext_info member is not required - the standard info field
>>     has enough free bits
> 
> Well this was added at Takashi's request, the initial patches didn't 
> rely on this extension...I can roll back those changes if this is the 
> consensus.

Yes, every developer has it's own opinions.. I would just not to add
next field until the all bits are not used.

>> 2) the whole struct snd_pcm_status is R/O -
>>     _IOR('A', 0x20, struct snd_pcm_status); I believe that it's much
>>     better to add new audio_tstamp_type to sw_params, but see (4)
> 
> I thought about this, but
> - selecting the timestamp type with sw_params would require multiple 
> system calls to achieve the same results. Every additional call or delay 
> changes the accuracy of the results and correlation between data 
> consumption and timing reports.
> - existing code already relies on snd_pcm_status to retrieve system and 
> audio timestamps, the selection through other means would make the code 
> more complicated.

Not much.. See bellow..

>> 3) accuracy - I would use uint64_t and report accuracy in pico-seconds
>>     (range from 0 picoseconds to 18446744 seconds); yes, use next bytes
>>     from the reserved part of status struct. the __u32 might be used only
>>     for flags
> 
> The timestamps are not better than nanoseconds. I don't actually know of 
> any link that uses a wallclock higher than 24/48Mhz, so that's already 
> ~20-40ns already. It seemed overkill to me do use more than 3 
> significant digits and an exponent to represent a nominal value that 
> doesn't take jitter and drift into account anyway. The idea was to 
> provide a qualitative value, not an actual measurement.

I just don't like the packing. I would use uint32 for nanoseconds or
eventually, it might be good to use numerator/denominator combo like for
the rate.

>> 4) if there is a motivation to call / obtain timestamps for multiple
>>     purposes (audio tstamp types), then offer to return all these
>>     timestamps in one shot rather than do multiple queries (again, use
>>     reserved bytes)
> 
> I thought about this case but I couldn't find any practical uses of 
> multiple timestamps at the same time. In the absence of any atomic 
> hardware snapshots of multiple counters, reading multiple values 
> sequentially from different counters would actually water-down the 
> accuracy and value of the timestamps returned. It's already hard-enough 
> to track a single pair of audio and system counters.

Then - why you argument for my (2) comment against sw_params/status
combo ? I also think that one type of audio timestamp is enough for
"almost all" application to compare the audio time with other time
sources. Eventually, we can add multiple audio timestamps to the status
structure and multiple audio timestamp type selectors to sw params and
do everything in one shot (status ioctl) - which is the best method
because you save time to retreve the other fields in the status
structure again. So - for example - I would agree to have 2 audio
timestamp selectors in sw_params and provide 2 different audio
timestamps in the status structure. This may be the ultimate solution.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
