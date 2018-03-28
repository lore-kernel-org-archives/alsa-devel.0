From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RESEND][PATCH v4 1/3] ALSA: core: let low-level
 driver or userspace disable rewinds
Date: Wed, 28 Mar 2018 09:30:09 -0500
Message-ID: <c5967958-7bb0-3351-f818-549675645a1d@linux.intel.com>
References: <1521561668-28613-1-git-send-email-sriramx.periyasamy@intel.com>
 <1521561668-28613-2-git-send-email-sriramx.periyasamy@intel.com>
 <s5ho9jiu3fk.wl-tiwai@suse.de> <20180325104643.GA13721@intel.com>
 <s5h1sg88aml.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id C82EA266F93
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 16:30:07 +0200 (CEST)
In-Reply-To: <s5h1sg88aml.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On 3/25/18 9:58 AM, Takashi Iwai wrote:
> On Sun, 25 Mar 2018 12:46:43 +0200,
> Sriram Periyasamy wrote:
>>
>> On Tue, Mar 20, 2018 at 05:17:35PM +0100, Takashi Iwai wrote:
>>> On Tue, 20 Mar 2018 17:01:06 +0100,
>>> Sriram Periyasamy wrote:
>>>>
>>>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>>
>>>> Add new hw_params flag to explicitly tell driver that rewinds will never
>>>> be used. This can be used by low-level driver to optimize DMA operations
>>>> and reduce power consumption. Use this flag only when data written in
>>>> ring buffer will never be invalidated, e.g. any update of appl_ptr is
>>>> final.
>>>>
>>>> Note that the update of appl_ptr include both a read/write data
>>>> operation as well as snd_pcm_forward() whose behavior is not modified.
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
>>>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>>>> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>>>
>>> Well, I'm still not convinced with this flag.
>>>
>>> First off, does it really need to be per PCM stream?  The introducing
>>
>> Flag per PCM stream helps where each stream in given system may have
>> different requirement such as low power or low latency based on the
>> use case. For example in case of low power stream, driver can perform
>> required optimizations at hardware level based on the no_rewind flag.
> 
> Yes, but does it really need to be PCM stream, i.e. per application?
> Certainly the system will be using some sound backend (like PA).  In
> which scenario can such behavior change -- some application uses a
> different backend on a phone or a tablet?

This is intended for the case where the system server exposes a 
'deep-buffer' PCM device for music playback in low-power mode and a 
separate one for system sounds or anything that requires interactivity.
The need for rewinding is really for the case where the interactive 
system sounds are mixed with music, when you have separation between 
types of sounds and hardware/firmware mixing then the rewinds are 
unnecessary.

If there are multiple applications using different PCM devices each 
(which is a bit hypothetical to me) there is no way to know ahead of 
time when the modules are loaded if the application will perform rewinds 
due to its interactive nature or will just stream without ever 
invalidating the ring buffer. So yes it's per stream.

> 
> 
>>> something to hw_parms implies that it varies per application.  But I
>>> can't imagine that a system requires different behavior per stream
>>> regarding such a thing.
>>>
>>> Second, the driver can implement a check in PCM ack callback to
>>> prevent the rewind, too.  Then there is no need to touch the PCM
>>> core.
>>>
>>
>> As per the previous discussion at [1],
>>
>> [1]
>> https://patchwork.kernel.org/patch/9795233/
>>
>> from Pierre,
>>
>> "The application (which is in most cases an audio server) *knows* if it
>> requires rewinds or not. It's part of its design, with rewinds typically
>> disabled if period interrupts are required. It's been that way for a
>> number of years now. The use of rewinds is typically associated with the
>> combination of a large buffer and no interrupts (having either of the
>> two would not require rewinds).
>>
>> So the idea is that the application makes a statement that rewinds will
>> not be used, and the low-level driver makes use of the information to
>> enable whatever optimizations are available at the hardware level.
>>
>> Exposing more information to userspace would quickly lead to a confusing
>> decision-making and would require more than just a flag."
> 
> And, requiring *that* information is already confusing, IMO.
> Think from the application writer POV: what is the relation between
> the power-saving and no_rewind behavior in application level at all?
> If you have no idea about the hardware details, they are totally
> irrelevant.

I feel like disabling IRQs or disabling rewinds is the same level of 
information, you set the flags without necessary knowing all the power 
savings down to the mW level. But it provides an opportunity to save 
power with additional degrees of freedom for implementations.

An additional benefit of using the underlying SPIB register on Intel 
hardware is that the DMA hardware will not wrap-around, which can lead 
to better detection of real-time issues and a guarantee that stale data 
will not be played.

> 
> Or, think like this way: imagine a hardware that requires a different
> constraint, e.g. the power-of-two buffer size, for power-efficient
> operation.  What would you do?  Adding a new power_of_two bit flag
> into hw_params?  Likely not.

we've added the noIRQ mode in the past using flags, if now you are 
saying that flags is a bad idea then fine, but let's be consistent...

> 
> In such a case, I would expect some operation mode switch
> (e.g. power-saving vs low latency or whatever) instead of a very
> specific hw_parmas flag.  It might be a module option, via ALSA
> control, or something else.  But it's clearer for which purpose it's
> present, at least, and it can be implemented well without changing the
> existing API.

We have no way of predicting what the application will do so the module 
option is not possible.

Using an ALSA control is possible, but it's odd to me.

I really don't see what's so problematic about adding flags. I uses an 
existing capability of the API, it's consistent with the previous 
usages. There is no change in behavior for existing apps, only newer can 
benefit for better use of the hardware. There is no complicated decision 
making, you set the flags if you don't use IRQ or rewinds.
And it's not like we will have new flags every week, we've been talking 
about this SPIB capability since Skylake which is 3 years old already.

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
