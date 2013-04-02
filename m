From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: add const for name parameter
Date: Tue, 2 Apr 2013 23:21:28 +0530
Message-ID: <20130402175128.GN10326@intel.com>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <1363318601-31505-2-git-send-email-shawn.guo@linaro.org>
 <20130315085346.GA22650@pengutronix.de>
 <20130321094753.GN10326@intel.com>
 <20130321145728.GD23109@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id E595626524E
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 20:19:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130321145728.GD23109@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sebastien Guiriec <s-guiriec@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2013 at 10:57:30PM +0800, Shawn Guo wrote:
> Vinod,
> 
> On Thu, Mar 21, 2013 at 03:17:53PM +0530, Vinod Koul wrote:
> > On Fri, Mar 15, 2013 at 09:53:46AM +0100, Markus Pargmann wrote:
> > > Hi,
> > > 
> > > I already sent a nearly identical patch:
> > > https://patchwork.kernel.org/patch/2179321/
> > I applied that one a while ago so Markus can you check my tree and see if
> > anything is remaining, looks most of cases are covered
> > 
> Can you maintain that patch on a topic branch, so that we can ask Mark
> to pull it as dependency for the soc-dmaengine-pcm patch that support
> generic DMA binding users?
Looks like i never replied to this one, althoug I have pushed a branch

Mark,

You can pull commit a0c43a3 from topic/of or the entire branch into your tree

--
Thanks
~Vinod
