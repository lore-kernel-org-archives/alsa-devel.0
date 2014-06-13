From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC][PATCH 0/2] Fix aplay and alsa-lib
 write_areas() freezing with 100% cpu usage on stuck slave pcm
Date: Fri, 13 Jun 2014 11:05:24 +0200
Message-ID: <539ABED4.9000105@perex.cz>
References: <1402642371.496174944@f39.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 924AF261A33
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:05:27 +0200 (CEST)
In-Reply-To: <1402642371.496174944@f39.i.mail.ru>
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
Cc: sergemp@mail.ru
List-Id: alsa-devel@alsa-project.org

Date 13.6.2014 08:52, Sergey wrote:
> These patches originate from `aplay -vvv /dev/zero` not responding to Ctrl+C
> when playing to plugged "null", e.g.
>   pcm.!default {
>     type plug
>     slave.pcm { type null }
>     slave.format S32_LE
>   }
> 
> First patch fixes snd_pcm_write_areas() stuck in a loop because of transfer
> func() always returning 0. That caused application calling it to freeze.
> In the example above it have frozen aplay. If it was called by firefox,
> it would freeze firefox.
> 
> Is it a good way to fix it? Should snd_pcm_read_areas() be fixed like that too?

Nope: The whole culprit was in the null plugin - the stream was not
started, thus new samples were not delivered.

I tried to fix this in:

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=9c3086fb749cd5545be3f15cdde1592390006258

> Second patch fixes aplay itself, not returning from pcm_write() after SIGINT.

Thanks, looks good, but I added the in_aborting check to other
functions, too:

http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=c06dbf077459923066c96556678835cd1f55123a

> Additionally aplay may restore original interrupt handler, to make
> second Ctrl+C stop it for sure. In case of other bugs in alsa-lib or
> third-party slave pcms it seems better than SIGkilling it manually.
> 
> Comments and suggestions are welcome.
> 
> Regardless of these patches' fate null plugin must be fixed on its own.
> 
> Patches (2):
>   pcm: break out of snd_pcm_write_areas() if write function returned 0
>   aplay: Escape from pcm_write() when in_aborting state
> 
>  src/pcm/pcm.c |    2 +-
>  aplay/aplay.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
