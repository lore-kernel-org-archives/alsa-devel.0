From: ylin@mail.com
Subject: Re: Channel swapping issue on TI OMAP3/TWL4030
Date: Wed, 16 Feb 2011 22:40:37 -0500
Message-ID: <8CD9C6B934040FF-13C8-4BFB@web-mmc-d06.sysops.aol.com>
References: <8CD98E75F0E83E2-63C-14642@web-mmc-m05.sysops.aol.com>	<CF32F28EDF8D20468EEDCBE4975DA0274A46DB@008-AM1MPN1-027.mgdnok.nokia.com><8CD9A87EF4FB765-1218-647@web-mmc-m03.sysops.aol.com>	<4D5A2466.2060705@nokia.com><8CD9B43DFD8A17C-DE8-B3DD@web-mmc-d01.sysops.aol.com>
	<4D5B7AB5.201@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imr-ma03.mx.aol.com (imr-ma03.mx.aol.com [64.12.206.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EAC9D2448E
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 04:41:08 +0100 (CET)
Received: from imo-da02.mx.aol.com (imo-da02.mx.aol.com [205.188.169.200])
	by imr-ma03.mx.aol.com (8.14.1/8.14.1) with ESMTP id p1H3epkG028001
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 22:40:51 -0500
Received: from ylin@mail.com
	by imo-da02.mx.aol.com  (mail_out_v42.9.) id 5.edd.107191f2 (44620)
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 22:40:48 -0500 (EST)
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

> >
> >> I forgot to ask:
> >> what mode you are using the McBSP?
> >> Is it in element, or threshold mode?
> >> You can check/change the McBSP mode in:
> >> /sys/devices/platform/omap-mcbsp.2/dma_op_mode
> >
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

We tried element and frame mode, playback doesn't sound correct with 
these mode, but the capture is OK.  We will stick with threshold mode, 
and try the new threshold.

> >>> For playing, the left and right are the same data, we could not
> > tell if
> >>> the channel switch happens to playback as well.
> >>
> >> I see. Is there a way for you to run your application to capture 
only,
> >> and from a separate app (aplay?) play a sample, which has audio 
only
> > on
> >> one channel?
> >
> > I can fill zero to one of the play channel in our app to test it.
>
> Great.
> Let's see, if the swap also happens in the playback path as well.

None of our test shows the playback problem.  I think the playback path 
is fine, but will keep testing.

Also, we have verified the audio data from I2S interface looks fine 
using a scope even when the channels are switched.  We can eliminate 
twl4030 codec from the problem, and focus on McBSP and DMA.  We don't 
have chance to check McBSP overflow/underflow as you suggested yet.

Thanks,
Ying
