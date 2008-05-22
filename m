From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: AT32AP7000 (AVR32) + WM8510
Date: Thu, 22 May 2008 18:11:31 -0500
Message-ID: <200805221811.31770.geoffrey@pager.net>
References: <200805221120.08815.geoffrey@pager.net>
	<200805221457.41748.geoffrey@pager.net>
	<20080522224840.GA31117@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id C83BF24472
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 01:11:23 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id E9A1DB4EF9
	for <alsa-devel@alsa-project.org>; Thu, 22 May 2008 18:11:05 -0500 (CDT)
Received: from [192.168.1.71] (LRS-CiscoBackup [192.168.1.1]) by
	barracuda.pager.net with ESMTP id HJZTyxT8UQO090Pj for
	<alsa-devel@alsa-project.org>; Thu, 22 May 2008 18:11:05 -0500 (CDT)
In-Reply-To: <20080522224840.GA31117@sirena.org.uk>
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

On Thursday 22 May 2008 05:48:41 pm Mark Brown wrote:
> On Thu, May 22, 2008 at 02:57:41PM -0500, Geoffrey Wossum wrote:
> > Looks like it should work to me.  Note that I do hear a pop from the
> > speaker the first time I try to play a file.  Here's a dump of the
> > registers while I'm trying to play a file with aplay.  I'm combing
> > through them right now to see if I can find anything that looks off.

> I'll have a look at it at some point, but not right now :) .  I should
> also have asked you if you could post your machine driver - if you'd
> rather post it off-list that'd be fine.

I'll have to do that tomorrow, I'm on my way out the door.

> I take it the digital audio looks fine with a scope - clocks at the
> correct rate, sensible looking data and so on?

The DACDAT signal looks pretty good.  However, I did notice something very 
odd.  The BCLK is dead on for whatever bitrate I'm doing.  However, the FRAME 
always runs at 44.1 kHz, no matter what I do.  From my understanding of I2S 
(which could be wrong), I would expect FRAME to run at the sample rate I'm 
playing back.  So if I'm playing back at 11025, I would expect BCLK to run at 
352 kHz and FRAME to run at 11 kHz.  I see BCLK running at 352 kHz, check.  
But frame is running at 44.1 kHz.  This doesn't seem right.  Am I missing 
something here?

---
Geoffrey
