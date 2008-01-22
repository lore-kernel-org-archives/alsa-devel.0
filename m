From: James Pearson <james-p@moving-picture.com>
Subject: Re: 1.0.16rc1 release
Date: Tue, 22 Jan 2008 17:15:18 +0000
Message-ID: <479624A6.7040700@moving-picture.com>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>	<47961880.3090309@moving-picture.com>
	<s5h4pd5954z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id A698224412
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 18:15:18 +0100 (CET)
In-Reply-To: <s5h4pd5954z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 22 Jan 2008 16:23:28 +0000,
> James Pearson wrote:
>>
>>It looks like alsa-driver-1.0.16rc1/acore/ioctl32/hwdep32_new.c should 
>>be including "adriver.h" not "driver.h" ??
> 
> 
> Yes, it's a typo.
> 
> 
>>Also, at MODPOST stage:
>>
>>*** Warning: "mutex_destroy" 
>>[/tmp/alsa-driver-1.0.16rc1/pci/oxygen/snd-oxygen-lib.ko] undefined!
> 
> 
> Do you have alsa-driver*/include/mutex.h?

There is no alsa-driver*/include/mutex.h, there is a 
include/linux/mutex.h as part of the kernel - which contains:

/*
  * Copyright (c) 2006 Cisco Systems.  All rights reserved.
  *
  * This file is released under the GPLv2.
  */

/* mutex compatibility for pre-2.6.16 kernels */

#ifndef __LINUX_MUTEX_H
#define __LINUX_MUTEX_H

#include <asm/semaphore.h>

#define mutex semaphore
#define DEFINE_MUTEX(foo) DECLARE_MUTEX(foo)
#define mutex_init(foo) init_MUTEX(foo)
#define mutex_lock(foo) down(foo)
#define mutex_lock_interruptible(foo) down_interruptible(foo)
/* this function follows the spin_trylock() convention, so        *
  * it is negated to the down_trylock() return values! Be careful  */
#define mutex_trylock(foo) !down_trylock(foo)
#define mutex_unlock(foo) up(foo)

#endif /* __LINUX_MUTEX_H */

i.e. it doesn't define mutex_destroy()

> Or, RH has an uncomplete mutex implementation?

Don't know - see above?

>>*** Warning: "do_posix_clock_monotonic_gettime" 
>>[/tmp/alsa-driver-1.0.16rc1/acore/snd-timer.ko] undefined!
>>*** Warning: "do_posix_clock_monotonic_gettime" 
>>[/tmp/alsa-driver-1.0.16rc1/acore/snd-pcm.ko] undefined!
>>
>>I'm not sure why its complaining about do_posix_clock_monotonic_gettime, 
>>as this is there in the 2.6.9 RHEL4 kernel.
> 
> 
> It seems that the function isn't exported.
> 
> The fix patch is below.  Give it a try.

Patch fixed these issues

Thanks

James Pearson
