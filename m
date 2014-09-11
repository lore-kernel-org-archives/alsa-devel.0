From: Radoslaw Szkodzinski <astralstorm@gmail.com>
Subject: Re: alsa-jack issues
Date: Thu, 11 Sep 2014 11:02:14 +0200
Message-ID: <CAAmECqQmkN5nnRhzNmMxZC=cmNqkaf24LLv0bhxyHGKZirHmAg@mail.gmail.com>
References: <CAAmECqSO1YnykkVZYydjLJb5mrE5q=b6Fu4P4RrkVgsT6rMCOw@mail.gmail.com>
 <1410392000.378953844@f433.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 930CD26501D
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 11:02:54 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id ge10so5290048lab.40
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 02:02:54 -0700 (PDT)
In-Reply-To: <1410392000.378953844@f433.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey <sergemp@mail.ru>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 11, 2014 at 1:33 AM, Sergey <sergemp@mail.ru> wrote:
> Sat, 6 Sep 2014 Radoslaw Szkodzinski wrote:
>
>>A recent change in alsa-plugins 1.0.28 alsa-jack has changed the poll semantics.
>>This breaks audacious and mpv, perhaps more applications.
>>
>>The regression is caused by:
>>Commit: 9217377337cdceb62abeb5969112b738bb5cd551
>>jack: fix polling and recovering
>
> I'm initial author of this commit and I'd love to fix the issue,
> but it never happens to me. I need your help to fix it.
>
> Can you provide some steps to reproduce this bug? How much time it
> takes to reproduce it? Can you reproduce it with alsa 1.0.27 and
> alsa-jack plugin 1.0.28? You can download that plugin separately:

I'll test this during the weekend. 1.0.27.x was fine with alsa 1.0.27.

> By the way, what distribution are you using?
> Is there a livecd that I can download to reproduce this problem?

This is actually Gentoo, so not really. However, I think it should be
reproducible anywhere.

>>This might or might not be related to lack of
>>snd_pcm_poll_descriptor_revents call or the use of a timer instead of
>>repolling.
>
> It should not. But we can't be sure until we find what causes it.

I'm not entirely sure myself. The above mentioned applications cause
the problem.
The whole setup consists of:

Highly patched 3.12.x kernel, no RT patches but in full preempt mode.
Jack2 in DBus mode, realtime and mlock enabled. ALSA output to ICE1724
soundcard, sample rate matched everywhere to 44.1kHz.
ALSA set to use speexrate_best and 44.1kHz by default if this is important.

Applications:
Ladish
Carla with Caps equalizers and one other personal LADSPA plugin (RT safe).
Directly connecting to playback also reproduces the issue.

Any period size and nframes, though very long period sizes vastly
reduce the likelihood this is reproducible.
It is not related to xruns directly, but an xrun can precipitate the issue too.

Reproducible in audacious 3.4.1 or older and mpv (git revision, from
this month or older), but not with sox or aplay.
No problems with direct Jack outputs of the above applications whatsoever.

Both of the problematic applications use a sleep timer in addition or
instead of polling. (audacious due to a bug, mpv by design I think)

> I'm sorry for bothering you.

Not a bother at all, I'd like to see this fixed.

R.
