From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [RFC] ALSA: Reduce delay for a blocking pcm_drain.
Date: Mon, 30 Sep 2013 09:20:14 -0700
Message-ID: <CAEUnVG6zi84EEntNodeUfNVRMdtdKK5j2au5__fccm3jtMvdYg@mail.gmail.com>
References: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
 <52493A40.3010809@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f54.google.com (mail-qe0-f54.google.com
 [209.85.128.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6214A261AB2
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 18:20:37 +0200 (CEST)
Received: by mail-qe0-f54.google.com with SMTP id cy11so3915410qeb.41
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 09:20:36 -0700 (PDT)
In-Reply-To: <52493A40.3010809@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 30, 2013 at 1:45 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Dylan Reid wrote:
>> This patch addresses two issues related to calling snd_pcm_drain.
>>
>> If no_period_wakeup is set, then snd_pcm_drain would wait
>> MAX_SCHEDULE_TIMEOUT jiffies, without a wakeup pending this will leave
>> the calling task blocked indefinitely.
>
> no_period_wakeup is used by applications that do _not_ want to use any
> of ALSA's blocking functions (and thus want to avoid the interrupt
> overhead) and use their own timers instead.  This also applies to
> snd_pcm_drain.
>
> Is there any actual application that tries to use snd_pcm_drain together
> with no_period_wakeup?

Not a real one.  I am using no_period_wakeup and looking for an easy
way to flush at the end.  User space already knows the buffer level,
so it can wait for the appropriate time and wait for an underrun just
as easily.  Thanks for the explanation all.

Dylan
