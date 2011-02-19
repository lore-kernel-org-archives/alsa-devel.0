From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Sat, 19 Feb 2011 11:17:03 -0500
Message-ID: <8CD9E6793CEB053-126C-1161B@web-mmc-d04.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>
	<4D5B7AB5.201@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-db02.mx.aol.com (imr-db02.mx.aol.com [205.188.91.96])
	by alsa0.perex.cz (Postfix) with ESMTP id D6BBC24625
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 17:17:17 +0100 (CET)
Received: from imo-ma04.mx.aol.com (imo-ma04.mx.aol.com [64.12.78.139])
	by imr-db02.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1JGHA5S025185
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 11:17:10 -0500
Received: from ylin@mail.com
	by imo-ma04.mx.aol.com  (mail_out_v42.9.) id 5.ce4.79a578c9 (45303)
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 11:17:09 -0500 (EST)
In-Reply-To: <4D5B7AB5.201@nokia.com>
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


> > It is in threshold mode, with max threshold 1023.  I will try other
> > modes.
>
> This sounds safe, give the fact that the McBSP2 FIFO is 1280 word 
long.
> The McBSP FIFO configuration has been corrected in newer kernels.
>
> One thing that I would try is to synchronize the McBSP2 FIFO
> configuration with the period size you use:
> 48KHz/stereo/16bit 10ms = 480 samples,
> so configure the McBSP2 FIFO to 960 (for both tx, and rx threshold).
> Might not help, but it worth a try...

I checked the threshold registers, both are 960 (959 to be precious).  
It is a safe value, but the channel is switched with 960.  In addition, 
we have tested with sample rate at 16kHz and still have the problem.

Thanks,
Ying
