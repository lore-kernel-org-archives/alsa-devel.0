From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 11:08:16 +0200
Message-ID: <540EC380.6030903@canonical.com>
References: <540C76E0.9050808@gmail.com>
 <540CC53B.7080204@ladisch.de>	<540D5B46.3020904@gmail.com>
 <540EBD9A.9000009@ladisch.de> <540EC08E.4000906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 823812615BF
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 11:08:13 +0200 (CEST)
In-Reply-To: <540EC08E.4000906@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org



On 2014-09-09 10:55, Alexander E. Patrakov wrote:
> 09.09.2014 14:43, Clemens Ladisch wrote:
>> Alexander E. Patrakov wrote:
>>> |---------|---------P----h----p---------|-a-------|---------|
>>>
>>> So, what should alsa-lib return for snd_pcm_avail() and
>>> snd_pcm_rewind()?
>>> The driver only knows that "P" is already used, can infer that "p" isn't
>>> used yet, and knows nothing about samples in the middle.
>> Indeed.  However, the DMA pointer moves asynchronously, so it is possible
>> that it has already moved beyond p when snd_pcm_rewindable() returns.
>> For the samples between P and p, the risk is larger than for those after
>> p, but p is not a boundary where the risk abruptly decreases.
>>
>> It would make sense to report the pointer update granularity, but not
>> to adjust the return value of snd_pcm_avail/rewindable().
>
> OK, I understand your viewpoint, and the phrase "some indicator of the
> actual rewind granularity and/or safeguard ... should be enough for PA
> to be able to pick a suitable default latency" from David indicates that
> he has a similar opinion.
>
> Now the remaining question is: can the proposed heuristic (minimum
> period size for a given sample rate, number of channels and sample
> format) be useful as an upper-bound approximation of the pointer update
> granularity for cards that are "rewindable even further than the nearest
> period"?

Aha, thanks for the explanation. Now I understand that approximation idea.
I don't know if that's a reasonable approximation, but even if it is, 
how would you determine if a card actually has that pointer granularity, 
or if the pointer granularity varies with period size? (I e without 
actually running a stream and measure it)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
