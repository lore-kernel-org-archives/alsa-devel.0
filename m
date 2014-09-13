From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/9] Misc fixes related to rewinds
Date: Sat, 13 Sep 2014 21:14:17 +0200
Message-ID: <54149789.2060102@perex.cz>
References: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E153261B02
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 21:14:18 +0200 (CEST)
In-Reply-To: <1410633021-20395-1-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Date 13.9.2014 20:30, Alexander E. Patrakov wrote:
> The idea of the series is to fix the two issues that I found [1] for the

I applied all your patches to alsa-lib's repo, but...

> hw plugin. snd_pcm_rewindable() sometimes returned negative values that
> are actually negative amounts of samples and not error codes. Also, it
> bases its calculations on stale hardware position pointer, which is not
> what PulseAudio wants (alternatively, we can document the need to call
> snd_pcm_avail() before snd_pcm_rewindable(), but I don't like it).

The hw sync is expensive and the application might do this sync multiple
times when woken up. I think that it must be clear that:

1) only snd_pcm_avail(), snd_pcm_delay(), snd_pcm_avail_delay()
   does the real hw sync
2) snd_pcm_avail(), snd_pcm_delay(), snd_pcm_avail_delay(),
   snd_pcm_rewindable() and snd_pcm_forwardable() does
   hw sync (and change all plugins to respect this)

I don't like the situation "be somewhere between because it's good for
one purpose"...

			Thanks for your work,
                                           Jaroslav

BTW: I'm starting to think about the 1.0.29 release...

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
