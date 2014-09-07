From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Master Plan on rewinding
Date: Sun, 07 Sep 2014 22:51:07 +0200
Message-ID: <540CC53B.7080204@ladisch.de>
References: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9623F26109F
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 22:50:18 +0200 (CEST)
In-Reply-To: <540C76E0.9050808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> The consensus is that rewind_safeguard is a workaround for an ALSA bug.

I do not agree with this consensus.

> This information should come from snd_pcm_rewindable() from the hw
> plugin. I.e., on a hw device, it should not be equal to
> snd_pcm_mmap_hw_avail().  [...]
> the safeguard should be ideally equal to the granularity of hardware
> pointer updates.

When snd_pcm_rewindable() is called, it uses the last reported hardware
pointer position, which is the boundary between safe-to-rewrite and
already-used data.  Subtracting the amount of one pointer update step
makes it safe for the next pointer update, but it is not known how much
time will elapse until the hardware does this update.  This time might
be too small for the software to have any chance, or even zero, but it
is also possible that there is still enough time to do the rewriting up
until the reported boundary.  And if the software is too slow, it is
even possible that two or more pointer updates happen, which would have
required a larger safeguard.

In other words: the snd_pcm_mmap_hw_avail() value is possibly ouf of
date, but due to the real-time nature of hardware pointer updates, it is
not possible to define a safeguard that would be more correct.  Writing
the buffer near the DMA pointer is always racy.

The only somewhat reliable way to determine if a rewrite is successful
is to check _afterwards_ whether the hardware pointer has advanced by
too much.

> [...] On cards where pointer updates happen only on interrupts, the
> driver should not configure the card in such a way that one period
> visible to the userspace corresponds to one interrupt. Instead, it
> should always configure the card for the minimum possible period
> size, and report only part of the period interrupts to period_elapsed().

Such stupid DMA controllers are typically found on mobile devices, which
cannot afford extraneous interrupts.

> === On the programmer expectations ===
>
> Some people, including at least Andrew Eikum and Clemens Ladisch, at
> least once in the past expressed the opinion that amounts to "any
> plugin that does not allow random access is, as far as the ALSA API is
> concerned, buggy" (quoting http://permalink.gmane.org/gmane.linux.alsa.devel/122159 ),
> i.e. they are maybe asking for the impossible.

This was merely a description of the current API and its implementation,
which assume that all devices/plugins have a rewritable ring buffer.
I am fully aware that this assumption is wrong.


Regards,
Clemens
