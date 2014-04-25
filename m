From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: On non-rewindability of resamplers
Date: Fri, 25 Apr 2014 08:19:30 +0200
Message-ID: <5359FE72.8050605@canonical.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F096F260851
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 08:19:31 +0200 (CEST)
In-Reply-To: <53597BA2.8080201@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-04-24 23:01, Alexander E. Patrakov wrote:
> +++++
>
> And now let's return to that fundamental problem with state. Inside the
> speculation block, I have suggested that the problem is that we don't
> have ops in snd_pcm_rate_ops_t that forward rewinds to the resampler
> implementation, so that it can restore its state to the one
> corresponding to an earlier moment in time. The real big problem (and
> the one I really meant in the original trolling attempt) is that even if
> you define new ops in snd_pcm_rate_ops_t, one can't implement them using
> existing open-source resamplers. Their APIs just don't have a function
> to rewind and to restore the prior magic samples.
>
> =====

First, thanks for doing this research. As you can see, nobody really 
went into the rewinding business in depth...

I understand that you have a mathematically perfect approach to this, as 
well as other algorithms. This would indeed be the best goal, but given 
an imperfect world, where we're forced to choose between
  1) no rewinding at all
  2) imperfect rewinding in the sense that it sometimes can produce 
hearable artifacts

...I'm not sure 1) is always the right choice...


> int snd_pcm_hw_params_is_seekable(const snd_pcm_hw_params_t *params);
>
> Check if the device fully supports rewinds and forwards.
>
> Parameters:
>      params    Configuration space
>
> Return values:
>      0    The whole plugin chain is not guaranteed to support arbitrary
> rewinds and forwards.
>      1    The whole plugin chain is guaranteed, under all remaining
> configurations in the configuration space, to support any rewinds and
> forwards that don't move the application pointer through the hardware
> pointer.
>
> If this function is called when there is more than one configuration
> exists in the configuration set (e.g. when the rate is not fixed), it
> may return pessimistic results.

I wonder if this is flexible enough. I think it would be not too 
uncommon for hardware drivers to e g transfer data to the hardware one 
period at a time. Hence what would make sense to rewind could be 
everything but the current period. A similar approach could potentially 
be done with resamplers (save state data every period so you can rewind 
correctly to exactly those points but nowhere else).

This would be good to indicate somehow. I e, I'd like to see 
snd_pcm_rewindable take into account how much actually makes sense to 
rewind, taking DMA buffer sizes and other things into account where 
appropriate. Today, we add our own margin of 1.33 ms in PulseAudio 
because (if my understanding is correct) "some DMAs don't like us 
writing exactly the block it's busy transferring", but it would be 
better if this was indicated by ALSA.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
