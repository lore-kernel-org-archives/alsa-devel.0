From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 14:52:43 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802071450530.8113@tm8103.perex-int.cz>
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
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4086B103842
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 14:52:44 +0100 (CET)
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

On Thu, 7 Feb 2008, Takashi Iwai wrote:

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

Pull cannot be used. You'll pull also Linus's changes in tree with this 
command (which might not be wanted).

We'll provide a GNU patch interface to patch your tree as required hidding 
used SCM system, of course.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
