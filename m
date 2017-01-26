From: Anoop Rajan <anoopmannil@gmail.com>
Subject: Re: Alsa-lib Dmix issue
Date: Thu, 26 Jan 2017 13:46:20 +0530
Message-ID: <CACmL+LDz+j=id=aJh+G6aSHCBqEsVf8gmEsBKmWLmRSgoUfCew@mail.gmail.com>
References: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
 <1aeb13c4-e84e-dc51-d596-51898a16a5d1@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D8D21265A82
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 09:16:26 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id w144so17528102oiw.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 00:16:26 -0800 (PST)
In-Reply-To: <1aeb13c4-e84e-dc51-d596-51898a16a5d1@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, ajith karnik <ajithskarnik@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thanks Clemens for the response.

Can you please help me understand where can be the issue in driver? Aplay
-M works fine, only Dmix doesnt work. As I explained, I can see that kernel
is not getting DMA interrupts because DMA has not initiated yet,as kernel
doesn't have any data in its ring buffer, application pointer is zero. With
these observations I assume the issue is in Dmix, it is not incrementing
the appl pointer. Correct me If I am wrong.

If I hack the dmix code(pcm_dmix.c) by incrementing the application
pointer(dmix->spcm->private_data->sync_ptr->c.control.appl_ptr) after
mixing by number of frames written explicitly , it works. But I strongly
believe this is not the fix and I am yet to figure out the actual issue.

Regards,
Anoop



On Thu, Jan 26, 2017 at 1:22 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Anoop Rajan wrote:
> >  I am trying to play a song  using dmix plugin using AlsaLib(1.0.29) , My
> > kernel (Linux 3.8)hangs at poll() on snd timer interface.When I debugged
> > further, I understood that poll hangs because of DMA interrupt
> > (snd_pcm_period_elapsed)not been received.
>
> This sounds like a bug in the driver.
>
>
> Regards,
> Clemens
>
