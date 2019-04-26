From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Will we ever see a low latency/high performance
 PCM api for usb, firewire, avb ?
Date: Fri, 26 Apr 2019 15:35:29 +0200
Message-ID: <654e7253-b677-0805-8fcb-3f82783cfa77@perex.cz>
References: <trinity-467bdb56-fbf5-484d-a3a7-6fb0f9b14eab-1556225642297@3c-app-gmx-bs08>
 <e287f788-82f9-d9e2-0380-d8f66d2b422b@perex.cz>
 <fa3a4950-a0ba-c3fd-5ec7-923a59ee9a78@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10D67F80C41
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2019 15:35:33 +0200 (CEST)
In-Reply-To: <fa3a4950-a0ba-c3fd-5ec7-923a59ee9a78@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Ralf Beck <musical_snake@gmx.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Dne 26. 04. 19 v 14:22 Clemens Ladisch napsal(a):
> Jaroslav Kysela wrote:
>> Any idea to improve the transfer method? The problem with the serial buses is
>> that you have to queue usually more samples to avoid underruns.
> 
> When the ALSA buffer is not mmapped, it is possible to treat the contents of the
> packet buffers as the ring buffer, i.e., to write the sample data directly into
> the packets, ideally even after they have been queued.

1) It is possible to force the synchronization of pointers through ioctl even
in the mmap mode:


https://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_hw.c;h=91370a88c0fdece71c8aef96e83837858a583c9b;hb=HEAD#l1757

In this mode, the driver will know when appl_ptr is updated. I don't see
difference between mmap mode and r/w mode here.

2) The driver can disable the mmap mode and the r/w data transfer operations
can be replaced with own callback.


I just don't think that the mmap transfer mode is the culprit of the problems.
The problem is that the PCI cards off-loads the DMA transfers completely
without the extra framing required for those serial hardware interfaces which
are handled in the audio driver and the other kernel stacks (USB etc.).

Anyway, the driver must queue the data timely, so it might be also possible to
use fine grained timer to check the data availability (appl_ptr moves) from
the application ahead (like in the interrupt each 1/2 or 1/4 period time). But
as I wrote, it's not a problem to track the appl_ptr moves using the special
ioctl, too.


						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
