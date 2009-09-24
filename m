From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 19:52:46 +0100
Message-ID: <20090924185246.GA25783@opensource.wolfsonmicro.com>
References: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
	<E1Mqsce-0002nt-OD@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9727924364
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 20:52:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1Mqsce-0002nt-OD@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 24, 2009 at 11:00:52AM -0700, Rick Bronson wrote:
> Mark,

> > This suggests that the DMA isn't happening which usually means that the
> > CPU isn't seeing all the clocks it's supposed to.  I'm not familiar
> > enough with the OMAP internals to know if you've set the CPU up
> > properly.

>   I've poured over the relavent code for this and am pretty sure I
> don't need to touch it.  The same code works on the beagleboard, at
> least the DMA part.  But you never know...

You shouldn't need to touch the DMA code itself, it's normally an issue
with the clocks and/or the pinmux code not managing to get the signals
required to clock the data transfer.

>   BTW, when I do a aplay, the trace looks the same except ACDDAT is
> low.

Yes, that's what I'd expect - this was just an attempt to confirm that
the CODEC is happy.
