From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: HG vs GIT
Date: Thu, 7 Feb 2008 19:46:24 +0000
Message-ID: <20080207194624.GB30831@sirena.org.uk>
References: <76366b180802070345u705c1a72ibebb27d909028405@mail.gmail.com>
	<s5hhcglynw7.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070440430.9968@shell4.speakeasy.net>
	<s5hbq6szylg.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070538120.9968@shell4.speakeasy.net>
	<s5h8x1wzxl0.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0802071450530.8113@tm8103.perex-int.cz>
	<s5h63x0zwtv.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0802070731570.9968@shell4.speakeasy.net>
	<s5hwspgycso.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A903024554
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 20:46:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwspgycso.wl%tiwai@suse.de>
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

On Thu, Feb 07, 2008 at 05:03:03PM +0100, Takashi Iwai wrote:
> Trent Piepho wrote:

> > The problem with an out of tree codebase extracted from git (or Hg), is
> > that once extracted you couldn't use ALSA's SCM on it.  E.g., generating
> > nice patches based on current head, or pulling and merging recent patches
> > in with your current work.

> It's possible to extract and merge patches nicely with git.  I just
> pointed the "easiest" way to get the latest code.  There must be a
> better way.

I have to confess that I've not tried this with ALSA but for osme other
areas of the kernel I've succesfully used the out of tree build support
in kbuild to allow me to work on drivers while running a distro kernel.
I'd change into the directory with the module source and say something
like:

	make M=${PWD} -C /lib/modules/$(uname -r)/build

to build against the installed kernel headers and config.

This does break if the current code depends on any changes under
include/ which would be more of a problem for some bits ALSA than for
most of the things I've tried this approach with - it's more suitable
for individual drivers than something like ALSA core, for example.
