From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Wed, 26 Mar 2008 14:59:21 +0000
Message-ID: <20080326145921.GC26346@sirena.org.uk>
References: <47E7A0A8.3010200@oliford.co.uk>
	<20080324134231.GA30281@sirena.org.uk>
	<47EA5527.9050201@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1748810380C
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 15:59:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47EA5527.9050201@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, alex.meakins@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 26, 2008 at 01:52:39PM +0000, Oliver Ford wrote:

> The machine no longer reboots out of linux though. I assume there were
> some changes in 2.6.25-rc4 mainline that aren't in the asoc-v2-dev yet.
> I will wait for the pxa3xx stuff to be merged into the mainline for
> this. What version of the mainline kernel is the latest asoc-v2-dev
> branch based on. (I'm still a little hazy on the git stuff I'm afraid).

The last version that was merged in appears to be 2.6.25-rc2 (say 'git
log' then search for 'Merge.*v2\.6').  For production use I would
recommend going with ASoC v1 at the moment.  The PXA3xx support should
be straightforward to backport (I wouldn't be suprised if the patches
introducing it could just applied against mainline but I've not actually
tried yet).

> > I know that there are a number of users currently using the tree for
> > that use case so the asoc-v2-dev branch should hopefully work for you.
> > If you run into trouble please let me know.

> The WM97xx touchscreen driver only appears to be in the linux-2.6-touch
> repository (dev branch, iirc), rather than  linux-2.6-asoc where the
> pxa3xx support is. Since I want both the wm97xx touchscreen and pxa3xx
> support, is there a simple way I can get the necessary changes in one
> applied to the other?

You can track both multiple git trees using the remotes feature of
git - see git-remote(1) for usage information.  For example, this:

	git remote add wolfson-touch \
		git://opensource.wolfsonmicro.com/linux-2.6-touch

will tell git to track the Wolfson touch drivers using the name
'wolfson-touch'.  If you do that and then say:

	git remote update
	git merge wolfson-touch/dev

it will fetch the current state of all remote trees it knows about and
then merge the current dev branch of the Wolfson touch drivers git into
your current working copy.

The touchscreen drivers and git usage are both rather off-topic for
either list, though - probably best to follow up off-list or on
linux-input.
