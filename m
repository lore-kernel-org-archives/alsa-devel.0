From: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Subject: Use of copy_to_user in fireworks_hwdep.c while holding
	a spin_lock
Date: Fri, 19 Aug 2016 11:54:31 +0530
Message-ID: <57B6A61F.7080700@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A7D265834
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 08:24:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
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
