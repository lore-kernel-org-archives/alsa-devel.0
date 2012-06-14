From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma
	support
Date: Thu, 14 Jun 2012 16:13:58 +0530
Message-ID: <1339670638.1927.1641.camel@vkoul-udesk3>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
	<1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Qiao Zhou <zhouqiao@marvell.com>, Chao Xie <cxie4@marvell.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-11 at 18:04 +0800, Zhangfei Gao wrote:
> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
> +{
> +       u32 reg = readl(tdmac->reg_base + TDISR);
> +
> +       if (reg & TDISR_COMP) {
> +               /* clear irq */
> +               reg &= ~TDISR_COMP;
> +               writel(reg, tdmac->reg_base + TDISR);
> +
> +               return 0;
> +       }
> +       return -1;
> +} 
-1?
Please return a proper linux error code.


-- 
~Vinod

