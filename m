From: Timur Tabi <timur@freescale.com>
Subject: Re: ALSA vs. non coherent DMA
Date: Wed, 07 May 2008 09:22:06 -0500
Message-ID: <4821BB0E.80000@freescale.com>
References: <1210032508.21644.129.camel@pasglop> <s5hmyn3d7d5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 18BB1246A5
	for <alsa-devel@alsa-project.org>;
	Wed,  7 May 2008 16:22:14 +0200 (CEST)
In-Reply-To: <s5hmyn3d7d5.wl%tiwai@suse.de>
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
Cc: benh@kernel.crashing.org, alsa-devel@alsa-project.org, Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> This is a mmap of the data record to be shared in realtime with apps.
> The app updates its data pointer (appl_ptr) on the mmapped buffer
> while the driver updates the data (e.g. DMA position, called hwptr) on
> the fly on the mmapped record.  Due to its real-time nature, it has to
> be coherent -- at least, it was a problem on ARM.

This doesn't sound like a coherency problem to me, and least not one you'd find
on PowerPC.  Both the driver and the application run on the host CPU, so there
shouldn't be any coherency problem.  My understanding is that a "non coherent"
platform is one where the host CPU isn't aware when a *hardware device* writes
directly to memory, e.g. via DMA.

-- 
Timur Tabi
Linux kernel developer at Freescale
