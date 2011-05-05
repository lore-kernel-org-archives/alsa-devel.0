From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 05 May 2011 14:58:52 +0530
Message-ID: <1304587732.20953.50.camel@vkoul-udesk3>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
	<20110505080556.GA11744@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 40FCC1039D7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 12:01:08 +0200 (CEST)
In-Reply-To: <20110505080556.GA11744@opensource.wolfsonmicro.com>
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

On Thu, 2011-05-05 at 13:35 +0530, Mark Brown wrote:
> On Thu, May 05, 2011 at 08:53:01AM +0530, Koul, Vinod wrote:
> 
> > Nope, We cant keep on adding these DAIs for every new platform :(
> > Even the current way is not best as it just creates 4 instance of DAI
> > where we could have done with two (as they have same properties)
> > I would use the current headset DAI and change the ops there, or create
> > a new one for each type so that it can be reused.
> 
> What does this DAI actually represent?  I'd assume from the description
> that it's another interface on the same CPU?
The sst-platfrom driver sends the DAI ops to SST driver which sends to
FW running on DSP.
So it essentially represent the DSP side
Note here DSP does DMA and sending data to PCM port.

-- 
~Vinod
