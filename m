From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Fix block is enabled multiple
	times issue
Date: Fri, 31 Oct 2014 02:23:38 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901B500B1@SHSMSX101.ccr.corp.intel.com>
References: <1414675312-7667-1-git-send-email-yang.jie@intel.com>
 <20141030134132.GX18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E75C260668
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 03:25:10 +0100 (CET)
In-Reply-To: <20141030134132.GX18557@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, October 30, 2014 9:42 PM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [PATCH] ASoC: Intel: Fix block is enabled multiple times issue
> 
> On Thu, Oct 30, 2014 at 09:21:52PM +0800, Jie Yang wrote:
> > During FW parsing and loading, block_list_prepare() may be called for
> > each raw data block copying and this may made the hsw_block_enable()
> > called mutiple times, which increase block->users many times. The
> > result of this is
> > hsw_block_disable() can't power gated the related block when trying to
> > free the blocks during suspend, and the power gating status also
> > confused.
> 
> Applied, thanks.
[Keyon] thanks, Mark. BTW, can you share your rule about which branch do you apply patches on usually?
I ask this because I can't find applied patch on any branch(topic/intel, for-next, for-linus, fix/core, fix/intel...). :(
