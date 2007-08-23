From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Thu, 23 Aug 2007 13:43:40 -0500
Message-ID: <46CDD55C.5040301@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>	<s5h3aybipj1.wl%tiwai@suse.de>	<46CC4FF3.6090607@freescale.com>	<s5hy7g3h948.wl%tiwai@suse.de>	<46CC5ADC.4020605@freescale.com>	<s5hsl6bh89y.wl%tiwai@suse.de>	<46CDC5AB.6080602@freescale.com>
	<s5htzqq5ev4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 342D72434D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 20:43:48 +0200 (CEST)
In-Reply-To: <s5htzqq5ev4.wl%tiwai@suse.de>
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

> Err, usually, application = user-space application.  Do you mean
> really this?

Yes.  The application allocates a buffer, locks it down, and passes it to the 
kernel.  Since the buffer was allocated in user space, it is virtual 
contiguous but not physically contiguous, hence the need for a list of 
physical addresses.  To the hardware, the buffer appears as a collection of 
scattered buffers.  Hence, scatter/gather.

Like I said, I haven't look at the ALSA API for S/G, so I may be talking about 
an implementation of S/G that does not apply to ALSA.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
