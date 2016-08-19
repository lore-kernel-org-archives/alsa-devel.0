From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Subject: Use of copy_to_user in fireworks_hwdep.c while holding a spin_lock
Date: Fri, 19 Aug 2016 11:36:12 +0530
Message-ID: <57B6A1D4.2080501@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

Hello,

I was wondering about the call to copy_to_user in function hwdep_read_locked and
hwdep_read_resp_buf for driver sound/firewire/fireworks/fireworks_hwdep.c. 
The function hwdep_read calls both of these functions while holding a spinlock[1],
which is not normally allowed due to the possibility of a deadlock.

This seems to be coming from the commit 555e8a8f7f149544eb7d4aa3a6420bc4c3055638
while adding a command/response functionality into hwdep interface. Is there some
reason that I am overlooking, why it is OK in this case? Is there some code in the
same file which ensures that page fault will not occur when we are calling these
functions while holding a spin_lock_irq?

The same issue is there with the driver sound/firewire/tascam/tascam-hwdep.c for
obvious reasons.

Coccinelle script is used to detect this issue.

Thank you.

[1] http://lxr.free-electrons.com/source/sound/firewire/fireworks/fireworks_hwdep.c#L114

-- 
Vaishali
