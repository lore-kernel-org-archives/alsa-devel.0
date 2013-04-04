From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Deadlock over semaphore issue with aplay while
 using dmix
Date: Thu, 04 Apr 2013 13:33:08 +0200
Message-ID: <515D64F4.8030903@perex.cz>
References: <CADryByGnyH9rUDBuG_JRPrSgCb3LPwhaVdFXXeELiUYQv+ZHwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EA169265E4E
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 13:33:11 +0200 (CEST)
Received: from server.perex-int.cz (server.perex-srv.cz [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 8CF8C149927
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 13:33:10 +0200 (CEST)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 40685849BD
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 13:33:10 +0200 (CEST)
In-Reply-To: <CADryByGnyH9rUDBuG_JRPrSgCb3LPwhaVdFXXeELiUYQv+ZHwQ@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Date 4.4.2013 11:27, mateen wrote:
> Hi,
> 
> I seeing sometimes deadlock issue with dmix when I press CTRL+C.
> 
> Aplay's signal handler calls snd_pcm_close() if an interrupt occurs.
> snd_pcm_close() will internally call  pcm->ops->close() which will fall to
> snd_pcm_dmix_close() in case you are using dmix.
> 
> snd_pcm_dmix_close() will try to acquire the semaphore with
> snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT).
> The same semaphore is acquired in snd_pcm_dmix_sync_area() with
> dmix_down_sem() in case of non-concurrent access.
> 
> If semaphore is acquired in snd_pcm_dmix_sync_area() which is in thread
> context and interrupt comes, which invokes the signal handler which is in
> ISR context, which calls snd_pcm_close() which in turn calls
> snd_pcm_dmix_close() then we see a deadlock since semaphore is not released
> from thread context and ISR is waiting indefinitely on the same semaphore.
> 
> Please suggest a suitable solution for this.

It seems that also other configurations (alsa-lib plugins) have trouble
with the closing from the signal handler - I hit mutex issues with the
PulseAudio plugin, too.

The question is, how we can do a clean path in this case. Looking to the
current alsa-lib code, I would suggest to add the snd_pcm_abort()
function (may be called from the interrupt handler) to notify the
library to not ignore -EINTR return codes from poll() and other i/o ops
and pass it to the caller (application) to finish the normal close sequence.

Opinions?

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
