From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 08:03:57 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0802070759200.9968@shell4.speakeasy.net>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
	<76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<20080207150022.GA8453@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail7.sea5.speakeasy.net (mail7.sea5.speakeasy.net
	[69.17.117.9]) by alsa0.perex.cz (Postfix) with ESMTP id 85957245EE
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 17:04:03 +0100 (CET)
In-Reply-To: <20080207150022.GA8453@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Feb 2008, Mark Brown wrote:
> On Thu, Feb 07, 2008 at 05:10:27AM -0800, Trent Piepho wrote:
> > On Thu, 7 Feb 2008, Takashi Iwai wrote:
> > > Right, if you are a developer, it's fine (and even better).  But, my
> > > concern is that the whole linux kernel tree might be too heavy for
> > > some casual user who just wants to try the latest version of ALSA
> > > driver...  "Download 50MB and use 350MB disk space just for a single
> > > fix?  Hell, no!"
>
> > You'll certainly get a lot fewer users of the latest driver code if they
> > have to download, compile and install a entire new kernel.  There are
> > plenty of people who will install new drivers, but won't even consider
> > switching from the kernel their distro came with.
>
> Judging from what I've seen on the IRC channels I hang around on I get
> the impression that relatively few people doing this on a user level
> (typically people with shiny new laptops and so on) are using hg to
> access the drivers - they mostly seem to be using either the snapshot or

That could be because ALSA does "releases".  For the media drivers, there
are no releases.  If you want the latest drivers (or maybe some developer's
branch for a certain piece of hardware that's still under development), you
grab the code from Hg.  Certainly a lot of people just grab the tip tarball
with wget and don't use hg clone, but they have the same codebase that
developers using Hg have.
