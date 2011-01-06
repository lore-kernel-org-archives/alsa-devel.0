From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 22:04:06 +0000
Message-ID: <20110106220406.GI8018@opensource.wolfsonmicro.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
	<4D262B29.3010606@freescale.com>
	<20110106213139.GG8018@opensource.wolfsonmicro.com>
	<4D2635BC.1080108@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14790103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 23:03:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D2635BC.1080108@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 06, 2011 at 03:35:56PM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> > If you're completely ignoring the standard cache and register I/O code
> > (which isn't ideal) then you should't be telling the core about your
> > cache.

> Tell that to the person who hacked up my driver and apparently broke it.  I'm
> now playing catch-up.  I need to learn all about this (new) register cache
> feature and then try to figure out how to make it work in my driver.

That'd be Liam in the multi-component conversion, though obviously that
didn't cause any immediate issues.  The shared I/O code has been present
since mid 2009 though, including the cache management.  This kind of
comes back to what I'm saying about making your code as idiomatic as
possible, the more a given piece of code diverges from standard idioms
the more likely it is that it will be unintentially broken by some other
change.

FWIW using the standard stuff should just be a case providing defaults,
calling snd_soc_set_cache_io() and removing your custom I/O functions.
