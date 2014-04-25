From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Fri, 25 Apr 2014 20:09:26 +0600
Message-ID: <535A6C96.7040109@gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id B43C7265624
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 16:12:29 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id l4so3153228lbv.13
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 07:12:29 -0700 (PDT)
In-Reply-To: <5359FE72.8050605@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

25.04.2014 12:19, David Henningsson wrote:
> I understand that you have a mathematically perfect approach to this, as
> well as other algorithms. This would indeed be the best goal, but given
> an imperfect world, where we're forced to choose between
>   1) no rewinding at all
>   2) imperfect rewinding in the sense that it sometimes can produce
> hearable artifacts
>
> ...I'm not sure 1) is always the right choice...

Understood. But IMHO (2) with a warning would be better than the current 
situation of (2) without any indication of the problem.

>> int snd_pcm_hw_params_is_seekable(const snd_pcm_hw_params_t *params);
>>
>> Check if the device fully supports rewinds and forwards.
>>
>> Parameters:
>>      params    Configuration space
>>
>> Return values:
>>      0    The whole plugin chain is not guaranteed to support arbitrary
>> rewinds and forwards.
>>      1    The whole plugin chain is guaranteed, under all remaining
>> configurations in the configuration space, to support any rewinds and
>> forwards that don't move the application pointer through the hardware
>> pointer.
>>
>> If this function is called when there is more than one configuration
>> exists in the configuration set (e.g. when the rate is not fixed), it
>> may return pessimistic results.
>
> I wonder if this is flexible enough. I think it would be not too
> uncommon for hardware drivers to e g transfer data to the hardware one
> period at a time. Hence what would make sense to rewind could be
> everything but the current period. A similar approach could potentially
> be done with resamplers (save state data every period so you can rewind
> correctly to exactly those points but nowhere else).
>
> This would be good to indicate somehow. I e, I'd like to see
> snd_pcm_rewindable take into account how much actually makes sense to
> rewind, taking DMA buffer sizes and other things into account where
> appropriate. Today, we add our own margin of 1.33 ms in PulseAudio
> because (if my understanding is correct) "some DMAs don't like us
> writing exactly the block it's busy transferring", but it would be
> better if this was indicated by ALSA.

This looks like two valid feature requests. Regarding the limited 
flexibility, this can be solved by returning a bitmask of rewind-related 
limitations, but the current hw_params API doesn't have any functions 
that return bitmasks. Instead, for each new problem, a new function is 
created. So it may make sense to create more than one function. However, 
I am afraid to create a duplicate of an existing function. Does anyone 
know whether the "must not rewind to the current period" limitation is 
the same as already indicated by snd_pcm_hw_params_get_fifo_size() or 
snd_pcm_hw_params_is_batch() or snd_pcm_hw_params_is_block_transfer()?

Of course, these limitations should be honoured by snd_pcm_rewindable().

As for the applicability of limiting the rewinds to the period 
boundaries (where the resampler state is saved), then we have already 
discussed something similar in person during LinuxCon Europe 2013 in the 
context of PulseAudio and IIR filters. If access to the original samples 
since the beginning of that period is not lost, then we can rewind to 
the period boundary earlier than needed, then restore the state and 
reapply the samples between that period boundary and the point we 
actually wanted to reply to. So the net effect would be "can rewind to 
anything except the currently playing period". OTOH I know another 
approach that would make only a few samples non-rewindable (i.e. will 
look similar to the 1.33ms limitation), and I will probably try to 
implement it on my vacation as a new proof-of-concept library.

-- 
Alexander E. Patrakov
