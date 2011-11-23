From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 23 Nov 2011 16:31:26 +0000
Message-ID: <20111123163126.GF30049@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<20111123160253.GD30049@opensource.wolfsonmicro.com>
	<1322064992.1516.311.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAEB6103B0D
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 17:31:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322064992.1516.311.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 09:46:32PM +0530, Vinod Koul wrote:
> On Wed, 2011-11-23 at 16:02 +0000, Mark Brown wrote:

> > The core code shouldn't know anything about ASoC, ASoC should be able
> > to
> > use the core API like any other card driver.

> I was thinking that during the compress stream open, the core will
> trigger the asoc to turn on the codec. For that purpose it needs to call
> asoc, hence the comment.

I'd expect ASoC to drop in here in the same way as it drops into the
other core APIs with ASoC wrapping and indirecting the core APIs for
drivers working within ASoC rather than the core calling down into ASoC.
