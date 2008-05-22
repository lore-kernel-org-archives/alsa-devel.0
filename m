From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Thu, 22 May 2008 23:48:41 +0100
Message-ID: <20080522224840.GA31117@sirena.org.uk>
References: <200805221120.08815.geoffrey@pager.net>
	<20080522194621.GA12490@sirena.org.uk>
	<200805221457.41748.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EEBD31037F9
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 00:48:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805221457.41748.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 22, 2008 at 02:57:41PM -0500, Geoffrey Wossum wrote:

> Looks like it should work to me.  Note that I do hear a pop from the speaker 
> the first time I try to play a file.  Here's a dump of the registers while 
> I'm trying to play a file with aplay.  I'm combing through them right now to 
> see if I can find anything that looks off.

Yes, it looks like the output paths are OK from the DAPM point of view.

> Wish I had known about this register dump earlier today.  I added code to do 
> the same thing with debugfs.

I'll have a look at it at some point, but not right now :) .  I should
also have asked you if you could post your machine driver - if you'd
rather post it off-list that'd be fine.

> > I'll need to check this out in more detail - the WM8510 is a mono codec
> > so it can only play one channel.

> Not sure about this either, since I can't get it to play anything yet.  But it 
> looks from the WM8510 data sheet that even though the WM8510 is mono, it 
> expects a stereo I2S stream, and just ignores one of the channels based on 
> the value of DACLRSWAP register bit.

Indeed, the main thing I need to check is to confirm what is normally
done with mono channels - in any case, the codec should at least make
some noise providing the rates are correct and there's stereo data.

I take it the digital audio looks fine with a scope - clocks at the
correct rate, sensible looking data and so on?
