From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 00/10]  audio timestamping evolutions
Date: Mon, 05 Jan 2015 15:11:37 -0600
Message-ID: <54AAFE09.7000108@linux.intel.com>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <54948CD1.4080309@perex.cz> <549495E2.5040701@linux.intel.com>
 <5496C7C2.5060406@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 33B622605A2
 for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2015 22:11:40 +0100 (CET)
In-Reply-To: <5496C7C2.5060406@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 12/21/14 7:14 AM, Jaroslav Kysela wrote:
> Dne 19.12.2014 v 22:17 Pierre-Louis Bossart napsal(a):
>> Thanks for the review Jaroslav
>>
>>> 1) ext_info member is not required - the standard info field
>>>      has enough free bits
>>
>> Well this was added at Takashi's request, the initial patches didn't
>> rely on this extension...I can roll back those changes if this is the
>> consensus.
>
> Yes, every developer has it's own opinions.. I would just not to add
> next field until the all bits are not used.

I kind of like Takashi's argument that all timestamp bits should remain =

together in a new field.

>
>>> 2) the whole struct snd_pcm_status is R/O -
>>>      _IOR('A', 0x20, struct snd_pcm_status); I believe that it's much
>>>      better to add new audio_tstamp_type to sw_params, but see (4)
>>
>> I thought about this, but
>> - selecting the timestamp type with sw_params would require multiple
>> system calls to achieve the same results. Every additional call or delay
>> changes the accuracy of the results and correlation between data
>> consumption and timing reports.
>> - existing code already relies on snd_pcm_status to retrieve system and
>> audio timestamps, the selection through other means would make the code
>> more complicated.
>
> Not much.. See bellow..
>
>>> 3) accuracy - I would use uint64_t and report accuracy in pico-seconds
>>>      (range from 0 picoseconds to 18446744 seconds); yes, use next bytes
>>>      from the reserved part of status struct. the __u32 might be used o=
nly
>>>      for flags
>>
>> The timestamps are not better than nanoseconds. I don't actually know of
>> any link that uses a wallclock higher than 24/48Mhz, so that's already
>> ~20-40ns already. It seemed overkill to me do use more than 3
>> significant digits and an exponent to represent a nominal value that
>> doesn't take jitter and drift into account anyway. The idea was to
>> provide a qualitative value, not an actual measurement.
>
> I just don't like the packing. I would use uint32 for nanoseconds or
> eventually, it might be good to use numerator/denominator combo like for
> the rate.

ok, i'll remove the packing. I was only trying to save space but if =

there are no issues reclaiming more bits then it's indeed more elegant.

>>> 4) if there is a motivation to call / obtain timestamps for multiple
>>>      purposes (audio tstamp types), then offer to return all these
>>>      timestamps in one shot rather than do multiple queries (again, use
>>>      reserved bytes)
>>
>> I thought about this case but I couldn't find any practical uses of
>> multiple timestamps at the same time. In the absence of any atomic
>> hardware snapshots of multiple counters, reading multiple values
>> sequentially from different counters would actually water-down the
>> accuracy and value of the timestamps returned. It's already hard-enough
>> to track a single pair of audio and system counters.
>
> Then - why you argument for my (2) comment against sw_params/status
> combo ? I also think that one type of audio timestamp is enough for
> "almost all" application to compare the audio time with other time
> sources. Eventually, we can add multiple audio timestamps to the status
> structure and multiple audio timestamp type selectors to sw params and
> do everything in one shot (status ioctl) - which is the best method
> because you save time to retreve the other fields in the status
> structure again. So - for example - I would agree to have 2 audio
> timestamp selectors in sw_params and provide 2 different audio
> timestamps in the status structure. This may be the ultimate solution.

I agree that the two-timestamp solution is fine on paper, but it'd still =

be too disruptive for platforms with DSPs and that's the reason why I =

suggested a dynamic in-band selection of the timestamp type.

What I have in mind for a typical time-aware application is as follows:

ThreadA is in charge of data handling. When it=92s awaken (period-elapsed
or timer interrupt), it reads the status and provides/extracts the data =

needed. It would also handle sample-rate conversion or timer smoothing =

if needed.

ThreadB is unrelated to data transfers and queries an audio timestamp on =

a 'regular' application-defined interval, e.g. every second. The =

precision is typically higher in this case than in ThreadA and the =

timestamp used for A/V sync, network alignment, anything where time =

matters. This information might be used in the SRC/smoothing used by =

ThreadA as well.

Depending on hardware design, the timestamps may be generated by a =

simple register read or require IPC with the DSP. The latter case is a =

lot more costly and disruptive. By letting ThreadA select a timestamp =

that doesn't require any IPC, we'd minimize the amount of handshakes =

with the DSP and make an optimal use of the hardware. I wouldn't have =

started this work without a hardware-driven need, a one-size-fits-all =

approach doesn't work. If the extended precision results in =

delays/hand-shakes then we only want to use it when needed, not by default.

Hope this clarifies the proposal.
-Pierre
