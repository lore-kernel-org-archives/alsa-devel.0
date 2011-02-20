From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sat, 19 Feb 2011 23:01:20 -0500
Message-ID: <8CD9EC9F73F6CCC-DDC-EA8F@web-mmc-d06.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>	<4D5B7AB5.201@nokia.com><8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com><4D5D0A0E.5030505@nokia.com>
	<8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-ma05.mx.aol.com (imr-ma05.mx.aol.com [64.12.100.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 212821037F3
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 05:01:33 +0100 (CET)
Received: from imo-ma04.mx.aol.com (imo-ma04.mx.aol.com [64.12.78.139])
	by imr-ma05.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1K41UdZ026278
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 23:01:30 -0500
Received: from ylin@mail.com
	by imo-ma04.mx.aol.com  (mail_out_v42.9.) id 5.bfa.69148f91 (37096)
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 23:01:25 -0500 (EST)
In-Reply-To: <8CD9E665EC96F93-126C-1145E@web-mmc-d04.sysops.aol.com>
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

> > Or can you share the relevant configuration (from your machine 
driver)
> > with us?

And, these are McBSP2 registers with both Tx and Rx audio running.
**** McBSP2 regs ****
DRR2:  0xffee
DRR1:  0x0000
DXR2:  0x0000
DXR1:  0x0000
SPCR2: 0x02f5
SPCR1: 0x0031
RCR2:  0x8041
RCR1:  0x0040
XCR2:  0x8041
XCR1:  0x0040
SRGR2: 0x001f
SRGR1: 0x0f00
PCR0:  0x000f
***********************

Thanks,
Ying
