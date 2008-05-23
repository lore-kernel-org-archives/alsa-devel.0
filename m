From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Fri, 23 May 2008 17:56:00 -0500
Message-ID: <200805231756.00609.geoffrey@pager.net>
References: <200805221120.08815.geoffrey@pager.net>
	<20080522224840.GA31117@sirena.org.uk>
	<200805221811.31770.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id A8616245D5
	for <alsa-devel@alsa-project.org>;
	Sat, 24 May 2008 00:55:46 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id 86DF4B6353
	for <alsa-devel@alsa-project.org>; Fri, 23 May 2008 17:55:39 -0500 (CDT)
Received: from [192.168.1.71] (LRS-CiscoBackup [192.168.1.1]) by
	barracuda.pager.net with ESMTP id FD1s8k4AC4YM6NAJ for
	<alsa-devel@alsa-project.org>; Fri, 23 May 2008 17:55:39 -0500 (CDT)
In-Reply-To: <200805221811.31770.geoffrey@pager.net>
Content-Disposition: inline
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

On Thursday 22 May 2008 06:11:31 pm Geoffrey Wossum wrote:
> On Thursday 22 May 2008 05:48:41 pm Mark Brown wrote:
> > On Thu, May 22, 2008 at 02:57:41PM -0500, Geoffrey Wossum wrote:
> > > Looks like it should work to me.  Note that I do hear a pop from the
> > > speaker the first time I try to play a file.  Here's a dump of the
> > > registers while I'm trying to play a file with aplay.  I'm combing
> > > through them right now to see if I can find anything that looks off.
> >
> > I'll have a look at it at some point, but not right now :) .  I should
> > also have asked you if you could post your machine driver - if you'd
> > rather post it off-list that'd be fine.

Ok, I got it working.  It can now play "I'm sorry, Dave.  I'm afraid I can't 
do that."  This should be the audio equivalent of "Hello world" :)

First, I changed it so the AVR32 provided the BCLK and FRAME.  I could never 
get the WM8510 to generate what looked like proper FRAMES.  I did continue 
using the WM8510's PLL to generate the DAC clock.  With the AVR32 providing 
the clocks, I at least got some noise out of it.

After a lot of head scratching and analyzing register settings and what not, I 
realized that I had based my AVR32 platform drivers on the AT91.  The AT91 is 
little endian, the AVR32 is big endian.  Changing all the SNDRV_PCM_FMTBIT_ 
settings to be BE instead of LE changed the noise into the files I was trying 
to play.

Finally, I really had to lie in the wm8510 code and say that it supported a 
minimum of 2 channels, and a maximum of 2 channels.  This makes sense from 
the data sheet, since it still wants a left and a right channel of data, and 
just throws one away.

A few questions:

I had to change the WM8510's format to say that it wanted big endian.  Should 
the CODEC (and platform and machine) be setup just to say that it uses 
SNDRV_PCM_FMTBIT_S16 instead of SNDRV_PCM_FMTBIT_S16_LE/BE?  Looks from 
sound/pcm.h this should just do the Right Thing.

Any idea why I couldn't get the WM8510 to generate the FRAME signal properly?  
Like I said before, it generated a 44.1 kHz frame no matter the BCLK divider 
or the word length were set to.

Thanks for the help!  As soon as I get the code cleaned up some, I'll 
contribute the AVR32 platform driver code.

---
Geoffrey
