From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v6 1/4] ASoC: Intel: select DW_DMAC_CORE
 since it's mandatory
Date: Tue, 17 Jan 2017 11:17:52 +0000
Message-ID: <1484651872.2604.211.camel@loki>
References: <20170116131229.102820-1-andriy.shevchenko@linux.intel.com>
 <20170116131229.102820-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 95AD52667D3
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 12:18:01 +0100 (CET)
In-Reply-To: <20170116131229.102820-2-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-01-16 at 15:12 +0200, Andy Shevchenko wrote:
> Select DW_DMAC_CORE like the rest of glue drivers do, e.g.
> drivers/dma/dw/Kconfig.
> 
> While here group selectors under SND_SOC_INTEL_HASWELL and
> SND_SOC_INTEL_BAYTRAIL.
> 
> Make platforms, which are using a common SST firmware driver, to be
> dependent on DMADEVICES.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
