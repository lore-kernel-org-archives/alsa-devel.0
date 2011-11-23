From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 23 Nov 2011 22:04:11 +0530
Message-ID: <1322066051.1516.320.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<20111123160253.GD30049@opensource.wolfsonmicro.com>
	<1322064992.1516.311.camel@vkoul-udesk3>
	<20111123163126.GF30049@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 10B05103CC0
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 17:38:10 +0100 (CET)
In-Reply-To: <20111123163126.GF30049@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-23 at 16:31 +0000, Mark Brown wrote:
> On Wed, Nov 23, 2011 at 09:46:32PM +0530, Vinod Koul wrote:
> > On Wed, 2011-11-23 at 16:02 +0000, Mark Brown wrote:
> 
> > > The core code shouldn't know anything about ASoC, ASoC should be able
> > > to
> > > use the core API like any other card driver.
> 
> > I was thinking that during the compress stream open, the core will
> > trigger the asoc to turn on the codec. For that purpose it needs to call
> > asoc, hence the comment.
> 
> I'd expect ASoC to drop in here in the same way as it drops into the
> other core APIs with ASoC wrapping and indirecting the core APIs for
> drivers working within ASoC rather than the core calling down into ASoC.
That sounds okay to me as well :)

Thanks for your review.

I will send next version tomorrow after testing.

-- 
~Vinod
