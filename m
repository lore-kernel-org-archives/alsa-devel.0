From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ALSA: seq: Fix use-after-free at creating
	a port
Date: Wed, 11 Oct 2017 10:35:46 -0700
Message-ID: <CA+55aFxdPahfmqEMAuQiCULWW-53XqcRDjCYTzPH7MJh=kuDpQ@mail.gmail.com>
References: <20171011080019.16212-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AB62675CB
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 19:35:47 +0200 (CEST)
Received: by mail-io0-f179.google.com with SMTP id f20so2599913ioj.9
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 10:35:47 -0700 (PDT)
In-Reply-To: <20171011080019.16212-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Michael23 Yu <ycqzsy@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 1:00 AM, Takashi Iwai <tiwai@suse.de> wrote:
> There is a potential race window opened at creating and deleting a
> port via ioctl, as spotted by fuzzing.   [..]

I'm assuming I'll just get this through the normal sound fixes pull request?

Also, just for future issues, I really wish people would edit the call
traces to be a bit more legible. You did remove some of the excessive
KASAN noise, but the stack trace hex numbers are a bit distracting
too.

Of course, the only reason those hex numbers are there in the first
place was that the oops was generated with an older kernel - we don't
even print them out any more.

Not a big deal, but I thought I'd mention it just because I generally
encourage people to try to edit down oopses etc to the really relevant
parts (the kernel often spits out a lot of stuff that isn't really
relevant for the particular bug, because it *might* be)

Thanks,
                   Linus
