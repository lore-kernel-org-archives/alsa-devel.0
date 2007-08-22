From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Wed, 22 Aug 2007 09:28:31 -0500
Message-ID: <46CC480F.7090604@freescale.com>
References: <46CB2BB4.9060808@freescale.com> <s5hbqd0j5c6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 63AB01038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 16:28:36 +0200 (CEST)
In-Reply-To: <s5hbqd0j5c6.wl%tiwai@suse.de>
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

>> 3) Can I assume that .hw_params() is never called after .prepare() is called?
> 
> The call is allowed.

Ugh, so in other words, .hw_params() and .prepare() can be called any number 
of times in any order?  That makes it impossible to optimize the creation of 
the DMA buffer.  Currently, I have this code at the top of my .hwparams() 
function:

	if (substream->dma_buffer.addr) {
		dma_free_coherent(substream->pcm->dev,
			runtime_data->ld_buf_size, runtime_data->link,
			runtime_data->ld_buf_phys);
		snd_dma_free_pages(&substream->dma_buffer);
	}


When I look at the AT91 ASOC driver as an example, I see it allocates a DMA 
buffer of the maximum allowed size (currently hard-coded to 32KB) in the .new 
function.  To me, this is cheating, but it appears to be the only way to avoid 
doing what I'm currently doing.  Is this the recommend approach?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
