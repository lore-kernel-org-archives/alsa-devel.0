From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Thu, 3 Jun 2010 12:57:22 +0100
Message-ID: <20100603115721.GA2762@rakim.wolfsonmicro.main>
References: <1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
	<20100601033023.GA24820@www.longlandclan.yi.org>
	<20100601050731.GB24820@www.longlandclan.yi.org>
	<20100601113224.GA14493@www.longlandclan.yi.org>
	<20100603111455.GF10031@sirena.org.uk>
	<20100603114349.GC3662@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 983172440B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 13:57:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100603114349.GC3662@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, Eric B?nard <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 03, 2010 at 09:43:49PM +1000, Stuart Longland wrote:

> I will have a look at that.  Out of interest, is there an up-to-date
> guide on this information?  I'm finding it difficult to find all these
> functions, much less understand what they do.

If you generate the kerneldoc it should cover most things I guess.

> I'm working on the mixer interface at present... as the ADC won't record
> anything useful unless the mixer is configured right.  My problem
> though, is trying to understand what all the macros do.  Is there a good
> reference on how to write these drivers?

Not really - in general it's just a question of looking at each
individual control that the device has and mapping that into the ASoC
domain.  There's generally a 1:1 mapping between the controls in the
register map and ASoC.
