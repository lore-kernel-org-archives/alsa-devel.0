From: Akram Hameed <akramh@aq1systems.com>
Subject: Fwd: Audio capture on OMAP3530/DM3730 (Yocto Poky
 Linux 3.18+) occasionally swaps channels
Date: Tue, 12 Jul 2016 16:56:11 +1000
Message-ID: <CALHzX6rh3-HMwv1pqy_X-RH911KmQgOKrPdZOHtF3DjO61HcXQ@mail.gmail.com>
References: <CALHzX6rq+n_K18M9DUhrXdMF_FOwVSRQgr+0F=WA+kOizYT78g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f175.google.com (mail-io0-f175.google.com
 [209.85.223.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9036926572A
 for <alsa-devel@alsa-project.org>; Tue, 12 Jul 2016 08:56:13 +0200 (CEST)
Received: by mail-io0-f175.google.com with SMTP id b62so8356855iod.3
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 23:56:13 -0700 (PDT)
In-Reply-To: <CALHzX6rq+n_K18M9DUhrXdMF_FOwVSRQgr+0F=WA+kOizYT78g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello there,

(Apologies for cross-posting from user list if you are seeing this twice).

I have a fairly serious problem using ALSA for capture on an Gumstix Overo
based system.  The audio device in question is a TWL4030 device. It is
connected to a TI DM3730 (or in some cases, an OMAP3530).

Previously I was using a 3.0 kernel and my audio capture worked just fine
with no extra tweaks to ALSA.

Now for other reasons I have to move to a more recent kernel, and have
tried with 3.18 and 4.4 stable releases. Using these kernels, at random
times, the audio capture channels will swap. They will remain swapped for
an unpredictable period of time, and then they will swap back. This will
continue forever, again, with the swapping occurring at random times.

Our system totally relies on predictable audio capture - so for this random
behaviour to occur means we must seek a different platform unless we can
either:

a) Find a solution for 3.18 or newer kernel (the problem is still occurring
with ALSA 1.1 on kernel 4.4) or,

b) Make some code change to solve the issue.

I found this alsa-devel thread regarding the 2.6.32 kernel that seems to be
almost exactly what I am experiencing:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-February/036895.html

I also found this one which is probably more closely related:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-March/060557.html

My current thought is that it is indeed a DMA issue, but I am not familiar
with that area of the kernel source and therefore hoping someone might have
some suggestions about what to try next.

Best regards,

Akram
