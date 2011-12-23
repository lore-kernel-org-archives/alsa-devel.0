From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
Date: Fri, 23 Dec 2011 22:02:50 +0530
Message-ID: <1324657970.1633.22.camel@vkoul-udesk3>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
	<1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
	<1324656420.1633.15.camel@vkoul-udesk3>
	<20111223162826.GA28036@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 472CD104000
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 17:32:49 +0100 (CET)
In-Reply-To: <20111223162826.GA28036@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Dong Aisheng <dong.aisheng@linaro.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-23 at 16:28 +0000, Mark Brown wrote:
> On Fri, Dec 23, 2011 at 09:37:00PM +0530, Vinod Koul wrote:
> 
> > Has this been applied in soc tree? I don't see it in linux-next or do
> > you want this to go thru slave-dma?
> 
> I reverted it, it needs to go with the commit that introduces the new
> API otherwise it breaks bisection.
Okay thanks,

Those are is in my next so I will apply this one to my next as well.

-- 
~Vinod
