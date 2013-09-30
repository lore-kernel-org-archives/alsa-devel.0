From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] ALSA: Reduce delay for a blocking pcm_drain.
Date: Mon, 30 Sep 2013 10:45:52 +0200
Message-ID: <52493A40.3010809@ladisch.de>
References: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9574B2602F2
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 10:45:53 +0200 (CEST)
In-Reply-To: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Dylan Reid wrote:
> This patch addresses two issues related to calling snd_pcm_drain.
>
> If no_period_wakeup is set, then snd_pcm_drain would wait
> MAX_SCHEDULE_TIMEOUT jiffies, without a wakeup pending this will leave
> the calling task blocked indefinitely.

no_period_wakeup is used by applications that do _not_ want to use any
of ALSA's blocking functions (and thus want to avoid the interrupt
overhead) and use their own timers instead.  This also applies to
snd_pcm_drain.

Is there any actual application that tries to use snd_pcm_drain together
with no_period_wakeup?

> Also if the stream is running with period wakeups but with a long
> period, the delay could be seconds.  If only a small part of the
> buffer is being used, this is unnecessary.

Wakeup at period boundaries is part of the ALSA API.  (This is all what
periods are for.)

> Instead wait for the remaining samples to play out, plus one
> millisecond.

The device's clock and the Linux system clock might have larger
differences.  The only reliable synchronization source is the period
interrupt.


Regards,
Clemens
