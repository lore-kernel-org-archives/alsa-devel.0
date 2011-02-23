From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Wed, 23 Feb 2011 10:26:02 -0500
Message-ID: <8CDA1851D39EA53-3E0-7A27@web-mmc-d01.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com><4D5D0A0E.5030505@nokia.com>	<8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com><8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com>
	<4D636574.9050501@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-da04.mx.aol.com (imr-da04.mx.aol.com [205.188.105.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E096245B8
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 16:26:22 +0100 (CET)
Received: from imo-ma02.mx.aol.com (imo-ma02.mx.aol.com [64.12.78.137])
	by imr-da04.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1NFQK8Z031106
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 10:26:20 -0500
Received: from ylin@mail.com
	by imo-ma02.mx.aol.com  (mail_out_v42.9.) id 5.f82.9da7f4f (37566)
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 10:26:16 -0500 (EST)
In-Reply-To: <4D636574.9050501@nokia.com>
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

> I think you need to implement the PRCM compliant interrupt config to
> check for McBSP underflow/overflow.

I have implemented the interrupt handle for IRQ 17 for receive error 
and underflow/overflow.  However, the devices are running for 2 days 
without channel swapped.  I will keep them running.

> I'll try to resurrect my Beagle board, since that as well have the twl
> codec on McBSP2...

I will test it on EVM board as well.

We have tested the element mode for dma_op_mode.  It works fine, we 
don't see any channel swapping in this mode.

Thanks,
Ying
