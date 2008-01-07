From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALC268 "test" model
Date: Sun, 06 Jan 2008 16:06:15 -0800
Message-ID: <1199664375.4061.94.camel@razman.gruemaster.com>
References: <200801062351.m06NpAJg005062@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE14103891
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 01:06:18 +0100 (CET)
In-Reply-To: <200801062351.m06NpAJg005062@turbo.physics.adelaide.edu.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@alsa-project.org, marco@harddisk.is-a-geek.org
List-Id: alsa-devel@alsa-project.org

The compiling errors will only be visible if the drivers are compiled
with "--with-debug=detect", as the preparser will ignore this section of
code otherwise.  That's probably why you aren't seeing any compiler
issues.  The error is the HDA_BIND_MUTE controls; there are too many
fields for that data type.

I don't have a problem with taking over the patch, but I just got
inundated with the holidays, hardware issues on my home development
system, and CES preparation at work.  I'll try to get a completely
working version of the patch into the alsa tree this next week.


Tobin

On Mon, 2008-01-07 at 10:21 +1030, Jonathan Woithe wrote:

> Hi Tobin
> 
> > > I try to use a patch from J. Woithe to put a test model into the
> > > ALC268 driver [1] (enabling all pins etc.); unfortunately it gives a
> > > lot of compiling errors ([2]) which I am unable to understand as I
> > > don't have sufficient knowledge of the internal API of HDA codec.
> > >
> > > Can someone please look over it and correct the mistakes?
> > > 
> > > Marco Schuster
> > > 
> > > [1]: http://harddisk.is-a-geek.org/patch.txt
> > > [2]: http://harddisk.is-a-geek.org/compiling-errors.txt
> >
> > Hi, and thanks for the effort.  I'll fix this up a bit and send out an
> > updated patch this weekend.  I have an ALC268 test board to work with
> > now, so I should be able to get it figured out.
> 
> I'm not entirely sure what's going on here with this patch.  As is indicated
> by the patch itself it's against ALSA in the 2.6.24-rc6 kernel and it
> applies and compiles fine for me.  The last few error messages at the
> second URL seems to suggest that the patch was in some way corrupted
> because I'm seeing non-ASCII characters in the error messages.
> 
> I should note that the patch as referenced by Marco was not believed by me
> to be ready for release yet - that is why I haven't forwarded it on to the
> list for consideration yet.  I sent it to Marco privately and I had hoped to
> utilise Marco's system to verify basic functionality of the patch before
> posting it for consideration.  It was prepared in a hurry at the end of last
> year just before I went on leave and have not had a chance to revisit the
> patch or the issues that Marco saw until now.
> 
> Since you have an ALC268 board it's probably sensible for you to take over
> the patch at this point - I don't have an ALC268 system.  However,
> understand that by making this initial patch available to Marco privately it
> was not my intention to create a lot of extra work for yourself (or any
> other developer for that matter).  I had intended to see it through to
> operational status before bothering the list with it.
> 
> Are you happy to take over management of this patch or would you like me to
> resume dialog with Marco?
> 
> If the patch at the above URL is in some way corrupted drop me a line and
> I'll forward you the original.
> 
> Regards
>   jonathan

-- 
Tobin Davis  


"Roman Polanski makes his own blood.  He's smart -- that's why his movies work."
-- A brilliant director at "Frank's Place"
