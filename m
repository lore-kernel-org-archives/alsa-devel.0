From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Stale data interleaved in capture driver
Date: Mon, 1 Aug 2016 08:34:11 +0200
Message-ID: <bdbdcb8f-8deb-20a7-51ec-f123328880ac@ladisch.de>
References: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9A46A2658A6
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 08:34:12 +0200 (CEST)
In-Reply-To: <CALAeOVO94y6R6bZOWK=2TfEckyVUxRXBMcOtXWvuoO5oG_4V4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> an IRQ every 32Bytes (half-frame)
>
> I wrote my handler as described in the high-frequency interrupts described
> here:
> http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s07.html

This does not make sense; you need a timer only when you do not have
a proper interrupt.  Why do you think you need to do it this way?

> My data is valid until 1/4 buffer full, then it interleaves stale (lower
> numbers) in, replacing the desired numbers. It's sporadic, and it appears
> to repeat, as if ALSA never returns to the 0-offset of dma_area.

ALSA just reports what your driver tells it; this sounds like a bug
in your driver or in the hardware.


Regards,
Clemens
