From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 17:10:01 +0200
Message-ID: <201010141710.02194.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141301.52856.julian@jusst.de>
	<20101014111612.GJ10432@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 34ED0243B9
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 17:10:05 +0200 (CEST)
In-Reply-To: <20101014111612.GJ10432@buzzloop.caiaq.de>
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
Cc: lee188@singnet.com.sg, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 13:16:12 schrieb Daniel Mack:
> > Sure, attached you see a capture while running speaker-test to generate a
> > 1khz sine wave on one channel. (Blue: BCLK 1,536MHz, Yellow: LRCLK:
> > 48kHz, Green: I2S data)
> > If you want to see more/other captures just let me know what you need.
> 
> The dump doesn't show whether the LRCLK is symmetrical, iow, whether the
> low phase of LRCLK has the same number of BCLK cycles as the high phase.
> 
> But if that's the case, the signals do indeed look alright. Maybe you
> need the configure the codec to this format?

Hi,

I did a capture of the same signal, but this time not just a short snap, but a 
whole memory dump of the oscilloscope. I did a plot with gnuplot and uploaded 
it here:
http://jusst.de/files/i2s_plot.png

As it's 0,5MB big I didn't want to send it as attachment...

Would you agree that the data (this time blue channel) is delayed too much? 
Looks like it's at least 2 cycles behind the LRCK toggle.
Would it be possible that this is the reason for the DAC not understanding the 
data?

Regards,
Julian
