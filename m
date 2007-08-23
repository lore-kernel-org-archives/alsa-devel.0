From: Timur Tabi <timur@freescale.com>
Subject: Re: hw_params function and OSS emulation
Date: Thu, 23 Aug 2007 12:36:43 -0500
Message-ID: <46CDC5AB.6080602@freescale.com>
References: <46CB2BB4.9060808@freescale.com>	<s5hbqd0j5c6.wl%tiwai@suse.de>	<46CC480F.7090604@freescale.com>	<s5h3aybipj1.wl%tiwai@suse.de>	<46CC4FF3.6090607@freescale.com>	<s5hy7g3h948.wl%tiwai@suse.de>	<46CC5ADC.4020605@freescale.com>
	<s5hsl6bh89y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id C9F191038CA
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 19:36:48 +0200 (CEST)
In-Reply-To: <s5hsl6bh89y.wl%tiwai@suse.de>
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

>> On a side note, I notice that ALSA has some scatter-gather support.  If an 
>> application uses S/G, I presume the concept of a DMA buffer size doesn't even 
>> apply?
> 
> The SG-buffer isn't for applications but for drivers.  From the
> application viewpoint, the buffer looks linear.

Yes, but in SG, the application allocates the DMA buffer, and a list of 
physical addresses is passed to the driver.  Normally, the driver allocates 
the DMA buffer and passes a virtual address to the app.  Therefore, the DMA 
buffer processing for SG is completely different than for driver-allocated 
buffers, including the concept of a DMA buffer length.

For normal DMA buffers, I would specify a limit of 64KB just because of the 
problems with multiple calls to .hw_params() and .prepare().  I could support 
much larger DMA buffers, but not with the way ALSA calls the driver.

For SG, I haven't looked at the API, but I assume that the ALSA gives a list 
of physical addresses to the driver only *once*.  In this case, my DMA buffer 
limitations are much larger, since I just give the list of addresses to my 
hardware and it does the rest.  So I would hope that the application *doesn't* 
use the DMA buffer size limit in my snd_pcm_hardware structure.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
