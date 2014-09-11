From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] dma: mmp_tdma: add DMA_PREP_INTERRUPT
	flag support
Date: Thu, 11 Sep 2014 10:48:26 +0530
Message-ID: <20140911051826.GD3131@intel.com>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B34F5265619
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 07:41:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, linux@arm.linux.org.uk, tiwai@suse.de, lgirdwood@gmail.com, haojian.zhuang@gmail.com, broonie@kernel.org, zhangfei.gao@gmail.com, dmaengine@vger.kernel.org, eric.y.miao@gmail.com, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2014 at 04:40:48PM +0800, Qiao Zhou wrote:
> add DMA_PREP_INTERRUPT flag to support no_period_wakeup, in which
> user space app doesn't want audio interrupt to wake up audio threads.
> 

Applied now, after fixing subsystem name.

-- 
~Vinod
