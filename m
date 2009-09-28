From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Mon, 28 Sep 2009 09:07:26 -0700
Message-ID: <E1MsIl4-0002uL-5A@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 04CB2244FF
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 18:07:29 +0200 (CEST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

  Thanks for the help.

  I don't believe it's possible for me to try the master/slave switch.
Please take a look at http://www.efn.org/~rick/pub/wm8731.jpg Note
that DACLRC and ADCLRC are connected.  This requires me to run as
slave, right?  Our bit clock line is buffered so I don't think that
will be a problem.

  Rick

> >   Yes, I had tried 8 before and just tried it now.  Same result.  It
> > really seems like there is a DMA issue.  Can you think of anything
> > else to try before I dive into the DMA code?
> >
> Ok, that wasn't the reason.
> 
> Have you tried to reverse roles of codec and omap? I.e. by using
> the codec as a master and omap as a slave with SND_SOC_DAIFMT_CBM_CFM.
> 
> I don't think there is any HW reason as you have seen the bit-clock and
> frame sync signals toggling but I remember one case few years back
> where codec had slight too high capacitive load on the bit-clock line.
> That was then causing unstable frame sync as it was internally derived
> directly from the bit-clock pin without any buffer. Bit-clock signal
> looked just fine on oscilloscope but wasn't well enough for internal
> circuits of the cpu.
> 
> So if assuming similar problem here, I could imagine that if the FSX is
> used similar way directly inside the omap and if signal is not well
> enough, the McBSP and DMA may not be running.
> 
> This migh be a bit far reason to look for but at least easy to try by
> switching the roles as then the codec is driving the both bit-clock and
> fs.
> 
> 
