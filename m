From: Daniel Mack <daniel@caiaq.de>
Subject: USB transfer_buffer allocations on 64bit systems
Date: Wed, 7 Apr 2010 11:06:23 +0200
Message-ID: <20100407090623.GN30807@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DF79103891
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 11:06:27 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

Hi,

I was pointed to https://bugzilla.kernel.org/show_bug.cgi?id=15580 by
Pedro Ribeiro, and unfortunately I'm pretty late in the game. I wasn't
aware of that thread until yesterday.

While the report is quite confusing, the reason seams pretty clear to me
as I've been thru quite some time-demanding debugging of a very similar
issue on Mac OS X. But I'm not totally sure whether we really hit the
same issue here, so I'd like to have your opinions first.

The problem is appearantly the way the transfer buffer is allocated in
the drivers. In the snd-usb-caiaq driver, I used kzalloc() to get memory
which works fine on 32bit systems. On x86_64, however, it seems that
kzalloc() hands out memory beyond the 32bit addressable boundary, which
the DMA controller of the 32bit PCI-connected EHCI controller is unable
to write to or read from. Am I correct on this conclusion?

Depending on the condition of the memory management, things might work
or not, and especially right after a reboot, there's a better chance to
get lower memory.

The fix is to use usb_buffer_alloc() for that purpose which ensures
memory that is suitable for DMA. And on x86_64, this also means that the
upper 32 bits of the address returned are all 0's.

If what I've stated is true, there are quite some more drivers affected
by this issue. I collected a list of places where similar fixes are
needed, and I can send patches if I get a thumbs-up.

Pedro is currently testing a patch I sent out yesterday.

Thanks,
Daniel
