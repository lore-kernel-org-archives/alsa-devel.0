From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 13:31:18 +0600
Message-ID: <540D5B46.3020904@gmail.com>
References: <540C76E0.9050808@gmail.com> <540CC53B.7080204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E36B32617BB
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 09:31:23 +0200 (CEST)
Received: by mail-lb0-f173.google.com with SMTP id w7so1532908lbi.4
 for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 00:31:21 -0700 (PDT)
In-Reply-To: <540CC53B.7080204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

08.09.2014 02:51, Clemens Ladisch wrote:
> Alexander E. Patrakov wrote:
>> The consensus is that rewind_safeguard is a workaround for an ALSA bug.
>
> I do not agree with this consensus.

OK, disagreements are what this thread is for :)

>
>> This information should come from snd_pcm_rewindable() from the hw
>> plugin. I.e., on a hw device, it should not be equal to
>> snd_pcm_mmap_hw_avail().  [...]
>> the safeguard should be ideally equal to the granularity of hardware
>> pointer updates.
>
> When snd_pcm_rewindable() is called, it uses the last reported hardware
> pointer position, which is the boundary between safe-to-rewrite and
> already-used data.  Subtracting the amount of one pointer update step
> makes it safe for the next pointer update, but it is not known how much
> time will elapse until the hardware does this update.  This time might
> be too small for the software to have any chance, or even zero, but it
> is also possible that there is still enough time to do the rewriting up
> until the reported boundary.  And if the software is too slow, it is
> even possible that two or more pointer updates happen, which would have
> required a larger safeguard.

I disagree with the words "boundary between safe-to-rewrite and 
already-used data". They describe a point that hardware knows, but 
software cannot know. My viewpoint is that, even with a perfect 
scheduler, known-safe-to-rewrite and known-already-used data are not 
separated with a point. See below for an example.

You indeed have a strong argument for keeping the safeguard in 
PulseAudio as a protection against scheduler glitches, but look what 
happens on ymfpci. Having read David's email, I understand that it is 
not the same reason why the safeguard has been originally added.

On ymfpci, interrupts (that don't correspond 1:1 to periods) happen 
every 5 ms, and pointer (which is a hardware register) is updated only 
during interrupts by the hardware.

|---------|---------P----h----p---------|-a-------|---------|

Here each character corresponds to 0.5 ms, "-" means nothing 
interesting, "|", "P" and "p" mark interrupt positions, "h" marks the 
place where the card reads the sound data from (i.e. the true boundary 
between safe-to-rewrite and already-used data). Thus, the interrupt at 
"P" has already happened, but the interrupt at "p" hasn't. "a" is the 
application write pointer.

So, what should alsa-lib return for snd_pcm_avail() and 
snd_pcm_rewind()? The driver only knows that "P" is already used, can 
infer that "p" isn't used yet, and knows nothing about samples in the 
middle.

For snd_pcm_avail(), it can only say that the application may only write 
up to "P" from the left. Everything else would be a possible lie leading 
to not-yet-played data possibly being overwritten.

For snd_pcm_rewindable(), it can only say that the application may try 
to go to "p" from the right. Everything further to the left is at risk 
of being already-played, even with a perfect scheduler and infinitely 
fast CPU.

> In other words: the snd_pcm_mmap_hw_avail() value is possibly ouf of
> date, but due to the real-time nature of hardware pointer updates, it is
> not possible to define a safeguard that would be more correct.  Writing
> the buffer near the DMA pointer is always racy.

Correct. The problem is that, on some cards, the uncertainty here 
(described above) is an order of magnitude bigger than typical scheduler 
glitches, and depends on sound card hardware. I don't want to introduce 
an unnecessarily-big safeguard for all sound cards because of a few bad 
ones.

So it looks like we need both the hardware-independent safeguard in 
PulseAudio (against scheduler glitches) and the hardware-dependent 
safeguard in alsa-lib (against known imprecise reporting by the card).

> The only somewhat reliable way to determine if a rewrite is successful
> is to check _afterwards_ whether the hardware pointer has advanced by
> too much.

PulseAudio does that in addition to the safeguard.

>> [...] On cards where pointer updates happen only on interrupts, the
>> driver should not configure the card in such a way that one period
>> visible to the userspace corresponds to one interrupt. Instead, it
>> should always configure the card for the minimum possible period
>> size, and report only part of the period interrupts to period_elapsed().
>
> Such stupid DMA controllers are typically found on mobile devices, which
> cannot afford extraneous interrupts.

Thanks for the information, I didn't know that, and hereby retract the 
quoted proposal.

Still, to support this type of stupid DMA controllers properly, we need 
a vocabulary of such weirdnesses and an agreed-upon way to communicate 
them from the kernel to userspace. I don't think that I can build such 
vocabulary.

>
>> === On the programmer expectations ===
>>
>> Some people, including at least Andrew Eikum and Clemens Ladisch, at
>> least once in the past expressed the opinion that amounts to "any
>> plugin that does not allow random access is, as far as the ALSA API is
>> concerned, buggy" (quoting http://permalink.gmane.org/gmane.linux.alsa.devel/122159 ),
>> i.e. they are maybe asking for the impossible.
>
> This was merely a description of the current API and its implementation,
> which assume that all devices/plugins have a rewritable ring buffer.
> I am fully aware that this assumption is wrong.

OK. Now I see that in your case it was a misinterpretation from my side 
- sorry for that! But this doesn't cancel the attitude "if a function is 
documented without any caveats, it must always work, usefully" that I 
have seen from others. So I'll put a documentation patch on my TODO list.

-- 
Alexander E. Patrakov
