From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 13:16:12 +0200
Message-ID: <20101014111612.GJ10432@buzzloop.caiaq.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141227.38510.julian@jusst.de>
	<20101014104855.GI10432@buzzloop.caiaq.de>
	<201010141301.52856.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 173D224431
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 13:16:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201010141301.52856.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, lee188@singnet.com.sg
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 14, 2010 at 01:01:52PM +0200, Julian Scheel wrote:
> Am Donnerstag, 14. Oktober 2010, 12:48:55 schrieb Daniel Mack:
> > On Thu, Oct 14, 2010 at 12:27:38PM +0200, Julian Scheel wrote:
> > > thanks a lot! You made my day (c:
> > > Using EP5 for feedback makes it working. So I now get the data out even
> > > in async mode. Currently I have a problem left that channel assignment
> > > jumps here and then. Probably a buffering issue...
> > > Also neither a SRC4192  (sample rate converter) nor a PCM1794 (dac) seem
> > > to be able to understand what I am sending right now... Not sure why.
> > > Looking at the measurements it really looks like a proper I2S signal.
> > 
> > Can you send oscilloscope screenshots? Which data format are you using?
> 
> Sure, attached you see a capture while running speaker-test to generate a 1khz 
> sine wave on one channel. (Blue: BCLK 1,536MHz, Yellow: LRCLK: 48kHz, Green: 
> I2S data)
> If you want to see more/other captures just let me know what you need.

The dump doesn't show whether the LRCLK is symmetrical, iow, whether the
low phase of LRCLK has the same number of BCLK cycles as the high phase.

But if that's the case, the signals do indeed look alright. Maybe you
need the configure the codec to this format?

Daniel
