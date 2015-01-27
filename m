From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 08/16] ALSA: line6: Drop superfluous
	spinlock for trigger
Date: Tue, 27 Jan 2015 00:22:48 -0600
Message-ID: <CAEUsAPYJcxq5eGhpZiy58USGwwxaohwjF+j0B0Qi=WRoectJeA@mail.gmail.com>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
 <1422033203-23254-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id AC157260560
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 07:22:50 +0100 (CET)
Received: by mail-qc0-f170.google.com with SMTP id p6so10688462qcv.1
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 22:22:49 -0800 (PST)
In-Reply-To: <1422033203-23254-9-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2015 at 11:13 AM, Takashi Iwai <tiwai@suse.de> wrote:
> The trigger callback is already spinlocked, so we need no more lock
> here (even for the linked substreams).  Let's drop it.

Are they linked?  It doesn't look like they are for my TonePort UX2.
I assumed this is why the trigger lock existed, to synchronize the
trigger callbacks between playback and capture because the group lock
was *not* being acquired.

And the purpose of this synchronization I assumed was to really
synchronize the calls to line6_pcm_acquire/release().  But then
hw_params() and hw_free() are calling into these seemingly without any
lock.

And line6_pcm_acquire/release() are updating line6pcm->flags
atomically, but elsewhere we're just using test_and_set_bit() and
such.

All of this looks racy to me.  Am I missing something?

Finally, what is the point of dispatching through this rather than to
the respective playback/capture callback directly?  Would this come
into play if I was seeing linked substreams?

Sorry, this is way beyond the scope of this patch.  But I've been
spending some time trying to sort this out and haven't answered the
above questions.  If I'm missing anything, a pointer to the relevant
source would be greatly appreciated!

Regards,

Chris
