From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Tue, 15 Feb 2011 11:23:55 -0500
Message-ID: <8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>
	<4D5A2466.2060705@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-ma02.mx.aol.com (imr-ma02.mx.aol.com [64.12.206.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 775A0103803
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 17:24:28 +0100 (CET)
Received: from imo-da01.mx.aol.com (imo-da01.mx.aol.com [205.188.169.199])
	by imr-ma02.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1FGOAiC026848
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 11:24:10 -0500
Received: from ylin@mail.com
	by imo-da01.mx.aol.com  (mail_out_v42.9.) id 5.d3a.5f4a5f3a (43906)
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 11:24:04 -0500 (EST)
In-Reply-To: <4D5A2466.2060705@nokia.com>
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


> I forgot to ask:
> what mode you are using the McBSP?
> Is it in element, or threshold mode?
> You can check/change the McBSP mode in:
> /sys/devices/platform/omap-mcbsp.2/dma_op_mode

It is in threshold mode, with max threshold 1023.  I will try other 
modes.

> > For playing, the left and right are the same data, we could not 
tell if
> > the channel switch happens to playback as well.
>
> I see. Is there a way for you to run your application to capture only,
> and from a separate app (aplay?) play a sample, which has audio only 
on
> one channel?

I can fill zero to one of the play channel in our app to test it.

Thanks,
Ying
