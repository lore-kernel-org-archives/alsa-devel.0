From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 13:19:49 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0802071314430.8113@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B02B224590
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 13:19:49 +0100 (CET)
In-Reply-To: <s5hhcglynw7.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Andrew Paprocki <andrew@ishiboo.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2008, Takashi Iwai wrote:

> At Thu, 7 Feb 2008 06:45:10 -0500,
> Andrew Paprocki wrote:
> > 
> > On Feb 7, 2008 6:27 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > BTW, one big annoying thing is that developers have no complete kernel
> > > tree to access, and thus the patches that touch outside the ALSA
> > > subdirectory cannot be merged easily.  People often send patches
> > > fixing together with OSS, etc, and I had to skip them.  So, frankly,
> > > I'd love to have an access to the whole kernel tree.  But, OTOH, this
> > > would make harder for other naive guys to give it a try because they
> > > need to download the big linux kernel tree git.
> > 
> > I was just wondering about this the other day.. I don't think using
> > kernel git trees would put anyone off. Anyone working on a sound card
> > driver would most likely already be familiar with using git w/ the
> > upstream kernel anyway.
> 
> Right, if you are a developer, it's fine (and even better).  But, my
> concern is that the whole linux kernel tree might be too heavy for
> some casual user who just wants to try the latest version of ALSA
> driver...  "Download 50MB and use 350MB disk space just for a single
> fix?  Hell, no!"

I have an idea to create a web interface generating the alsa-kernel like 
tree on the fly (with some caching, of course). It might also apply for 
all ALSA packages. It would be quite nice to point users to very recent 
code and not to wait for daily tarballs.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
