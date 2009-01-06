From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
	davinci-sffsdr module
Date: Tue, 6 Jan 2009 22:00:06 +0000
Message-ID: <20090106220005.GB3549@sirena.org.uk>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E83FF1037EE
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 23:00:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090106164120.bd2fb16b.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 06, 2009 at 04:41:20PM -0500, Hugo Villeneuve wrote:
> Mark Brown <broonie@sirena.org.uk> wrote:

> > If the driver is for is not yet in mainline I'd be more inclined to
> > fix this by providing the relevant Kconfig dependency to exclude it

> The problem is that some people may want to do modifications to this
> soc driver, and they won?t be able to test that their changes are
> valid (ex: do not break compilation).

Speaking as the person who I expect most frequently tries that I 
wouldn't worry about it - it's easy enough to see what's happened and
there will still be errors at link time even with the extern.  I'd
certainly want to see the Kconfig fix as well, independantly of this.

> > Do the DaVinci drivers build at all in mainline, anyway?  Last time I
> > checked they required out of tree DMA patches.

> I just sucessfully compiled the davinci-sffsdr soc driver (although
> audio seems broken for me at the moment when I actually test it).

That's good news - previously it would fail to build at all.  What sort
of breakage are you seeing (and what was the version you used when you
developed the driver)?

[Your MUA isn't doing word wrapping, BTW.]
