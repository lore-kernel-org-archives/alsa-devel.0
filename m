From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Remove support for Intel
 MID DMA from firmware loader
Date: Wed, 18 Mar 2015 13:54:00 +0200
Message-ID: <1426679640.14897.359.camel@linux.intel.com>
References: <1426666040-1727-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150318114355.GE2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 45BC32605F2
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 12:54:04 +0100 (CET)
In-Reply-To: <20150318114355.GE2869@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jin Yao <yao.jin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-03-18 at 11:43 +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 10:07:19AM +0200, Jarkko Nikula wrote:
> > Intel MID DMA driver is going to be removed by the coming commit
> > 36111da7838e ("dmaengine: intel-mid-dma: remove the driver") in spi.git
> > tree. Since there are no users for SST_DMA_TYPE_MID type the support for it
> > can be removed from here in advance.
> 
> So "only user" wasn't exactly true there then...

SST has support of both intel_mid_dma and dw_dmac for a while, but SPI
DW hasn't. That's why the only user.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
