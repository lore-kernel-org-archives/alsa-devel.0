From: Alex <lee188@singnet.com.sg>
Subject: Re: SoC Atmel SSC stereo problem
Date: Sat, 23 Oct 2010 04:10:22 +0000 (UTC)
Message-ID: <loom.20101023T054800-433@post.gmane.org>
References: <4CC1AB01.3020603@fh-kl.de> <4CC1B7CD.3030703@ladisch.de>
	<4CC20475.3020900@fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7177A1037F3
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 06:10:34 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P9VRB-0002gS-JG
	for alsa-devel@alsa-project.org; Sat, 23 Oct 2010 06:10:33 +0200
Received: from 220.255.7.137 ([220.255.7.137])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 06:10:33 +0200
Received: from lee188 by 220.255.7.137 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 23 Oct 2010 06:10:33 +0200
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

Patrick Ziegler <patrick.ziegler <at> fh-kl.de> writes:

> The SSC is connected to a FPGA that assigns the bus to different devices 
> depending on the application. And for all applications the FPGA 
> generates the clocks. Maybe this is not the best solution but I will try 
> to deal with this limitation first before I try to persuade other people 
> to change it.
> 

Hi Patrick,

It looks like you are running the SSC TX in slave mode, with both the SCLK (the 
i2S clock) and LRCK provided by your FPGA.  It is trickier to prevent channel 
inversion in this mode.

One possible approach is to:

(1)  test for the LRCK level with a gpio pin connected to the LRCK.  This should 
normally be the same pin assigned to TX_FRAME_SYNC.  After any USB set interface 
to the alternate setting for playback of your active device, or after any 
sampling rate change etc., you re-sync the transfer to the correct LRCK edge:

        pdca_disable(PDCA_CHANNEL_SSC_TX);

        // reset the audio buffer pointers to the start of the LEFT channel etc
        // if required

    	// re-sync SSC to LRCK
        // Wait for the next frame synchronization event
        // to avoid channel inversion.  Start with left channel - FS goes low

	while (!gpio_get_pin_value(_LRCK));
	while (gpio_get_pin_value(LRCK));	
        // exit when FS goes low

        // Enable now the transfer.
        pdca_enable(PDCA_CHANNEL_SSC_TX);

(2)  start clocking data out at any LRCK edge after a suitable delay (of 1 
SCLK).  You may need to use LRCK level change rather than any edge depending on 
the hardware timing.  The delay may also need to be adjusted depending on 
hardware timing.

(3)  clock out one sample (either left or right) per LRCK edge (or level).

Of course, if you are running the SSC in master mode, there are easier ways to 
ensure channel synchronization :-)

The above suggestion is extrapolated from my project using the AT32UC3A3 which 
has a similar (more capable) SSC as the AT91.  So it may or may not work for 
you.

Alex
