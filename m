From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 16:07:23 -0600
Message-ID: <4D263D1B.7040506@freescale.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
	<4D262B29.3010606@freescale.com>
	<20110106213139.GG8018@opensource.wolfsonmicro.com>
	<4D2635BC.1080108@freescale.com>
	<20110106220406.GI8018@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 18BD4103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 23:07:34 +0100 (CET)
In-Reply-To: <20110106220406.GI8018@opensource.wolfsonmicro.com>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> That'd be Liam in the multi-component conversion, though obviously that
> didn't cause any immediate issues.  The shared I/O code has been present
> since mid 2009 though, including the cache management.  This kind of
> comes back to what I'm saying about making your code as idiomatic as
> possible, the more a given piece of code diverges from standard idioms
> the more likely it is that it will be unintentially broken by some other
> change.

My code *was* idiomatic the last time I touched it, which was early 2009.

> FWIW using the standard stuff should just be a case providing defaults,
> calling snd_soc_set_cache_io() and removing your custom I/O functions.

Ok, I'll take a look at it tomorrow.

You'd think the guys at Crystal Semi would at least give me a free coffee mug or
something.

-- 
Timur Tabi
Linux kernel developer at Freescale
