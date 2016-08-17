From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: locking looks odd
Date: Wed, 17 Aug 2016 19:46:42 +0200
Message-ID: <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
References: <20160816210322.GD4466@var.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 32BA7266094
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 19:46:43 +0200 (CEST)
In-Reply-To: <20160816210322.GD4466@var.home>
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
List-Id: alsa-devel@alsa-project.org

Dne 16.8.2016 v 23:03 Samuel Thibault napsal(a):
> Hello,
> 
> We are having odd issues with libasound 1.1.2 which we didn't have with
> libasound 1.1.1, more precisely
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=833950
> 
> so I'm having a look at the locking API introduced in 1.1.2, and there
> are some oddities:
> 
> - snd_pcm_new seems to initialize pcm->thread_safe to 0 by default, this
>   does not seem safe. The attached patch initializes it to 1, which
>   fixes the bug in our tests.
> 
> - snd_pcm_hw_open_fd forces it to 1, thus ignoring what snd_pcm_new set.

The thread_safe has this meaning:

0  - the pcm plugin is not thread safe
1  - the pcm plugin is thread safe (actually only the hw plugin)
-1 - disable thread safety

Your patch does not look correct. It's necessary to determine where the
mutex is locked the second time (use gdb and backtrace for all threads
for that). Note that plugins may be chained.

> - one can find both __snd_pcm_lock and snd_pcm_lock functions, what is
>   the expected difference between them?

__snd_pcm_lock/unlock is for forced lock

snd_pcm_lock/unlock skips locking for safe plugins (only hw plugin)

> - __snd_pcm_lock takes locks when thread_safe >= 0, while snd_pcm_lock
>   takes locks when thread_safe == 0, this looks really odd.

See meaning of this variable.

> - libasound could just not link against libpthread,
>   pthread_mutex_lock/unlock are already provided as empty stubs by libc,
>   the overhead will thus only be hit when the application links against
>   libpthread (libasound will then properly use pthread locks).

Good point, but this should be configurable through the configure script.

			Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
