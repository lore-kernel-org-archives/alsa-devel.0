From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Installing a "different" version of Alsa
Date: Tue, 22 Dec 2009 23:44:36 +0000
Message-ID: <20091222234435.GA2643@sirena.org.uk>
References: <mailman.3791.1261331960.2074.alsa-devel@alsa-project.org>
	<69F4A42643E24687BFFD4D3D0F485DEA@brianoffice>
	<20091222125847.GB8522@sirena.org.uk>
	<3DE0C4BC819942189FD9EA0AB2630C68@brianoffice>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E06224625
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 00:44:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3DE0C4BC819942189FD9EA0AB2630C68@brianoffice>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Welch <Brian-Welch@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2009 at 02:50:42PM -0700, Brian Welch wrote:
> From: "Mark Brown" <broonie@opensource.wolfsonmicro.com>
> To: "Brian Welch" <Brian-Welch@cox.net>

> > If it's just the drivers you need to update it's probably easier to
> > merge the newer ALSA version into the kernel rather than trying to keep
> > an out of tree version as well, it will hopefully reduce the level of
> > confusion within the toolchain.

> Hmmm, yeah, problems all the way around.  Maybe I should explain in
> more detail.  This SDK is for a platform (silicon/software/dev-board) still
> very much under development and I can't say too much without violating NDA,
> etc.  The SDK is currently supported by the silicon manufacturer.  It 

Feel free to contact me off-list if you feel you're able to discuss
things a bit more that way, I might be able to advise in more detail
with more information.  Please also feel free to put the vendor in touch
with me directly, I can discuss these issues from the point of view of a
silicon vendor.

> includes a
> vanilla Linux distribution directly from kernel.org and a small kernel 
> patch.
> In addition to the Linux distrubution there are drivers in the SDK for 
> dozens of
> custom devices including custom sound hardware.  Basically, they're rolling 
> their
> own toolchain and supporting it (for now).

On this front it may well be worth pointing out to them that a number of
large companies have tried this approach and run into trouble with it in
the longer term due to things like the effort involved in maintaining
things once you've got a number of legacy products or customer pressure
to have mainline work.  There's an awful lot of work in maintaining a
full Linux kernel, never mind distribution, and many customers are not
going to use large parts of this work anyway (especially at the
distribution level) and use their preferred software stack.

> I've written an Alsa-compatible sound driver layer to go between Alsa and
> their custom driver and it's been working for a few months, but they 
> recently
> decided to start supporting two versions of the SDK, each having a different
> version of Linux.  The version of Alsa built-in to Linux in each version of 
> the
> SDK is different, and they would like to supply a version of Alsa 
> "out-of-tree"
> so that both SDKs are the same and so that customers can theoretically
> swap out to any version of Alsa they want.

Hrm, are these standard ALSA drivers, not ASoC drivers?  If this is a
standard embedded processor setup with an I2S or similar controller in
the processor talking to an external device providing the audio CODEC
then the code really ought to be written in terms of ASoC in which case
trying to go for compatibility with multiple kernel versions is going to
be more trouble than its worth since the ASoC APIs are fairly fluid and
are likely to continue to be so for the forseeable future.

The big win from ASoC from the point of view of the CPU vendor is that
they will get compatibility with all the audio CODEC devices supported
by Linux without having to reinvent the wheel each time, and won't have
to support customisations for individual customer boards within their
code.  This really does save a lot of time, especially once you start to
address a wide customer base.

> This change has caused my driver to not build correctly/reliably on both
> SDK versions.  The reason is that the symbols in linux/include/sound are
> different than the out-of-tree include files that I need to build against. 
> I can
> make it work by hacking the SDK directory structure but they want to
> eventually integrate everything into the SDK so minimizing hacks is 
> desirable.

Without knowing what their SDK is doing it's going to be hard to comment
in much more detail than to say that contributing the code to the kernel
is the simplest way to get something that's up to date with kernel API
changes.  If they don't want to contribute their code upstream then the
easiest approach is usually to track the current ASoC version and
backport ASoC (and possibly all ALSA) en masse to whatever kernel
version they are targetting.  This will make life easier if/when they do
decide to work upstream and avoids having to deal with any bugs or
missing features in older kernels.

Trying to mix and match an in kernel ALSA with an out of tree ALSA isn't
going to work well, if you are using an out of tree ALSA then you should
completely disable the in tree version 

> Merging the correct version of Alsa into the kernel will fix my immediate
> problem but they don't want to do it because it won't satisfy the desire to
> be able to swap in any version of Alsa (assuming that's actually possible).

ALSA and ASoC are generally relatively independant of the kernel
version, though it's likely that ASoC is going to grow support for
runtime PM very soon which will be a bit of a backporting issue.

Like I say it's hard to comment in too much detail without more
information but it does sound like the vendor is expecting a stable
in-kernel API which isn't something you can rely on with Linux in any
area.  Greg K-H's Stable API Nonsense article

	http://www.kroah.com/log/linux/stable_api_nonsense.html

covers this in a bit of detail, and there's discussion in the kernel
mailing list archives.  Embedded audio is one of the areas that's
fairly actively developed at the minute, right now there are a number of
reasonable system designs which can't really be addressed without some
refactoring and newer audio hardware presents new opportunities for the
kernel to improve performance.
