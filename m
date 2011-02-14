From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Mon, 14 Feb 2011 18:33:50 -0500
Message-ID: <8CD9AB6C4E69A1D-1448-84EE@web-mmc-d04.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com><CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com>
	<8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-ma06.mx.aol.com (imr-ma06.mx.aol.com [64.12.78.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F03924543
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 00:34:08 +0100 (CET)
Received: from imo-ma04.mx.aol.com (imo-ma04.mx.aol.com [64.12.78.139])
	by imr-ma06.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1ENY51w004119
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 18:34:05 -0500
Received: from ylin@mail.com
	by imo-ma04.mx.aol.com  (mail_out_v42.9.) id 5.1016.78bcbb1 (43964)
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 18:34:01 -0500 (EST)
In-Reply-To: <8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
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

Some update:
We peeked into the substream->dma_buffer.area, and found out the 
channels are already switched in DMA buffer.  We are looking into 
McBSP2 and DMA to find some clues, but not familiar in these areas.  
Any suggestion how to further narrow down the problem?

Thanks,
Ying
