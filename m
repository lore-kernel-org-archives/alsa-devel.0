From: Timur Tabi <timur@freescale.com>
Subject: Re: How do I tell ALSA that my driver supports every
 possible	sample rate?
Date: Mon, 23 Jul 2007 12:06:19 -0500
Message-ID: <46A4E00B.1000702@freescale.com>
References: <46A4CF38.3050107@freescale.com>
	<1185208787.4091.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A66B10385A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 19:06:24 +0200 (CEST)
In-Reply-To: <1185208787.4091.21.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
>
> If your lucky enough to have this hardware, I think I would probably set
> the I2S and DMA rates as SNDRV_PCM_RATE_8000_192000.

The problem is that this option only lists a selection of bit rates, and this particular 
macro also skips 5512 Hz.  I'm looking for something that's future-proof.

I was thinking perhaps "(u32) -1", but this also turns on SNDRV_PCM_RATE_KNOT, and don't 
you need to have some kind of callback function for KNOT?

BTW, I'm not sure why you say if I'm lucky enough.  The PCM driver, for instance, is just 
a front-end to the DMA controller.  DMA obviously doesn't care about sample rates, so it 
makes sense that most PCM drivers can handle any rate.  Or am I missing something?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
