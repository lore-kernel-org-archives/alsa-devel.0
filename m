From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
 davinci-sffsdr module
Date: Wed, 14 Jan 2009 15:54:06 -0500
Message-ID: <20090114155406.a086c6ef.hugo@hugovil.com>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
	<20090106220005.GB3549@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D100103843
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 21:54:10 +0100 (CET)
In-Reply-To: <20090106220005.GB3549@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Jan 2009 22:00:06 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Tue, Jan 06, 2009 at 04:41:20PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@sirena.org.uk> wrote:
> =

> > > If the driver is for is not yet in mainline I'd be more inclined
> > > to fix this by providing the relevant Kconfig dependency to
> > > exclude it
> =

> > The problem is that some people may want to do modifications to this
> > soc driver, and they won?t be able to test that their changes are
> > valid (ex: do not break compilation).
> =

> Speaking as the person who I expect most frequently tries that I =

> wouldn't worry about it - it's easy enough to see what's happened and
> there will still be errors at link time even with the extern.

No, there won=B4t be errors when compiling as a module. Only when
actually loading the module.

>  I'd certainly want to see the Kconfig fix as well, independantly of
> this.

I will look into this eventually.

> > > Do the DaVinci drivers build at all in mainline, anyway?  Last
> > > time I checked they required out of tree DMA patches.
> =

> > I just sucessfully compiled the davinci-sffsdr soc driver (although
> > audio seems broken for me at the moment when I actually test it).
> =

> That's good news - previously it would fail to build at all.  What
> sort of breakage are you seeing (and what was the version you used
> when you developed the driver)?

I developped the driver with version 2.6.27-rc6-davinci1-05187-g91c2c53.

The breakage I see when I run the aplay utility is this:
  =

  aplay: pcm_write:1394: write error: Input/output error

davinci-git version is the latest as of january 14
(2.6.28-davinci1-06546-gcfb152b)

> [Your MUA isn't doing word wrapping, BTW.]
Fixed, thanks :)

Hugo v.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
