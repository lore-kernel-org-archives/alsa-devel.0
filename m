From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for
 non-coherent architectures
Date: Fri, 15 Jan 2010 17:50:49 +1100
Message-ID: <1263538249.724.405.camel@pasglop>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
	<20100101193130.GA21510@rhlx01.hs-esslingen.de>
	<s5haawj7qlv.wl%tiwai@suse.de> <s5hljg24bl7.wl%tiwai@suse.de>
	<1263526082.724.395.camel@pasglop>  <s5hvdf3lvfi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id DCDFC10380E
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 07:51:01 +0100 (CET)
In-Reply-To: <s5hvdf3lvfi.wl%tiwai@suse.de>
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
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Becky Bruce <beckyb@kernel.crashing.org>, Wu Zhangjin <wuzhangjin@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Andreas Mohr <andi@lisas.de>, Kumar Gala <galak@gate.crashing.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-01-15 at 07:43 +0100, Takashi Iwai wrote:
> 
> > It -might- be worth looking at adding code to the USB stack to
> propagate
> > the parent device dma_ops down to USB devices... hard to tell.
> 
> Or we may simply need to drop the mmap support on such
> architectures...

Nah, that would suck since that includes x86 nowadays :-)

I think you probably need to separate the struct device * used for DMA
(it could be default be the same as the "main" struct device tho or it
could default to NULL which means no mmap support).

USB could (if not already) provide an accessor to obtain the HC's struct
device for such mappings. We'll have to discuss that with Alan Stern I
suppose.

The USB Audio or similar drivers could then use that accessors to fill
up Alsa's dma_device field to replace the "default".

Cheers,
Ben.
