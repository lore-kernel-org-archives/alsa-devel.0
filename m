From: Anoop Rajan <anoopmannil@gmail.com>
Subject: Re: Alsa-lib Dmix issue
Date: Thu, 26 Jan 2017 19:09:38 +0530
Message-ID: <CACmL+LCwW4NjsxMn10-iR0bn_UXsJ1=YhzadSEZoqpPsnEu=Jg@mail.gmail.com>
References: <CACmL+LCqwU8A8uq+Z=wFSazTCSMsKoRm0U+w7airoza240aHVQ@mail.gmail.com>
 <1aeb13c4-e84e-dc51-d596-51898a16a5d1@ladisch.de>
 <CACmL+LDz+j=id=aJh+G6aSHCBqEsVf8gmEsBKmWLmRSgoUfCew@mail.gmail.com>
 <946f3a49-e014-8119-acd7-d17750779465@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EE19D2666F2
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 14:39:39 +0100 (CET)
Received: by mail-oi0-f67.google.com with SMTP id x84so18256144oix.2
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 05:39:39 -0800 (PST)
In-Reply-To: <946f3a49-e014-8119-acd7-d17750779465@ladisch.de>
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

Hello Clemens,

>When there are multiple clients, there are multiple appl pointers.
>So the dmix plugin does not bother to tell the hardware about any
>of them.
Thanks,Understood.


>Are you using a driver that lokos at appl_ptr?
We are working on Marvell chipset,88DE3006. Looks like our driver looks at
appl_pointer though I am not sure how to confirm it. I see the appl_pointer
coming through SNDRV_PCM_IOCTL_SYNC_PTR is always incremented in case of
aplay -M and it works, if we don't increment appl_ptr it doesn't works,

So for dmix to work, I should have the driver that doesn't looks at
appl_ptr, right? f appl_pointer should never be incremented, how will the
kernel know the data is written? The MMAP to status/control is not
implemented in our case.  I would start looking to change my driver not to
look at appl_ptr, would you please help me with some pointers to understand
how/where in drivers should I typically change to adapt these changes?

Regards,
Anoop




On Thu, Jan 26, 2017 at 5:33 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Anoop Rajan wrote:
> > I assume the issue is in Dmix, it is not incrementing the appl pointer.
>
> When there are multiple clients, there are multiple appl pointers.
> So the dmix plugin does not bother to tell the hardware about any
> of them.
>
> Are you using a driver that lokos at appl_ptr?
>
>
> Regards,
> Clemens
>
