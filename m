From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 13:32:37 +0200
Message-ID: <201010141332.37735.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141301.52856.julian@jusst.de>
	<20101014111612.GJ10432@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VputMoxlRhuPrxL"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E6CA0103883
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 13:32:40 +0200 (CEST)
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
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, lee188@singnet.com.sg
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_VputMoxlRhuPrxL
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Am Donnerstag, 14. Oktober 2010, 13:16:12 schrieb Daniel Mack:
> On Thu, Oct 14, 2010 at 01:01:52PM +0200, Julian Scheel wrote:
> > Am Donnerstag, 14. Oktober 2010, 12:48:55 schrieb Daniel Mack:
> > > On Thu, Oct 14, 2010 at 12:27:38PM +0200, Julian Scheel wrote:
> > > > thanks a lot! You made my day (c:
> > > > Using EP5 for feedback makes it working. So I now get the data out
> > > > even in async mode. Currently I have a problem left that channel
> > > > assignment jumps here and then. Probably a buffering issue...
> > > > Also neither a SRC4192  (sample rate converter) nor a PCM1794 (dac)
> > > > seem to be able to understand what I am sending right now... Not
> > > > sure why. Looking at the measurements it really looks like a proper
> > > > I2S signal.
> > > 
> > > Can you send oscilloscope screenshots? Which data format are you using?
> > 
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

LRCLK is symmetrical. I use the modules from twistedpearaudio 
(http://www.twistedpearaudio.com/digital/metronome.aspx, 
http://www.twistedpearaudio.com/digital/cod.aspx) because this saved me some 
time designing a PCB for now...
They are configured through DIP switches - and I think correctly. For the SRC 
the settings are:
OWL0,1,2: 0, 0, 0 
OFMT0,1: 1, 0
MODE0,1,2: 1, 0, 0
IFMT0,1,2: 1, 0, 0
BYPASS: 0
LGRP: 0

What I am actually wondering about is, that the SRC produces some output even 
when the input is null. Attached is a picture of this case. I did not measure 
the BCLK this time.

Regards,
Julian

--Boundary-00=_VputMoxlRhuPrxL
Content-Type: image/png;
  name="srcout_noinput.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="srcout_noinput.png"

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
TkSuQmCC

--Boundary-00=_VputMoxlRhuPrxL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_VputMoxlRhuPrxL--
