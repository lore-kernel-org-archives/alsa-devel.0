From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
 machine kcontrols.
Date: Mon, 06 Feb 2012 23:39:12 +0530
Message-ID: <1328551752.26182.141.camel@vkoul-udesk3>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
	<1328537786.6799.16.camel@odin>
	<20120206142559.GJ3070@opensource.wolfsonmicro.com>
	<1328541116.26182.99.camel@vkoul-udesk3>
	<20120206151737.GK3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DA48A103B98
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 19:07:21 +0100 (CET)
In-Reply-To: <20120206151737.GK3070@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-02-06 at 15:17 +0000, Mark Brown wrote:
> On Mon, Feb 06, 2012 at 08:41:56PM +0530, Vinod Koul wrote:
> 
> > Hopefully I got the context right :)
> > So a machine driver should not add codec_controls but do a
> > card_controls, right?
> 
> Yes, or rather if the machine driver is peering into the CODEC internals
> at all something went wrong.
Yes it was wrongly done due to "historical" reasons. We should ideally
move this to codec driver... Let me see how I can fix this up :)

-- 
~Vinod
