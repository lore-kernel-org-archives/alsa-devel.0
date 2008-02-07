From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 07:49:39 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0802070731570.9968@shell4.speakeasy.net>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<s5hbq6szylg.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070538120.9968@shell4.speakeasy.net>
	<s5h8x1wzxl0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0802071450530.8113@tm8103.perex-int.cz>
	<s5h63x0zwtv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7]) by alsa0.perex.cz (Postfix) with ESMTP id ED3BC245E5
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 16:49:40 +0100 (CET)
In-Reply-To: <s5h63x0zwtv.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2008, Takashi Iwai wrote:
> At Thu, 7 Feb 2008 14:52:43 +0100 (CET),
> > > > How do I test the driver if it's compiled with the kernel in the alsa.git
> > > > tree?  I want to compile the driver against the kernel I'm running now.
> > >
> > > Well, I don't get your point.  "git-pull alsa.git" onto your current
> > > kernel tree and make.  Then you have the latest ALSA drivers for your
> > > current system...
> >
> > Pull cannot be used. You'll pull also Linus's changes in tree with this
> > command (which might not be wanted).
>
> Ah, OK, I didn't think that your current tree is behind the ALSA
> tree.  But surely there must be an easy way to do that.  At easiest,
> I'd make a diff of alsa-git.tree to the upstream and apply it over the
> local tree.

It would have to be behind the current tree, unless you reboot multiple
times per day.

The problem with an out of tree codebase extracted from git (or Hg), is
that once extracted you couldn't use ALSA's SCM on it.  E.g., generating
nice patches based on current head, or pulling and merging recent patches
in with your current work.

I have a dozen different v4l-dvb Hg branches aka repositories on my system,
for different features or projects, etc.  What branches are for.  Some are
months old.  I can work on any one of those branches, compile, load, and
test the drivers, and push new changes to that branch, without rebooting.
I can do the same with ALSA too in fact, though the ALSA out of tree build
system is less convenient.  I'm not going to reboot five times a day.  I
only have one computer, and I'm not going to chance my recoding of the new
episode of Lost tonight getting messed up because of a problem in a one day
old kernel that hasn't been tested.

I don't have to reboot between 2.6.21 or 2.6.25-rc1 to work on a different
branch.
