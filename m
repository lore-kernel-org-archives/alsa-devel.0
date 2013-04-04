From: mateen <abdulmateen.shaikh@gmail.com>
Subject: Deadlock over semaphore issue with aplay while using
	dmix
Date: Thu, 4 Apr 2013 14:57:39 +0530
Message-ID: <CADryByGnyH9rUDBuG_JRPrSgCb3LPwhaVdFXXeELiUYQv+ZHwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f171.google.com (mail-ve0-f171.google.com
 [209.85.128.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 00BB4265E12
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 11:27:40 +0200 (CEST)
Received: by mail-ve0-f171.google.com with SMTP id b10so2439961vea.2
 for <alsa-devel@alsa-project.org>; Thu, 04 Apr 2013 02:27:40 -0700 (PDT)
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

Hi,

I seeing sometimes deadlock issue with dmix when I press CTRL+C.

Aplay's signal handler calls snd_pcm_close() if an interrupt occurs.
snd_pcm_close() will internally call  pcm->ops->close() which will fall to
snd_pcm_dmix_close() in case you are using dmix.

snd_pcm_dmix_close() will try to acquire the semaphore with
snd_pcm_direct_semaphore_down(dmix, DIRECT_IPC_SEM_CLIENT).
The same semaphore is acquired in snd_pcm_dmix_sync_area() with
dmix_down_sem() in case of non-concurrent access.

If semaphore is acquired in snd_pcm_dmix_sync_area() which is in thread
context and interrupt comes, which invokes the signal handler which is in
ISR context, which calls snd_pcm_close() which in turn calls
snd_pcm_dmix_close() then we see a deadlock since semaphore is not released
from thread context and ISR is waiting indefinitely on the same semaphore.

Please suggest a suitable solution for this.

-- 
Regards,
Shaikh Mateen S.
09423350444
