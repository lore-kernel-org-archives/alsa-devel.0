From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 "test" model
Date: Mon, 7 Jan 2008 10:21:10 +1030 (CST)
Message-ID: <200801062351.m06NpAJg005062@turbo.physics.adelaide.edu.au>
References: <mailman.1.1198839601.19653.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 64A6D247D5
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 00:51:14 +0100 (CET)
In-Reply-To: <mailman.1.1198839601.19653.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Dec 28, 2007 12:00:01 PM
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
Cc: marco@harddisk.is-a-geek.org
List-Id: alsa-devel@alsa-project.org

Hi Tobin

> > I try to use a patch from J. Woithe to put a test model into the
> > ALC268 driver [1] (enabling all pins etc.); unfortunately it gives a
> > lot of compiling errors ([2]) which I am unable to understand as I
> > don't have sufficient knowledge of the internal API of HDA codec.
> >
> > Can someone please look over it and correct the mistakes?
> > 
> > Marco Schuster
> > 
> > [1]: http://harddisk.is-a-geek.org/patch.txt
> > [2]: http://harddisk.is-a-geek.org/compiling-errors.txt
>
> Hi, and thanks for the effort.  I'll fix this up a bit and send out an
> updated patch this weekend.  I have an ALC268 test board to work with
> now, so I should be able to get it figured out.

I'm not entirely sure what's going on here with this patch.  As is indicated
by the patch itself it's against ALSA in the 2.6.24-rc6 kernel and it
applies and compiles fine for me.  The last few error messages at the
second URL seems to suggest that the patch was in some way corrupted
because I'm seeing non-ASCII characters in the error messages.

I should note that the patch as referenced by Marco was not believed by me
to be ready for release yet - that is why I haven't forwarded it on to the
list for consideration yet.  I sent it to Marco privately and I had hoped to
utilise Marco's system to verify basic functionality of the patch before
posting it for consideration.  It was prepared in a hurry at the end of last
year just before I went on leave and have not had a chance to revisit the
patch or the issues that Marco saw until now.

Since you have an ALC268 board it's probably sensible for you to take over
the patch at this point - I don't have an ALC268 system.  However,
understand that by making this initial patch available to Marco privately it
was not my intention to create a lot of extra work for yourself (or any
other developer for that matter).  I had intended to see it through to
operational status before bothering the list with it.

Are you happy to take over management of this patch or would you like me to
resume dialog with Marco?

If the patch at the above URL is in some way corrupted drop me a line and
I'll forward you the original.

Regards
  jonathan
