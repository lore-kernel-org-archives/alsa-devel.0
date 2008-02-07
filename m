From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HG vs GIT
Date: Thu, 07 Feb 2008 06:49:19 -0800
Message-ID: <1202395759.20223.74.camel@razman.gruemaster.com>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<s5hbq6szylg.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070538120.9968@shell4.speakeasy.net>
	<s5h8x1wzxl0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id CB95110383E
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 15:49:21 +0100 (CET)
In-Reply-To: <s5h8x1wzxl0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org


On Thu, 2008-02-07 at 14:48 +0100, Takashi Iwai wrote:

> At Thu, 7 Feb 2008 05:41:57 -0800 (PST),
> Trent Piepho wrote:
> > 
> > On Thu, 7 Feb 2008, Takashi Iwai wrote:
> > > At Thu, 7 Feb 2008 05:10:27 -0800 (PST),
> > > > It would also be a huge PITA for developers who work on multiple
> > > > sub-systems.  If I want to make a patch for an alsa driver, I have to
> > > > reboot into an alsa kernel?  I try to go a few months between rebooting.
> > >
> > > Hm, what's the problem to pull alsa.git tree to your own working tree?
> > 
> > How do I test the driver if it's compiled with the kernel in the alsa.git
> > tree?  I want to compile the driver against the kernel I'm running now.
> 
> Well, I don't get your point.  "git-pull alsa.git" onto your current
> kernel tree and make.  Then you have the latest ALSA drivers for your
> current system...
> 
> Of course, a subset tree like the current alsa-kernel would be much
> more handy.  That's why I suggest to create the subset tree
> automatically from the linux kernel tree.
> 
> 

I do.  I for one am using a canned distro (Mandriva 2008).  I don't mess
with the kernel tree at all.  I just build and test alsa by combining
the alsa-driver and alsa-kernel HG trees (same thing the daily snapshot
does).

The advantage of this is I can test this snapshot on multiple
distributions without having to try to find a kernel git tree for each
distro (some barely give you the kernel headers package to build on).

For the work I do, having multiple kernel trees to test on would be
difficult.

Tobin Davis 


Darling: the popular form of address used in speaking to a member of the
opposite sex whose name you cannot at the moment remember.
		-- Oliver Herford
