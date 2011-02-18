From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Channel swapping problem on Atmel SSC audio
Date: Fri, 18 Feb 2011 09:06:13 +0200
Message-ID: <4D5E1A65.40500@nokia.com>
References: <1297950320.7194.57.camel@alice.bigman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE812414A
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 08:06:17 +0100 (CET)
In-Reply-To: <1297950320.7194.57.camel@alice.bigman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jason Fox <jfox@gai-tronics.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 02/17/11 15:45, ext Jason Fox wrote:
> This appears to work, or at least makes the problem much more rare. I'm
> trying to understand if the problem is a silicon bug in the AT91
> hardware, or if the DMA start code in the Atmel SoC driver is buggy.

I'm not familiar with the Atmel platform, but we have had similar
channel swap/shift problems (random channel swap at stream start) in
OMAP3 McBSP.
In our case it was due to the fact, that OMAP3 McBSP has two bits to
actually enable the digital interface.
The early code enabled this two bit at the same time, and that was the
root of the problem.
This is what happened:
- DMA has been configured, and started (HW synchronized DMA, McBSP
  requests the DMA to push data)
- McBSP got enabled, and got released at the same time
McBSP immediately signaled the DMA to push data.
Depending on the timing, there were cases, when McBSP started to send
out the data, while the DMA has not pushed anything to McBSP FIFO.
So the first word was 0, and the second was the first word from the
sample -> channels swapped.
This has happened in McBSP slave configuration as well: depending on the
timing of the McBSP start we have seen random channel swap.
If the McBSP was enabled just right before the start condition on the
I2S bus, it sent out 0 for the first word, and than the audio data ->
channel swapped.
We have fixed this by first enabling the McBSP, but keeping it
unreleased state. When McBSP is enabled, it will trigger DMA to start
pushing data, so we have valid audio data in the FIFO.
We wait for 500us.
We release the McBSP. At this point it will either start listening for
the start condition on I2S bus (slave), or start the clocks on the bus.
Since we already had the valid audio data in the FIFO, the channel swap
has gone.

I suppose you also have similar issue.
Other solution which we considered could have been used only in case of
16bit/stereo audio:
Configure McBSP for 32bit word length (and single slot) in case of
16bit/streo audio. When the race happens McBSP would have sent 0 for
both channels, so we would not have the channels swapped. But this will
only work with 16bit/stereo mode - and mono as well ;)

So we sticked with the former solution.

I hope this helps for you to figure out something similar for your problem.

-- =

P=E9ter
