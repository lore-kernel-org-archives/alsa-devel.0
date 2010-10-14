From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 14:06:41 +0200
Message-ID: <20101014120641.GM10432@buzzloop.caiaq.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141301.52856.julian@jusst.de>
	<20101014111612.GJ10432@buzzloop.caiaq.de>
	<201010141332.37735.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A786D103B56
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 14:06:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201010141332.37735.julian@jusst.de>
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

On Thu, Oct 14, 2010 at 01:32:37PM +0200, Julian Scheel wrote:
> Am Donnerstag, 14. Oktober 2010, 13:16:12 schrieb Daniel Mack:
> > The dump doesn't show whether the LRCLK is symmetrical, iow, whether the
> > low phase of LRCLK has the same number of BCLK cycles as the high phase.
> > 
> > But if that's the case, the signals do indeed look alright. Maybe you
> > need the configure the codec to this format?
> 
> LRCLK is symmetrical. I use the modules from twistedpearaudio 
> (http://www.twistedpearaudio.com/digital/metronome.aspx, 
> http://www.twistedpearaudio.com/digital/cod.aspx) because this saved me some 
> time designing a PCB for now...
> They are configured through DIP switches - and I think correctly. For the SRC 
> the settings are:
> OWL0,1,2: 0, 0, 0 
> OFMT0,1: 1, 0
> MODE0,1,2: 1, 0, 0
> IFMT0,1,2: 1, 0, 0
> BYPASS: 0
> LGRP: 0
> 
> What I am actually wondering about is, that the SRC produces some output even 
> when the input is null. Attached is a picture of this case. I did not measure 
> the BCLK this time.

Yes, that looks suspicious, especially because it doesn't only affect
the lower bits. What do you need this sample rate converter for, anyway?
Can't you feed your signals directly to the DAC? FMT0 and FMT1 should
both be set to 0.

Daniel
