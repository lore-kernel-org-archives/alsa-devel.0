From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 14:30:43 +0200
Message-ID: <201010141430.43967.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141332.37735.julian@jusst.de>
	<20101014120641.GM10432@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 67B8624141
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 14:30:47 +0200 (CEST)
In-Reply-To: <20101014120641.GM10432@buzzloop.caiaq.de>
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
Cc: lee188@singnet.com.sg
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 14:06:41 schrieb Daniel Mack:
> On Thu, Oct 14, 2010 at 01:32:37PM +0200, Julian Scheel wrote:
> > Am Donnerstag, 14. Oktober 2010, 13:16:12 schrieb Daniel Mack:
> > > The dump doesn't show whether the LRCLK is symmetrical, iow, whether
> > > the low phase of LRCLK has the same number of BCLK cycles as the high
> > > phase.
> > > 
> > > But if that's the case, the signals do indeed look alright. Maybe you
> > > need the configure the codec to this format?
> > 
> > LRCLK is symmetrical. I use the modules from twistedpearaudio
> > (http://www.twistedpearaudio.com/digital/metronome.aspx,
> > http://www.twistedpearaudio.com/digital/cod.aspx) because this saved me
> > some time designing a PCB for now...
> > They are configured through DIP switches - and I think correctly. For the
> > SRC the settings are:
> > OWL0,1,2: 0, 0, 0
> > OFMT0,1: 1, 0
> > MODE0,1,2: 1, 0, 0
> > IFMT0,1,2: 1, 0, 0
> > BYPASS: 0
> > LGRP: 0
> > 
> > What I am actually wondering about is, that the SRC produces some output
> > even when the input is null. Attached is a picture of this case. I did
> > not measure the BCLK this time.
> 
> Yes, that looks suspicious, especially because it doesn't only affect
> the lower bits. What do you need this sample rate converter for, anyway?
> Can't you feed your signals directly to the DAC? FMT0 and FMT1 should
> both be set to 0.

You mean OFMT0 and OFMT1? Imho they should be 1,0 for I2S. Or did you refer to 
the DAC? In that case FMT0 and FMT1 both are set to 0.

Julian
