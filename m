From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 05 May 2011 20:25:43 +0530
Message-ID: <1304607343.20953.54.camel@vkoul-udesk3>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
	<20110505080556.GA11744@opensource.wolfsonmicro.com>
	<1304587732.20953.50.camel@vkoul-udesk3>
	<20110505102642.GJ11744@opensource.wolfsonmicro.com>
	<1304589659.20953.52.camel@vkoul-udesk3>
	<20110505134644.GL11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 4451B103A0A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 17:27:59 +0200 (CEST)
In-Reply-To: <20110505134644.GL11744@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Lu,
	Guanqun" <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-05-05 at 19:16 +0530, Mark Brown wrote:
> On Thu, May 05, 2011 at 03:30:59PM +0530, Koul, Vinod wrote:
> > On Thu, 2011-05-05 at 15:56 +0530, Mark Brown wrote:
> 
> > > Are there a fixed number of channels to the DSP or are these virtual?
> 
> > Channels are fixed...
> 
> OK, DAIs make sense then - I'd been concerned that these weren't fixed
> and might need to be virtualised.
So how do we go about making them virtual? Thaat might be useful for
some other things I had in mind...

-- 
~Vinod
