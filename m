From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/4] ASoC: Intel: clean up Kconfig
Date: Tue, 10 Jan 2017 14:34:08 +0530
Message-ID: <20170110090408.GD3573@localhost>
References: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F4D4266DB0
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 10:04:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170107123250.52930-1-andriy.shevchenko@linux.intel.com>
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
Cc: dmaengine <dmaengine@vger.kernel.org>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 07, 2017 at 02:32:46PM +0200, Andy Shevchenko wrote:
> Clean up Kconfig here:
> - select DW_DMAC_CORE because it's mandatory for some modules
> - remove redundant selects and dependencies
> - rename MFLD_PLATFORM to ATOM_HIFI2_PLATFORM to show that it covers more than *Field

Looks good to me,

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
