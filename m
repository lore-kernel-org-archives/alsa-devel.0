From: Rick Bronson <rick@efn.org>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 11:00:52 -0700
Message-ID: <E1Mqsce-0002nt-OD@amazonia.comcast.net>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 3197F243B8
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 20:00:54 +0200 (CEST)
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

Mark,

> This suggests that the DMA isn't happening which usually means that the
> CPU isn't seeing all the clocks it's supposed to.  I'm not familiar
> enough with the OMAP internals to know if you've set the CPU up
> properly.

  I've poured over the relavent code for this and am pretty sure I
don't need to touch it.  The same code works on the beagleboard, at
least the DMA part.  But you never know...

> >   I get no audio output, other than a "click" when the 8731 is
> > initialized upon boot.  When I look at the signals the McBSP2_DX line
> > just goes low for the duration of the "aplay", it does not toggle. The
> > other lines look fine.  The file is at
> 
> If you try a record then does the ADCDAT line show a signal?

  I tried this and the ADCDAT does show a signal.  See
http://www.efn.org/~rick/pub/win10586.jpg  The bottom five traces are
as follows:

McBSP2_CLKX -> I2S_CLK -> I2S_BCLK -> BCLK */\
McBSP2_FSX -> I2S_FRM -> LRCLK -> DACLRC and ADCLRC*/\
McBSP2_DR <- I2S_RXD <- ACDDAT */\
McBSP_CLKS <- I2S_MCLK <- CLKOUT */\
McBSP2_DX -> I2S_TXD -> DACDAT */\

  BTW, when I do a aplay, the trace looks the same except ACDDAT is
low.

  I still get a write error though:

beagle:~# arecord -t wav -f cd -d 1500 dar.wav                                  
Recording WAVE 'dar.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo   
arecord: pcm_read:1348: read error: Input/output error                          

  Rick
