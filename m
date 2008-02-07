From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 15:00:22 +0000
Message-ID: <20080207150022.GA8453@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 062E610383F
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 16:00:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 07, 2008 at 05:10:27AM -0800, Trent Piepho wrote:
> On Thu, 7 Feb 2008, Takashi Iwai wrote:

> > Right, if you are a developer, it's fine (and even better).  But, my
> > concern is that the whole linux kernel tree might be too heavy for
> > some casual user who just wants to try the latest version of ALSA
> > driver...  "Download 50MB and use 350MB disk space just for a single
> > fix?  Hell, no!"

> You'll certainly get a lot fewer users of the latest driver code if they
> have to download, compile and install a entire new kernel.  There are
> plenty of people who will install new drivers, but won't even consider
> switching from the kernel their distro came with.

Judging from what I've seen on the IRC channels I hang around on I get
the impression that relatively few people doing this on a user level 
(typically people with shiny new laptops and so on) are using hg to
access the drivers - they mostly seem to be using either the snapshot or
release tarballs to update their existing kernels.  So long as those are
available in a similar form I would expect these users would be
unaffected.

> It would also be a huge PITA for developers who work on multiple
> sub-systems.  If I want to make a patch for an alsa driver, I have to
> reboot into an alsa kernel?  I try to go a few months between rebooting.

This use case is fairly well served by git - it is being used by enough
subsystems for people to be running into it a lot.  The support for
multiple remotes makes it relatively easy to have a git tree which works
with changes from multiple places and cherry-pick makes it relatively
straightforward to move changes between branches for submission.
