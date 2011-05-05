From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 5 May 2011 11:26:43 +0100
Message-ID: <20110505102642.GJ11744@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
	<20110505080556.GA11744@opensource.wolfsonmicro.com>
	<1304587732.20953.50.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7E1B1039D7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 12:27:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304587732.20953.50.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Lu,
	Guanqun" <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:58:52PM +0530, Koul, Vinod wrote:
> On Thu, 2011-05-05 at 13:35 +0530, Mark Brown wrote:

> > What does this DAI actually represent?  I'd assume from the description
> > that it's another interface on the same CPU?

> The sst-platfrom driver sends the DAI ops to SST driver which sends to
> FW running on DSP.
> So it essentially represent the DSP side
> Note here DSP does DMA and sending data to PCM port.

Are there a fixed number of channels to the DSP or are these virtual?
