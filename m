From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Tue, 29 May 2012 10:48:54 +0530
Message-ID: <1338268734.1580.26.camel@vkoul-udesk3>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
	<1337932416.1580.2.camel@vkoul-udesk3>
	<20120525080500.GB24149@n2100.arm.linux.org.uk>
	<CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
	<20120525094231.GC24149@n2100.arm.linux.org.uk>
	<CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A8BF248EA
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 07:25:08 +0200 (CEST)
In-Reply-To: <CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-05-29 at 13:14 +0800, zhangfei gao wrote:
> 
> When debugging with putting snd_dmaengine_pcm_open to probe or
> pcm_new, there is issue.
> snd_dmaengine_pcm_open ->
> snd_pcm_hw_constraint_integer(substream->runtime,
> 
> SNDRV_PCM_HW_PARAM_PERIODS);
> The runtime is only exist at runtime.
> So if using soc-dmaengine, I am afraid the snd_dmaengine_pcm_open has
> to be put in open instead of probe. 
I think you got it wrong, the snd_dmaengine_pcm_open needs to be called
from your CPU pcm_open. See other examples how this is used in other
drivers.

-- 
~Vinod
