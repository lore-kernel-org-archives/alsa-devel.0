From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Wed, 22 Aug 2007 10:02:11 -0500
Message-ID: <46CC4FF3.6090607@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>
	<s5h3aybipj1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id C5CCE1038E0
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 17:02:16 +0200 (CEST)
In-Reply-To: <s5h3aybipj1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Alternatively, you can remember the last allocated buffer-size and
> re-use the same buffer if the requested size is less than it.
> Since the buffer size change won't happen _so often_ (even via OSS
> emulation), this would work well in practice, too.

Hmm... Neither of these options is really that great.  I think I like the idea 
of pre-allocating the buffer in .new.  What is a reasonable maximum size for 
the DMA buffer?  32KB seems small to me.  When I was testing OSS emulation, 
the first call to .hw_params passed a DMA buffer size of over 1MB!

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
