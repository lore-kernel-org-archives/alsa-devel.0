From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: Getting Started on Alsa
Date: Sun, 06 May 2007 21:12:20 -0500
Message-ID: <20070507021220.DA6BD8735B@cal1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cal1-1.us4.outblaze.com (cal1-1.us4.outblaze.com
	[205.158.62.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D6B52451A
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 04:12:22 +0200 (CEST)
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
To: Chris Schumann <chris@idlelion.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Thanks for the tips, Ash. I've found the Iwai document. Now there's some
> light reading. I take it that it's still relevant, even though it hasn't
> been updated since 2005.
>
 
I haven't actually read it since 2005 I'm afraid :) but I don't think
anything's changed that drastically. The fundamentals are all there.

> Yes, the cs46xx driver. That chip is in a lot of machines (at least ten
> ThinkPad models), and with this bug nobody running Alsa likes Linux very
> much.
> 

Yeah, it's a pretty poor show that this bug has existed for so long.
Let's hope you can zap it!

> Is there some (handy) way to dump the registers from DOS or Windows as a
> comparison?
> 

Well, that depends. I'm not familiar with the hardware. There's a Windows
program called PCItree. It allows you to view the current status of the
ioport of a chosen device. Now, that's pretty handy if the regs for the card
are mapped directly onto the io port. It's usually the case though, I think,
that the registers aren't just mapped on and you'll need to query the card.
If they're not mapped onto the io port (and forgive me again - not familiar
with this chip) then you could use a debugger such as Numega SoftIce to
manually issue queries to find out the contents of the registers. Sounds like
a happy fun time. Writing the code to do a reg dump might be fun too.
You may also want to use a debugger/disassembler with Windows (or other)
drivers in order to find out what those drivers do to the card on resume.

> For development: Since the drivers go into the kernel, I should be able to
> find a page on getting a development environment set up... right? I'm

You don't need to mess with the kernel as ALSA is available as a package.
All you really need is the latest copy of alsa-driver and a compiler and
you're good to go.

Ash

=
