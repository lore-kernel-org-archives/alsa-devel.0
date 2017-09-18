From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: eve: Enable mclk and ssp
	sclk early
Date: Mon, 18 Sep 2017 09:17:10 +0530
Message-ID: <20170918034710.GI30097@localhost>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
 <1505021600-20416-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E6BFC266819
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 05:43:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505021600-20416-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 10, 2017 at 11:03:20AM +0530, Naveen M wrote:
> rt5663 needs mclk/sclk early to synchronize its internal clocks.
> Clocks are enabled in hw_params and disabled in platform_clk_control
> as the codec requires mclk/bclk need to turned ON before set_sysclk
> call for a successful clock synchronization.

ah there was a v2, sorry missed that.

> 
> Depends-on: patch series ("ASoC: Intel: Skylake: Add a clk driver to
> enable ssp clks early")
> ASoC: Intel: kbl: Enable mclk and ssp sclk early
> ASoC: Intel: Skylake: Modify skl_dsp_set_dma_control API arguments
> ASoC: Intel: Skylake: Parse nhlt to populate clock information
> ASoC: Intel: Skylake: Prepare DMA control IPC to enable/disable clock
> ASoC: Intel: Skylake: Register clock device and ops
> ASoC: Intel: Skylake: Add ssp clock driver

this is good info but is useless for applying
> 
> Signed-off-by: Naveen M <naveen.m@intel.com>
> Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
> 
> V2: Add Depends-on

you have removed the dashes after s-o-b, so when I apply this patch the
depends on, V2 also get applied.

It is go d practice to apply the .patch file yourself after hand editing and
seeing if the output is something you really want.

Can you fix this along with comments on V1.
-- 
~Vinod
