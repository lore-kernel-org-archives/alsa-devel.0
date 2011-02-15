From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 15 Feb 2011 09:15:44 +0200
Message-ID: <4D5A2820.7060404@nokia.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com><CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
	<8CD9AB6C4E69A1D-1448-84EE@web-mmc-d04.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B8A103847
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 08:15:49 +0100 (CET)
In-Reply-To: <8CD9AB6C4E69A1D-1448-84EE@web-mmc-d04.sysops.aol.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext ylin@mail.com" <ylin@mail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/15/11 01:33, ext ylin@mail.com wrote:
> Some update:
> We peeked into the substream->dma_buffer.area, and found out the =

> channels are already switched in DMA buffer.  We are looking into =

> McBSP2 and DMA to find some clues, but not familiar in these areas.  =

> Any suggestion how to further narrow down the problem?

Few more things:
I suppose the twl4030 is the master on the bus (McBSP slave)
Since you are using stereo capture, I assume the digital interface is in
I2S mode.

I could think of three source for channel switch:
1. The switch happens within the twl4030 codec itself
2. Switch happens because of underflow situation in McBSP
3. Switch happens because of overflow situation in McBSP


To narrow down the problem:
1. You need tracepoints on you board for McBSP2 pins, and a scope
You need to monitor the DX, and FS lines (bitclock might be useful as well).
Keep the right channel disabled, and run your application, observe the
DX/FS on the scope. When you notice the channel swap, check back on the
scope, if the data moved from left to right channel.

2/3. This is a bit more trickier, but I have done this several times:
You need to use the PRCM compliant interrupt configuration.
Do not request the TX/RX (62, 63 for McBSP2) interrupts in
omap_mcbsp_request, but request only the common IRQ (17 for McBSP2).
Enable the ROVFLEN, RUNDFEN, and RSYNCERREN bits in IRQENABLE_REG.
In the ir handler check for these enabled events (in IRQSTATUS_REG), and
print out the reason for the event (Do not forget to write back the
register content to IRQSTATUS_REG to ack the event).

I hope this helps narrowing down the problem.

-- =

P=E9ter
