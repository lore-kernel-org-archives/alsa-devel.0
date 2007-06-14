From: Timur Tabi <timur@freescale.com>
Subject: Difference between substream->dma_buffer and
	substream->runtime->dma_buffer_p?
Date: Thu, 14 Jun 2007 17:47:58 -0500
Message-ID: <4671C59E.70407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id B42AD247D1
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 00:48:06 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l5EMlw2d023814
	for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2007 15:48:03 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5EMlwS9024394
	for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2007 17:47:58 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The snd_pcm_substream structure has a snd_dma_buffer structure.  snd_dma_buffer looks like 
this:

struct snd_dma_buffer {
	struct snd_dma_device dev;	/* device type */
	unsigned char *area;	/* virtual pointer */
	dma_addr_t addr;	/* physical address */
	size_t bytes;		/* buffer size in bytes */
	void *private_data;	/* private for allocator; don't touch */
};

snd_pcm_substream also has a snd_pcm_runtime structure, which looks like this:

struct snd_pcm_runtime {
...

	/* -- DMA -- */
	unsigned char *dma_area;	/* DMA area */
	dma_addr_t dma_addr;		/* physical bus address (not accessible from main CPU) */
	size_t dma_bytes;		/* size of DMA area */

	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */


Why the redundancy?  Not only does snd_pcm_runtime have dma_area, dma_addr, and dma_bytes, 
but it also has a pointer to a dns_dma_buffer structure, which also has this information!

So given a snd_pcm_substream structure, you can obtain the physical address of the DMA 
buffer three ways:

substream->dma_buffer.addr
substream->runtime->dma_addr
substream->runtime->dma_buffer_p->addr

When will these three variable contain different values?  If the answer is never, then why 
do they all exist?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
