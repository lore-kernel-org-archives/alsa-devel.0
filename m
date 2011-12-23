From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: mxs: correct 'direction' of
 device_prep_dma_cyclic
Date: Fri, 23 Dec 2011 16:28:27 +0000
Message-ID: <20111223162826.GA28036@opensource.wolfsonmicro.com>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org>
	<1323848866-19768-1-git-send-email-shawn.guo@linaro.org>
	<1324656420.1633.15.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2DA54103FB4
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 17:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324656420.1633.15.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 09:37:00PM +0530, Vinod Koul wrote:

> Has this been applied in soc tree? I don't see it in linux-next or do
> you want this to go thru slave-dma?

I reverted it, it needs to go with the commit that introduces the new
API otherwise it breaks bisection.
