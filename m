From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: dmix, snd_pcm_drain(), SND_PCM_NONBLOCK - bug?
Date: Mon, 20 Mar 2017 08:39:05 +0100
Message-ID: <1558c56b-cf47-38cb-2c69-241113074672@perex.cz>
References: <20170316122336.GA7038@swift.blarg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C219265823
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 08:39:08 +0100 (CET)
In-Reply-To: <20170316122336.GA7038@swift.blarg.de>
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
Cc: Max Kellermann <max@duempel.org>
List-Id: alsa-devel@alsa-project.org

Dne 16.3.2017 v 13:23 Max Kellermann napsal(a):
> Hi,
> 
> I have received a bug report for the Music Player Daemon which
> complains about a freezing MPD process, after I switched MPD's ALSA
> output to non-blocking mode:
> 
>  https://bugs.musicpd.org/view.php?id=4662
> 
> This happens when snd_pcm_drain() is used on a dmix PCM which is in
> SND_PCM_NONBLOCK mode.  snd_pcm_drain() will be called repeatedly,
> because ALSA's file descriptor is always ready.
> 
> According to my research, the bug is in __snd_pcm_dmix_drain().  This
> function always returns -EAGAIN when SND_PCM_NONBLOCK is set:
> 
>   if (pcm->mode & SND_PCM_NONBLOCK)
>         return -EAGAIN;
> 
> This comes very early in the function, before any other relevant
> checks.  It can never finish that way, and calling it again at any
> time will never do anything.  Thus, snd_pcm_drain() appears to be
> broken in non-blocking mode.

Could you test
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=fdc898d41135b26772d0fffe07e9eb0de6597125
? There should be a loop with -EAGAIN, but this loop should end when
then samples and drained.

> Or am I misunderstanding how snd_pcm_drain() is supposed to be used in
> non-blocking mode?

For non-blocking mode, any calls won't block. So if you like to wait for
the completion, you should do a poll/select call or switch the handle to
the blocking mode.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
