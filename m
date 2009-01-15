From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
 davinci-sffsdr module
Date: Thu, 15 Jan 2009 15:10:29 -0500
Message-ID: <20090115151029.9f0bcaed.hugo@hugovil.com>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
	<20090106220005.GB3549@sirena.org.uk>
	<20090114155406.a086c6ef.hugo@hugovil.com>
	<20090115111806.GB2147@sirena.org.uk>
	<20090115145454.17178d53.hugo@hugovil.com>
	<20090115200121.GH12768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A023103884
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 21:10:31 +0100 (CET)
In-Reply-To: <20090115200121.GH12768@sirena.org.uk>
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

On Thu, 15 Jan 2009 20:01:22 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Jan 15, 2009 at 02:54:54PM -0500, Hugo Villeneuve wrote:
> > Mark Brown <broonie@sirena.org.uk> wrote:
> 
> > > > The breakage I see when I run the aplay utility is this:
> 
> > > >   aplay: pcm_write:1394: write error: Input/output error
> 
> > > > davinci-git version is the latest as of january 14
> > > > (2.6.28-davinci1-06546-gcfb152b)
> 
> > > Hrm, OK.  That's not terribly informative - does the error get
> > > reported after about 10 seconds by any chance?  I suspect that DMA
> > > just isn't happening.
> 
> > Sorry about the non-verbosity :)
> 
> I actually meant the error message rather than your posting, sorry!

I know :)

In the meantime, I will send you a patch that will fix the compilation
problems for the SFFSDR ASoC module.

>  Yes it happens almost exactly after 10 seconds. I?m not an expert
> > with audio nor DMA, but can you indicate me where I should be
> > looking for signs of trouble (which source files for example)?
> 
> sound/soc/davinci/davinci-pcm.c and the underlying DMA APIs it
> calls.  I wouldn't be surprised if either there had been some change
> in the DMA APIs that required an update in the driver or the DMA APIs
> haven't been fully merged.
> 
> Hopefully a comparison of the mainline and DaVinci trees will show
> something...

Anyone on the DaVinci mailing list that could shed some light on this
issue?

Thank-you, Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
