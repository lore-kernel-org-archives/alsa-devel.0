From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem bringing up new alsa driver
Date: Sat, 25 Apr 2009 17:28:55 -0400
Message-ID: <9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 5908C245D3
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 23:28:56 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1380812qwk.56
	for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2009 14:28:55 -0700 (PDT)
In-Reply-To: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

These new patches have broken audio support on the mpc5200....

They assume that the hardware is capable of telling where the DMA
engine is in the middle of an operation.  I'm still checking to see if
I can get that data out of the Bestcomm DMA engine.

jonsmirl@terra:/home/linus/sound/core$ git log pcm_lib.c
commit bbf6ad1399e9516b0a95de3ad58ffbaed670e4cc
Author: Jaroslav Kysela <perex@perex.cz>
Date:   Fri Apr 10 12:28:58 2009 +0200

    [ALSA] pcm-midlevel: Add more strict buffer position checks based on jiffies

    Some drivers like Intel8x0 or Intel HDA are broken for some
hardware variants.
    This patch adds more strict buffer position checks based on jiffies when
    internal hw_ptr is updated. Enable xrun_debug to see mangling of wrong
    positions.

    As a side effect, the hw_ptr interrupt update routine might do
slightly better
    job when many interrupts are lost.

    Signed-off-by: Jaroslav Kysela <perex@perex.cz>

commit 8b22d943c34b616eefbd6d2f8f197a53b1f29fd0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Mar 20 16:26:15 2009 +0100

    ALSA: pcm - Safer boundary checks

    Make the boundary checks a bit safer.
    These caese are rare or theoretically won't happen, but nothing
    bad to keep the checks safer...

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

commit ded652f7024bc2d7b6118b561a44187af30841b0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Mar 19 10:08:49 2009 +0100

    ALSA: pcm - Fix delta calculation at boundary overlap

    When the hw_ptr_interrupt reaches the boundary, it must check whether
    the hw_base was already lapped and corret the delta value appropriately.

    Also, rebasing the hw_ptr needs a correction because buffer_size isn't
    always aligned to period_size.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

commit 5f513e1197f27e9a0bcfec0feaac59f976f4a37e
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Mar 19 10:01:47 2009 +0100

    ALSA: pcm - Reset invalid position even without debug option

    Always reset the invalind hw_ptr position returned by the pointer
    callback.  The behavior should be consitent independently from the
    debug option.

    Also, add the printk_ratelimit() check to avoid flooding debug
    prints.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>



-- 
Jon Smirl
jonsmirl@gmail.com
