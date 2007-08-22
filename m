From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Wed, 22 Aug 2007 10:48:44 -0500
Message-ID: <46CC5ADC.4020605@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>	<s5h3aybipj1.wl%tiwai@suse.de>	<46CC4FF3.6090607@freescale.com>
	<s5hy7g3h948.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 0050D1038DF
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 17:48:48 +0200 (CEST)
In-Reply-To: <s5hy7g3h948.wl%tiwai@suse.de>
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

> The driver should deny a too large size if it's unrealistic.
> But 1MB is realistic for many systems.  So, the number depends on the
> system.

Are there any popular applications that really want a DMA buffer larger than 64KB?

On a side note, I notice that ALSA has some scatter-gather support.  If an 
application uses S/G, I presume the concept of a DMA buffer size doesn't even 
apply?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
