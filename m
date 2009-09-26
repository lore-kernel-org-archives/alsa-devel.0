From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Sat, 26 Sep 2009 08:59:52 -0700
Message-ID: <E1MrZge-0002DY-0A@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 169501037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Sep 2009 17:59:55 +0200 (CEST)
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

> Yes it is indicating so. I read through this thread I didn't find any
> simple reason why it's not working. Your setup is similar with the
> Pandora, i.e. McBSP functional clock is coming the codec and codec is
> slave.

  Yes, I pretty much used the pandora as an example to write mine.

> The McBSP is operating if the FSX and CLKX are toggling in this setup.
> Is it so that you don't get any DMA interrupts or just few of them?

  I don't get any DMA int's:

~# cat /proc/interrupts                                                  
           CPU0                                                                 
 11:          0        INTC  prcm                                               
 12:          0        INTC  DMA                                                
 25:          0        INTC  dispc                                              
 37:       5003        INTC  gp timer                                           
 56:       3425        INTC  i2c_omap                                           
 62:          0        INTC  McBSP                                              
 63:          0        INTC  McBSP                                              


> Your CLKGDV divisor value 256 means too low bit clock and sample rate
> for both external 12.288 MHz and internal 96 MHz but still the DMA
> should be running (if there is no bug with this divisor value).
> Can you try divisor value 8 does it work then? For 48 kHz sample rate
> with I2S you need a bit clock of 48 kHz*2*16 = 1.536 MHz and this you
> get by dividing the 12.288 MHz with 8.
> 

  Yes, I had tried 8 before and just tried it now.  Same result.  It
really seems like there is a DMA issue.  Can you think of anything
else to try before I dive into the DMA code?

  Rick
