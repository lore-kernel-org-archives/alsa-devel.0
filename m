From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Fri, 25 Feb 2011 10:32:11 -0500
Message-ID: <8CDA3184E0F0520-4AC-24D6@web-mmc-d01.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com><4D5D0A0E.5030505@nokia.com>	<8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com><8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com><4D636574.9050501@nokia.com>
	<8CDA1851D39EA53-3E0-7A27@web-mmc-d01.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-da02.mx.aol.com (imr-da02.mx.aol.com [205.188.105.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E2C8244DC
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 16:32:41 +0100 (CET)
Received: from imo-ma03.mx.aol.com (imo-ma03.mx.aol.com [64.12.78.138])
	by imr-da02.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1PFWYBY027812
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 10:32:34 -0500
Received: from ylin@mail.com
	by imo-ma03.mx.aol.com  (mail_out_v42.9.) id 5.102c.886d7fb (44630)
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 10:32:25 -0500 (EST)
In-Reply-To: <8CDA1851D39EA53-3E0-7A27@web-mmc-d01.sysops.aol.com>
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


> > I think you need to implement the PRCM compliant interrupt config to
> > check for McBSP underflow/overflow.
>
> I have implemented the interrupt handle for IRQ 17 for receive error
> and underflow/overflow.  However, the devices are running for 2 days
> without channel swapped.  I will keep them running.

Finally, after 4 days, we caught the problem again.  When channel is 
swapped, the IRQ is trigger with receive underrun (IRQ_STATUS_REG = 
0x171e).  And, from the status register, the transmit is overflow as 
well.  However, I didn't fill zero to one of the transmit channel, and 
couldn't tell if the playback is swap as well.  Any idea why underun 
happens, or any suggestion to fix it?

Thanks,
Ying
