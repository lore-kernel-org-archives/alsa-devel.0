From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [bisected] lx6464es fails to open a second time
Date: Tue, 22 Nov 2011 08:42:15 +0100
Message-ID: <4ECB5257.4040600@ladisch.de>
References: <2428359.JOQWRg64O4@moka>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DA41C103964
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 08:42:18 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 62CAB2135E
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 02:42:16 -0500 (EST)
In-Reply-To: <2428359.JOQWRg64O4@moka>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Gerst <brgerst@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Tim Blechmann wrote:
> some time ago, i've been developing the driver for the lx6464es ethersound
> sound card, which has been included into the kernel for some time. however i
> haven't been able to use it in kernels after 2.6.33.
> 
> today, i was able to bisect the issue and the first bad commit is:
> 
> commit 6175ddf06b6172046a329e3abfd9c901a43efd2e
> Author: Brian Gerst <brgerst@gmail.com>
> Date:   Fri Feb 5 09:37:07 2010 -0500
> 
>     x86: Clean up mem*io functions.
> 
> the communication with the device is done by passing simple commands via
> memcpy_fromio and memcpy_toio (compare sound/pci/lx6464es/lx_core.c, lines 75
> to 99). any idea, what is going wrong there?

The old and new implementations of memcpy_*io do not have any differences
in the documented API, but the new ones are much more optimized, so they
might not use 8- or 32-bit accesses or a different access pattern.

Does the card's mapped I/O region behave exactly like memory, or has it
any restrictions on how it can be used?  In the latter case, you should
implement your readbuf/writebuf functions by hand to use plain 32-bit
accesses in order (or whatever is required).


Regards,
Clemens
