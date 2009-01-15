From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
	davinci-sffsdr module
Date: Thu, 15 Jan 2009 11:18:07 +0000
Message-ID: <20090115111806.GB2147@sirena.org.uk>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
	<20090106220005.GB3549@sirena.org.uk>
	<20090114155406.a086c6ef.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B446C243EF
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 12:18:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090114155406.a086c6ef.hugo@hugovil.com>
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

")
Fcc: +sent-mail

On Wed, Jan 14, 2009 at 03:54:06PM -0500, Hugo Villeneuve wrote:
> Mark Brown <broonie@sirena.org.uk> wrote:

> > Speaking as the person who I expect most frequently tries that I 
> > wouldn't worry about it - it's easy enough to see what's happened and
> > there will still be errors at link time even with the extern.

> No, there won?t be errors when compiling as a module. Only when
> actually loading the module.

Check again - the kernel will detect those errors at build time.  The
module itself will compile but once all the modules are built Kbuild
verifies that all the symbols they use can be found.

> > That's good news - previously it would fail to build at all.  What
> > sort of breakage are you seeing (and what was the version you used
> > when you developed the driver)?

> I developped the driver with version 2.6.27-rc6-davinci1-05187-g91c2c53.

> The breakage I see when I run the aplay utility is this:

>   aplay: pcm_write:1394: write error: Input/output error

> davinci-git version is the latest as of january 14
> (2.6.28-davinci1-06546-gcfb152b)

Hrm, OK.  That's not terribly informative - does the error get reported
after about 10 seconds by any chance?  I suspect that DMA just isn't
happening.
