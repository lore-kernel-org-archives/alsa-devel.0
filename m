From: "Chris Schumann" <chris@idlelion.net>
Subject: Re: Getting Started on Alsa
Date: Sun, 6 May 2007 20:32:41 -0500
Message-ID: <000101c79047$9b83c390$6417a8c0@piv17>
References: <20070506222600.49A5D8734B@cal1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by alsa0.perex.cz (Postfix) with ESMTP id A231F24511
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 03:32:48 +0200 (CEST)
In-Reply-To: <20070506222600.49A5D8734B@cal1-1.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Ash Willis' <ashwillis@programmer.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On Behalf Of Ash Willis

> Hi Chris,
> 
> > I'd like to take action on bug #305, since it's my own 
> itch. I've done 
> > very low-level programming, but not on Linux device 
> drivers. I'm very 
> > familiar with command line development tools.
> > 
> 
> If you're not familiar with drivers or audio drivers in 
> particular then reading Writing an ALSA Driver by Takashi 
> Iwai might be a good place to start.
> 
> You're referring to the suspend/resume bug in the cs46xx 
> driver, right?
> Maybe try dumping all the registers while it's working and 
> dumping them while it's broken and comparing the two sets of data?
> 
> I guess the suspend function is doing something that it 
> shouldn't be, or the resume function isn't doing something 
> that it should be...good luck on finding out what that is.
> 
> Ash

Thanks for the tips, Ash. I've found the Iwai document. Now there's some
light reading. I take it that it's still relevant, even though it hasn't
been updated since 2005.

Yes, the cs46xx driver. That chip is in a lot of machines (at least ten
ThinkPad models), and with this bug nobody running Alsa likes Linux very
much.

Is there some (handy) way to dump the registers from DOS or Windows as a
comparison?

For development: Since the drivers go into the kernel, I should be able to
find a page on getting a development environment set up... right? I'm
guessing most people do development on a machine with the device in
question. That could be interesting because my 600X crapped out, but there
are two more in the house I can borrow now and again.

Chris
(using the address I subscribed with this time)
