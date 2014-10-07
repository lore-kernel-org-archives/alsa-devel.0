From: Tim Cussins <timcussins@eml.cc>
Subject: Re: proposal: snd_pcm_start_at()
Date: Tue, 07 Oct 2014 13:48:47 +0100
Message-ID: <5433E12F.70305@eml.cc>
References: <1412260460.3891605.174362449.667FB9BE@webmail.messagingengine.com>	<542D8E3F.4080400@linux.intel.com>	<542E8FE4.4080904@eml.cc>	<542F2216.7050801@linux.intel.com>
 <s5h61fxzg2y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 68CAA26045E
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 14:48:59 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by gateway2.nyi.internal (Postfix) with ESMTP id E657C2074B
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 08:48:58 -0400 (EDT)
In-Reply-To: <s5h61fxzg2y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 06/10/14 10:45, Takashi Iwai wrote:
> At Fri, 03 Oct 2014 17:24:22 -0500,
> Pierre-Louis Bossart wrote:
>>
>> On 10/3/14, 7:00 AM, Tim Cussins wrote:
>>> Hi Peirre,
>>>

>>> The pcm hardware for the new platform can start rendering when a compare
>>> register matches a hw counter (driven by the audio clock). This allows
>>> for starting with frame-accurate timing.
>>
>> Interesting. I wonder if you actually need a new extension for this, you
>> could write the timestamp in an ALSA control and implement your .trigger
>> function by using the contents of the control, i.e. delay the actual
>> start. it wouldn't be generic but your hardware isn't either.
>
> Well, your suggestion sounds really tricky.  The trigger is supposed
> to trigger the stream immediately, and the delay isn't considered
> there in principle.  The system can work with delays, but it's not in
> a form of the initial design.
>
> I think some synchronized triggering mechanism is missing in API, too.
> There has been a similar request from others in the past (Digigram
> wanted to have such a feature), so maybe it's not so uncommon
> scenario.
>
> This would be a good topic to be discussed in the upcoming audio
> mini-summit, but both of you won't be there, right?
>

I didn't have any plans to be at the mini-summit, but Glasgow isn't too 
far away...

>
> Takashi
>
